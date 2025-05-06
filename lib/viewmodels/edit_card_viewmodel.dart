import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skyline_template_app/core/utilities/route_names.dart';
import 'package:skyline_template_app/viewmodels/base_viewmodel.dart';
import 'package:skyline_template_app/core/enums/view_state.dart';
import 'package:skyline_template_app/core/services/navigation_service.dart';
import 'package:skyline_template_app/locator.dart';
import 'package:skyline_template_app/model/FlashCard.dart';

class EditCardViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  List<String> lessonIds = [];
  String selectedLesson = "";
  List<FlashCard> flashcards = [];
  bool pageLoaded = false;

  Future<void> init() async {
    setState(ViewState.Busy);
    try {
      await readMapsFromDB("");
      pageLoaded = true;
    } catch (e) {
      print("Error loading cards: $e");
      setState(ViewState.Error);
    }
    setState(ViewState.Idle);
  }

  void addCards(List<String> questionList, List<String> answerList) {
    print('inside Add cards to db ***************');
    Map<String, String> pairMap = {};
    for (var i = 0; i < questionList.length; i++) {
      pairMap[questionList[i]] = answerList[i];
    }

    if (selectedLesson.isNotEmpty) {
      FirebaseFirestore.instance
          .collection("flash_cards")
          .doc(selectedLesson)
          .set({"sets": pairMap}, SetOptions(merge: true))
          .then((_) => print("Updated DB"));
    }

    readMapsFromDB(selectedLesson);
    notifyListeners();
  }

  void addEmptyCard() {
    flashcards.add(FlashCard(question: "", answer: ""));
    notifyListeners();
  }

  void removeLastCard() {
    if (flashcards.isNotEmpty) {
      flashcards.removeLast();
      notifyListeners();
    }
  }

  Future<void> readMapsFromDB(String currentLesson) async {
    lessonIds = [];
    flashcards = [];
    selectedLesson = "";

    try {
      final querySnapshot = await FirebaseFirestore.instance.collection('flash_cards').get();

      for (var doc in querySnapshot.docs) {
        lessonIds.add(doc.id);

        if (currentLesson.isEmpty || currentLesson == "toBeSet") {
          currentLesson = doc.id;
        }

        if (doc.id == currentLesson) {
          selectedLesson = currentLesson;

          Map<String, dynamic> data = doc.data();
          Map<String, dynamic> sets = Map<String, dynamic>.from(data['sets'] ?? {});

          flashcards = sets.entries
              .map((entry) => FlashCard(question: entry.key, answer: entry.value.toString()))
              .toList();
        }
      }

      notifyListeners();
    } catch (e) {
      print("Error reading maps from DB: $e");
    }
  }

  void routeToHomeView() {
    _navigationService.navigateTo(HomeViewRoute);
  }
}

