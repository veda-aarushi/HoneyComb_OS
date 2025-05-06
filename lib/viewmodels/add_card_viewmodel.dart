import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skyline_template_app/core/utilities/route_names.dart';
import 'package:skyline_template_app/viewmodels/base_viewmodel.dart';
import 'package:skyline_template_app/core/enums/view_state.dart';
import 'package:skyline_template_app/model/Teacher.dart';
import 'package:skyline_template_app/core/services/navigation_service.dart';
import 'package:skyline_template_app/locator.dart';
import 'package:faker/faker.dart';

class AddCardViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  List<Teacher> teachers = [];
  bool pageLoaded = false;

  Future init() async {
    print("Teacher ViewModel init()");
    setState(ViewState.Busy);
    try {
      _generateTeacherList(5);
      pageLoaded = true;
    } catch (e) {
      setState(ViewState.Error);
    }
    setState(ViewState.Idle);
  }

  List<Teacher> _generateTeacherList(int teacherCount) {
    if (!pageLoaded) {
      for (int i = 0; i < teacherCount; i++) {
        var faker = Faker();
        Teacher teacher = Teacher(
          uid: 'xxx$i',
          firstName: faker.person.firstName(),
          lastName: faker.person.lastName(),
          nickName: 'Cool Teacher $i',
          email: faker.internet.email(),
        );
        teachers.add(teacher);
      }
    }
    return teachers;
  }

  void addTeacher() {
    print('Adding teacher.firstName as a new teacher');
    loadFlashCardsFromDB();
    notifyListeners();
  }

  void setValue(int index) {
    print('setting value in setValue $index');
  }

  void routeToHomeView() {
    _navigationService.navigateTo(HomeViewRoute);
  }

  void routeToMenuView() {
    _navigationService.navigateTo(MenuViewRoute);
  }

  void loadFlashCardsFromDB() {
    print("inside load flashcards and Saving");

    FirebaseFirestore.instance.collection("flash_cards").doc("deck1").set({
      "name": "lesson1",
      "sets": [
        {"question": "question1", "answer": "answer1"},
        {"question": "question2", "answer": "answer2"},
        {"question": "question3", "answer": "answer3"}
      ]
    });

    FirebaseFirestore.instance
        .collection('flash_cards')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        print(" --- start collection names--- ");
        print('Found subcollection with id: ${doc.id}');
        print(" --- end collection names--- ");
      }
    });
  }

  void addCards(
      List<String> questionList,
      List<String> answerList,
      String lessonId,
      ) {
    print('inside Add cards to db ***************');
    Map<String, String> pairMap = {};
    for (var i = 0; i < questionList.length; i++) {
      pairMap[questionList[i]] = answerList[i];
    }

    FirebaseFirestore.instance
        .collection("flash_cards")
        .doc(lessonId)
        .set({"sets": pairMap}, SetOptions(merge: true));

    print('Updated DB');
  }
}