import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skyline_template_app/core/utilities/route_names.dart';
import 'package:skyline_template_app/viewmodels/base_viewmodel.dart';
import 'package:skyline_template_app/core/enums/view_state.dart';
import 'package:skyline_template_app/model/FlashCard.dart';
import 'package:skyline_template_app/core/services/navigation_service.dart';
import 'package:skyline_template_app/locator.dart';
import 'dart:async';

class PlayGameViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  List<String> lessonIds = [];
  String selectedLesson = "";
  List<FlashCard> flashcards = [];

  List<String> _cards = []; // Questions and Answers
  Map<int, String> _revealedValues = {};
  int? _firstIndex;
  int? _secondIndex;
  bool _waiting = false;

  bool pageLoaded = false;
  int cardsPerBatch = 8;
  int currentBatchIndex = 0;

  List<FlashCard> get currentBatch => flashcards
      .skip(currentBatchIndex * cardsPerBatch)
      .take(cardsPerBatch)
      .toList();

  List<String> get cards => _cards;
  Map<int, String> get revealedValues => _revealedValues;

  Future<void> init() async {
    setState(ViewState.Busy);
    try {
      await readMapsFromDB("");
      pageLoaded = true;
    } catch (e) {
      setState(ViewState.Error);
      print("Error in init: $e");
    }
    setState(ViewState.Idle);
  }

  Future<void> readMapsFromDB(String currentLesson) async {
    setState(ViewState.Busy);
    if (lessonIds.isEmpty) {
      try {
        final snapshot = await FirebaseFirestore.instance.collection('flash_cards').get();
        lessonIds = snapshot.docs.map((doc) => doc.id).toList();
      } catch (e) {
        print("Error fetching lesson IDs: $e");
        setState(ViewState.Idle);
        return;
      }
    }

    if (currentLesson.isEmpty && lessonIds.isNotEmpty) {
      currentLesson = lessonIds.first;
    }

    if (!lessonIds.contains(currentLesson)) {
      print("Invalid lesson ID: $currentLesson");
      setState(ViewState.Idle);
      return;
    }

    try {
      final doc = await FirebaseFirestore.instance.collection('flash_cards').doc(currentLesson).get();
      selectedLesson = currentLesson;

      final data = doc.data();
      final Map<String, dynamic> sets = Map<String, dynamic>.from(data?['sets'] ?? {});
      flashcards = sets.entries
          .map((entry) => FlashCard(question: entry.key, answer: entry.value.toString()))
          .toList();

      currentBatchIndex = 0;
      prepareGameBoard();
      notifyListeners();
    } catch (e) {
      print("Error reading flashcards: $e");
    }
    setState(ViewState.Idle);
  }

  void prepareGameBoard() {
    _cards = [];
    final batch = currentBatch;
    for (var flashcard in batch) {
      _cards.add(flashcard.question);
      _cards.add(flashcard.answer);
    }
    _cards.shuffle();
    _revealedValues.clear();
    _firstIndex = null;
    _secondIndex = null;
    _waiting = false;
    notifyListeners();
  }

  void goToNextBatch() {
    if ((currentBatchIndex + 1) * cardsPerBatch < flashcards.length) {
      currentBatchIndex++;
      prepareGameBoard();
    }
  }

  void handleCardTap(int index) {
    if (_waiting || _revealedValues.containsKey(index)) return;

    _revealedValues[index] = _cards[index];
    notifyListeners();

    if (_firstIndex == null) {
      _firstIndex = index;
    } else if (_secondIndex == null && index != _firstIndex) {
      _secondIndex = index;
      checkMatch();
    }
  }

  void checkMatch() {
    _waiting = true;
    notifyListeners();

    Future.delayed(Duration(seconds: 1), () {
      String firstVal = _cards[_firstIndex!];
      String secondVal = _cards[_secondIndex!];
      bool isMatch = false;

      for (var card in flashcards) {
        if ((firstVal == card.question && secondVal == card.answer) ||
            (firstVal == card.answer && secondVal == card.question)) {
          isMatch = true;
          break;
        }
      }

      if (!isMatch) {
        _revealedValues.remove(_firstIndex);
        _revealedValues.remove(_secondIndex);
      }

      _firstIndex = null;
      _secondIndex = null;
      _waiting = false;
      notifyListeners();
    });
  }

  void routeToMenuView() {
    _navigationService.navigateTo(MenuViewRoute);
  }

  void routeToPlayGameView() {
    _navigationService.navigateTo(PlayGameViewRoute);
  }
}
