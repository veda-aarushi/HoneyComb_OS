import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:skyline_template_app/viewmodels/play_game_viewmodel.dart';
import 'package:skyline_template_app/core/utilities/constants.dart';

class PlayGameView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PlayGameViewModel>.reactive(
      viewModelBuilder: () => PlayGameViewModel(),
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: kColorHoneyCream,
        appBar: AppBar(
          title: Text("🍯 HoneyComb Memory Game"),
          backgroundColor: kColorHoneyYellow,
          foregroundColor: kColorBeeBrown,
        ),
        body: model.pageLoaded
            ? Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              if (model.lessonIds.isNotEmpty)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: kColorPureWhite,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: kColorWoodBrown),
                  ),
                  child: DropdownButton<String>(
                    value: model.selectedLesson.isEmpty ? null : model.selectedLesson,
                    hint: Text("Select a lesson", style: TextStyle(color: kColorBeeBrown)),
                    dropdownColor: kColorHoneyCream,
                    items: model.lessonIds.map((lessonId) {
                      return DropdownMenuItem(
                        value: lessonId,
                        child: Text(lessonId, style: TextStyle(color: kColorBeeBrown)),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) model.readMapsFromDB(value);
                    },
                    icon: Icon(Icons.expand_more, color: kColorBeeBrown),
                    underline: SizedBox(),
                  ),
                ),
              const SizedBox(height: 16),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 2,
                  ),
                  itemCount: model.cards.length,
                  itemBuilder: (context, index) {
                    final isRevealed = model.revealedValues.containsKey(index);
                    final displayText = isRevealed ? model.cards[index] : "?";

                    return GestureDetector(
                      onTap: () => model.handleCardTap(index),
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          color: isRevealed ? kColorPureWhite : kColorHoneyYellow,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Center(
                            child: AutoSizeText(
                              displayText,
                              maxLines: 4,
                              minFontSize: 14,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: isRevealed ? kColorBeeBrown : kColorBeeBrown,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              if ((model.currentBatchIndex + 1) * model.cardsPerBatch < model.flashcards.length)
                ElevatedButton(
                  onPressed: model.goToNextBatch,
                  child: Text("Next Stack"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kColorHoneyYellow,
                    foregroundColor: kColorBeeBrown,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                ),
            ],
          ),
        )
            : Center(
          child: CircularProgressIndicator(
            color: kColorHoneyYellow,
          ),
        ),
      ),
    );
  }
}
