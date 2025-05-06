import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skyline_template_app/core/utilities/route_names.dart';
import 'package:skyline_template_app/viewmodels/base_viewmodel.dart';
import 'package:skyline_template_app/core/enums/view_state.dart';
import 'package:skyline_template_app/model/FlashCard.dart';
import 'package:skyline_template_app/core/services/navigation_service.dart';
import 'package:skyline_template_app/locator.dart';

class FlashCardViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  List<String> lessonIds = [];
  String selectedLesson = "";
  List<FlashCard> flashcards = [];
  List<FlashCard> questionCards = [];

  bool pageLoaded = false;

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
    lessonIds = [];
    flashcards = [];

    try {
      final snapshot = await FirebaseFirestore.instance.collection('flash_cards').get();

      for (var doc in snapshot.docs) {
        lessonIds.add(doc.id);

        if (currentLesson.isEmpty) {
          currentLesson = doc.id;
        }

        if (doc.id == currentLesson) {
          selectedLesson = currentLesson;

          final data = doc.data();
          final Map<String, dynamic> sets = Map<String, dynamic>.from(data['sets'] ?? {});
          flashcards = sets.entries
              .map((entry) => FlashCard(question: entry.key, answer: entry.value.toString()))
              .toList();
        }
      }
      refreshCardsFromDB();
      notifyListeners();
    } catch (e) {
      print("Error reading flashcards: $e");
    }
  }

  void refreshCardsFromDB() {
    questionCards.clear();
    questionCards.addAll(flashcards);
    questionCards.shuffle();
    notifyListeners();
  }

  void routeToMenuView() {
    _navigationService.navigateTo(MenuViewRoute);
  }
  void routeToLearnView() {
    _navigationService.navigateTo(LearnViewRoute);
  }
  void routeToPlayGameView() {
    _navigationService.navigateTo(PlayGameViewRoute);
  }
}

