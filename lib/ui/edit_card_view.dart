import 'package:flutter/material.dart';
import 'package:skyline_template_app/model/FlashCard.dart';
import 'package:skyline_template_app/viewmodels/edit_card_viewmodel.dart';
import 'package:skyline_template_app/core/utilities/constants.dart';
import 'package:stacked/stacked.dart';
import 'package:skyline_template_app/locator.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';

class EditCardView extends StatelessWidget {
  List<DynamicWidget> questionCardWidgets = [];
  List<String> AnswerList = [];
  List<String> QuestionList = [];
  bool isStartGame = false;
  String selectedLesson = "";

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EditCardViewModel>.reactive(
      viewModelBuilder: () => locator<EditCardViewModel>(),
      disposeViewModel: false,
      onModelReady: (viewModel) async {
        await viewModel.init();
      },
      builder: (context, viewModel, child) => Scaffold(
        backgroundColor: kColorHoneyCream,
        appBar: AppBar(
          backgroundColor: kColorHoneyYellow,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: kColorBeeBrown),
            onPressed: () => viewModel.routeToHomeView(),
          ),
          title: Text("Edit Flashcards", style: TextStyle(color: kColorBeeBrown)),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Center(
                  child: Container(
                    width: 250,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: kColorPureWhite,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: kColorWoodBrown),
                    ),
                    child: DropDown<String>(
                      items: viewModel.lessonIds,
                      initialValue: viewModel.lessonIds.contains(viewModel.selectedLesson)
                          ? viewModel.selectedLesson
                          : (viewModel.lessonIds.isNotEmpty ? viewModel.lessonIds.first : null),
                      dropDownType: DropDownType.Button,
                      hint: Text("Select Lesson", style: TextStyle(color: kColorBeeBrown)),
                      onChanged: (String? value) {
                        if (value != null) {
                          viewModel.readMapsFromDB(value);
                          viewModel.selectedLesson = value;
                          viewModel.notifyListeners();
                        }
                      },
                      icon: Icon(Icons.expand_more, color: kColorBeeBrown),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 12,
                  children: [
                    _buildElevatedIconButton(
                      icon: Icons.add,
                      label: "Add",
                      color: kColorHoneyYellow,
                      onPressed: () {
                        questionCardWidgets.add(DynamicWidget());
                        viewModel.flashcards.add(FlashCard(question: '', answer: ''));
                        viewModel.notifyListeners();
                      },
                    ),
                    _buildElevatedIconButton(
                      icon: Icons.delete,
                      label: "Delete",
                      color: kColorHoneyYellow,
                      onPressed: () {
                        if (questionCardWidgets.isNotEmpty) {
                          questionCardWidgets.removeLast();
                          viewModel.flashcards.removeLast();
                          viewModel.notifyListeners();
                        }
                      },
                    ),
                    _buildElevatedIconButton(
                      icon: Icons.edit,
                      label: "Edit",
                      color: kColorHoneyYellow,
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("You can now edit the flashcards.")),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: kColorPureWhite,
                    border: Border.all(color: kColorWoodBrown, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: buildTextFieldList(viewModel),
                ),
                SizedBox(height: 20),
                Column(
                  children: [
                    _buildMainButton("Update Data", () => submitData(viewModel)),
                    SizedBox(height: 20),
                    _buildMainButton("Cancel and Return", () => viewModel.routeToHomeView()),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildElevatedIconButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      icon: Icon(icon, color: kColorBeeBrown),
      label: Text(label, style: TextStyle(color: kColorBeeBrown)),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: StadiumBorder(),
      ),
      onPressed: onPressed,
    );
  }

  Widget _buildMainButton(String text, VoidCallback onPressed) {
    return Center(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: kColorHoneyYellow,
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
          shape: StadiumBorder(),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: kColorBeeBrown),
        ),
      ),
    );
  }

  ListView buildTextFieldList(EditCardViewModel viewModel) {
    questionCardWidgets = [];
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.all(12),
      physics: NeverScrollableScrollPhysics(),
      itemCount: viewModel.flashcards.length,
      itemBuilder: (context, index) {
        DynamicWidget currentWidget = DynamicWidget();
        currentWidget.question_controller.text = viewModel.flashcards[index].question;
        currentWidget.answer_controller.text = viewModel.flashcards[index].answer;
        questionCardWidgets.add(currentWidget);
        return currentWidget;
      },
    );
  }

  void submitData(EditCardViewModel viewModel) {
    QuestionList = [];
    AnswerList = [];
    for (var widget in questionCardWidgets) {
      QuestionList.add(widget.question_controller.text);
      AnswerList.add(widget.answer_controller.text);
    }
    viewModel.addCards(QuestionList, AnswerList);
  }
}

class DynamicWidget extends StatelessWidget {
  final TextEditingController question_controller = TextEditingController();
  final TextEditingController answer_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: isSmallScreen
          ? Column(
        children: [
          _buildTextField("Question", question_controller),
          SizedBox(height: 10),
          _buildTextField("Answer", answer_controller),
        ],
      )
          : Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: _buildTextField("Question", question_controller)),
          SizedBox(width: 10),
          Expanded(child: _buildTextField("Answer", answer_controller)),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        fillColor: kColorHiveClay.withOpacity(0.2),
        filled: true,
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      ),
    );
  }
}