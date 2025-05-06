import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skyline_template_app/viewmodels/add_card_viewmodel.dart';
import 'package:skyline_template_app/core/utilities/constants.dart';
import 'package:stacked/stacked.dart';
import 'package:skyline_template_app/locator.dart';

class AddCardView extends StatefulWidget {
  @override
  _genTeacherViewState createState() => _genTeacherViewState();
}

class _genTeacherViewState extends State<AddCardView> {
  List<dynamicWidget> dynamicList = [];
  List<String> AnswerList = [];
  List<String> QuestionList = [];
  String lessonId = "";
  TextEditingController lesson_controller = new TextEditingController();
  AddCardViewModel? parentViewModel;
  bool floatingButtomPressed = false;

  @override
  Widget build(BuildContext context) {
    Widget dynamicTextField = Flexible(
      flex: 2,
      child: ListView.builder(
        itemCount: dynamicList.length,
        itemBuilder: (_, index) => dynamicList[index],
      ),
    );

    Widget lessonTextField = Container(
      width: 200,
      padding: EdgeInsets.fromLTRB(25, 75, 25, 25),
      child: TextFormField(
        controller: lesson_controller,
        decoration: InputDecoration(
          labelText: 'Add Lesson',
          filled: true,
          fillColor: kColorPureWhite,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kColorHoneyYellow, width: 1.5),
            borderRadius: BorderRadius.circular(16),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: kColorWoodBrown, width: 2),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );

    Widget submitButton = Container(
      margin: EdgeInsets.only(top: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: kColorHoneyYellow,
          foregroundColor: kColorBeeBrown,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: StadiumBorder(),
        ),
        onPressed: submitData,
        child: Text('🍯 Submit Flashcards'),
      ),
    );

    Widget result = Flexible(
      flex: 1,
      child: Card(
        color: kColorHoneyCream,
        child: ListView.builder(
          itemCount: QuestionList.length,
          itemBuilder: (_, index) {
            return Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 500,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: kColorBeeBrown.withOpacity(0.3)),
                      color: kColorPureWhite,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "🍯 ${index + 1}: ${QuestionList[index]} → ${AnswerList[index]}",
                        style: TextStyle(fontSize: 18, color: kColorBeeBrown),
                      ),
                    ),
                  ),
                  Divider(),
                ],
              ),
            );
          },
        ),
      ),
    );

    return ViewModelBuilder<AddCardViewModel>.reactive(
      viewModelBuilder: () => locator<AddCardViewModel>(),
      disposeViewModel: false,
      onModelReady: (viewModel) => init(viewModel),
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: kColorHoneyCream,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: kColorBeeBrown),
            onPressed: () {
              parentViewModel?.routeToMenuView();
            },
          ),
          title: Text(
            '🍯 Add Flashcards',
            style: TextStyle(color: kColorBeeBrown),
          ),
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [kColorHoneyCream, Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: <Widget>[
                QuestionList.length == 0 ? lessonTextField : Container(),
                QuestionList.length == 0 ? dynamicTextField : result,
                QuestionList.length == 0 ? submitButton : Container(),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: kColorWoodBrown,
          onPressed: addDynamic,
          child: Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }

  init(AddCardViewModel viewModel) {
    viewModel.init();
    parentViewModel = viewModel;
  }

  submitData() {
    print('inside submit data \$floatingButtomPressed');
    QuestionList = [];
    AnswerList = [];
    dynamicList.forEach((widget) => QuestionList.add(widget.question_controller.text));
    dynamicList.forEach((widget) => AnswerList.add(widget.answer_controller.text));
    lessonId = lesson_controller.text;

    if (parentViewModel != null) {
      parentViewModel?.addCards(QuestionList, AnswerList, lessonId);
    }
    setState(() {});
  }

  addDynamic() {
    print('Inside add dynamic');
    floatingButtomPressed = true;
    if (QuestionList.length != 0) {
      QuestionList = [];
      AnswerList = [];
      dynamicList = [];
      lesson_controller.text = "";
    }
    setState(() {});
    if (dynamicList.length >= 10) return;
    dynamicList.add(dynamicWidget());
  }
}

class dynamicWidget extends StatelessWidget {
  TextEditingController question_controller = TextEditingController();
  TextEditingController answer_controller = TextEditingController();
  String _temp = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: kColorPureWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kColorHoneyYellow),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: TextFormField(
              controller: question_controller,
              decoration: InputDecoration(
                labelText: 'Question',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            flex: 1,
            child: TextFormField(
              controller: answer_controller,
              decoration: InputDecoration(
                labelText: 'Answer',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void printTextFieldValue() {
    print("------------value--------- \$_temp");
  }

  TextFormField buildTextField(int index) {
    return TextFormField(
      controller: question_controller,
      onChanged: (v) => _temp = v,
      decoration: InputDecoration(hintText: 'Enter your friend\'s name'),
      validator: (v) {
        if (v!.trim().isEmpty) return 'Please enter something';
        return null;
      },
    );
  }
}