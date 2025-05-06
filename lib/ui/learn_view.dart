import 'package:flutter/material.dart';
import 'package:skyline_template_app/viewmodels/learn_viewmodel.dart';
import 'package:skyline_template_app/core/utilities/constants.dart';
import 'package:stacked/stacked.dart';

class LearnView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LearnViewModel>.reactive(
      viewModelBuilder: () => LearnViewModel(),
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: kColorHoneyCream,
        appBar: AppBar(
          title: Text("Smart Learn"),
          backgroundColor: kColorHoneyYellow,
        ),
        body: model.pageLoaded
            ? SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (model.lessonIds.isNotEmpty)
                    DropdownButton<String>(
                      value: model.selectedLesson.isEmpty ? null : model.selectedLesson,
                      hint: Text("Select a lesson", style: TextStyle(color: kColorBeeBrown)),
                      dropdownColor: kColorHiveClay,
                      items: model.lessonIds.map((lessonId) {
                        return DropdownMenuItem(
                          value: lessonId,
                          child: Text(lessonId, style: TextStyle(color: kColorBeeBrown)),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) model.selectLesson(value);
                      },
                    )
                  else
                    Text("No lessons available.", style: TextStyle(color: Colors.redAccent)),
                  const SizedBox(height: 24),
                  if (model.currentCard != null) ...[
                    Text(
                      model.currentCard!.question,
                      style: TextStyle(fontSize: 22, color: kColorBeeBrown),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    if (model.feedbackMessage != null)
                      Text(
                        model.feedbackMessage!,
                        style: TextStyle(
                          color: model.wasCorrect! ? Colors.green : Colors.red,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      )
                    else ...[
                      ElevatedButton(
                        onPressed: () => model.recordAnswer(true),
                        child: Text("I knew this"),
                        style: ElevatedButton.styleFrom(backgroundColor: kColorHoneyYellow),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () => model.recordAnswer(false),
                        child: Text("I didn't know"),
                        style: ElevatedButton.styleFrom(backgroundColor: kColorHoneyYellow),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: model.fetchHint,
                        child: Text("Hint"),
                        style: ElevatedButton.styleFrom(backgroundColor: kColorHoneyYellow),
                      ),
                      if (model.hint != null) ...[
                        SizedBox(height: 16),
                        Text(
                          "Hint: ${model.hint}",
                          style: TextStyle(color: kColorBeeBrown, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ]
                    ],
                    const SizedBox(height: 30),
                    Text(
                      "Seen: ${model.currentCard!.timesSeen}, Wrong: ${model.currentCard!.timesWrong}",
                      style: TextStyle(color: kColorBeeBrown),
                    ),
                  ] else if (model.selectedLesson.isNotEmpty) ...[
                    Text(
                      "No flashcards available for this lesson.",
                      style: TextStyle(color: Colors.redAccent, fontSize: 16),
                    ),
                  ] else ...[
                    Text(
                      "Please select a lesson to begin.",
                      style: TextStyle(color: kColorBeeBrown, fontSize: 16),
                    ),
                  ]
                ],
              ),
            ),
          ),
        )
            : Center(child: CircularProgressIndicator(color: kColorHoneyYellow)),
      ),
    );
  }
}