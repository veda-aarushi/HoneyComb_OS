// learn_viewmodel.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stacked/stacked.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class FlashCard {
  final String question;
  final String answer;
  int timesSeen;
  int timesCorrect;
  int timesWrong;
  bool isLastChoiceCorrect;

  FlashCard({
    required this.question,
    required this.answer,
    this.timesSeen = 0,
    this.timesCorrect = 0,
    this.timesWrong = 0,
    this.isLastChoiceCorrect = false,
  });
}

class LearnViewModel extends BaseViewModel {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  List<String> lessonIds = [];
  String selectedLesson = "";
  List<FlashCard> allCards = [];
  List<FlashCard> reviewQueue = [];

  FlashCard? currentCard;
  bool pageLoaded = false;
  String? feedbackMessage;
  bool? wasCorrect;
  String? hint;

  Future<void> init() async {
    // Load all lessons (document IDs in flash_cards collection)
    final lessonsSnapshot = await _db.collection('flash_cards').get();
    lessonIds = lessonsSnapshot.docs.map((doc) => doc.id).toList();
    pageLoaded = true;
    notifyListeners();
  }

  Future<void> selectLesson(String lessonId) async {
    selectedLesson = lessonId;
    final doc = await _db.collection('flash_cards').doc(lessonId).get();
    final Map<String, dynamic>? sets = doc.data()?['sets'];

    if (sets != null && sets.isNotEmpty) {
      allCards = sets.entries.map((entry) {
        return FlashCard(
          question: entry.key,
          answer: entry.value.toString(),
        );
      }).toList();

      reviewQueue = List.from(allCards);
      reviewQueue.shuffle();
      currentCard = reviewQueue.isNotEmpty ? reviewQueue.removeAt(0) : null;
    } else {
      currentCard = null;
    }

    notifyListeners();
  }

  void recordAnswer(bool isCorrect) {
    if (currentCard == null) return;

    currentCard!.timesSeen++;
    wasCorrect = isCorrect;
    hint = null;

    if (isCorrect) {
      currentCard!.timesCorrect++;
      feedbackMessage = "Correct! The answer is ${currentCard!.answer}.";
      Future.delayed(Duration(seconds: 2), () {
        reviewQueue.add(currentCard!);
        _nextCard();
      });
    } else {
      currentCard!.timesWrong++;
      feedbackMessage = "Oops! The answer is ${currentCard!.answer}.";
      Future.delayed(Duration(seconds: 2), () {
        reviewQueue.insert(1, currentCard!);
        _nextCard();
      });
    }

    notifyListeners();
  }

  void _nextCard() {
    feedbackMessage = null;
    wasCorrect = null;
    hint = null;
    if (reviewQueue.isNotEmpty) {
      currentCard = reviewQueue.removeAt(0);
    } else {
      currentCard = null;
    }
    notifyListeners();
  }

  Future<void> fetchHint() async {
    if (currentCard == null) return;

    final apiKey = dotenv.env['OPENAI_API_KEY'];
    if (apiKey == null || apiKey.isEmpty) {
      hint = "⚠️ API key not set. Please check .env";
      notifyListeners();
      return;
    }

    final prompt = "Give a short helpful hint for the question: ${currentCard!
        .question}";

    try {
      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": [
            {"role": "system", "content": "You are a helpful flashcard tutor."},
            {"role": "user", "content": prompt}
          ],
          "max_tokens": 50
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        hint = data['choices'][0]['message']['content'];
      } else {
        hint = "⚠️ Hint request failed (${response.statusCode})";
      }
    } catch (e) {
      hint = "⚠️ Failed to fetch hint: $e";
    }

    notifyListeners();
  }
}
