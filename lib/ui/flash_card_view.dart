import 'package:flutter/material.dart';
import 'package:skyline_template_app/viewmodels/flash_card_viewmodel.dart';
import 'package:skyline_template_app/core/utilities/constants.dart';
import 'package:stacked/stacked.dart';
import 'package:skyline_template_app/locator.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';

class FlashCardView extends StatelessWidget {
  final List<CardState> cardStates = [];
  final Map<int, bool> cardVisibilityMap = {};

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FlashCardViewModel>.reactive(
      viewModelBuilder: () => locator<FlashCardViewModel>(),
      disposeViewModel: false,
      onModelReady: (viewModel) async {
        await viewModel.init();
      },
      builder: (context, viewModel, child) => Scaffold(
        backgroundColor: kColorHoneyCream,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "🐝 Flash Card Game",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: kColorBeeBrown),
                ),
                SizedBox(height: 20),
                _buildLessonDropdown(viewModel),
                SizedBox(height: 20),
                Text("Flashcards", style: TextStyle(color: kColorBeeBrown, fontSize: 20)),
                _buildCardList(viewModel.questionCards, cardStates, viewModel),
                SizedBox(height: 30),
                _buildActionButtons(viewModel),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLessonDropdown(FlashCardViewModel viewModel) {
    if (viewModel.lessonIds.isEmpty) {
      return Text("No lessons available", style: TextStyle(color: kColorBeeBrown));
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
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
        onChanged: (value) {
          if (value != null) viewModel.readMapsFromDB(value);
        },
        icon: Icon(Icons.expand_more, color: kColorBeeBrown),
      ),
    );
  }

  Widget _buildCardList(List<dynamic> cards, List<CardState> states, FlashCardViewModel viewModel) {
    return Column(
      children: List.generate(cards.length, (index) {
        final card = cards[index];
        final cardState = _createCardState(index, states);

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: FlipCard(
            key: cardState.myKey,
            onFlip: () => cardState.updateCardIsFlipped(),
            front: _buildCardButton(card.question ?? 'na', kColorHoneyYellow),
            back: _buildCardButton(card.answer ?? 'na', kColorHiveClay),
          ),
        );
      }),
    );
  }

  Widget _buildCardButton(String text, Color color) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 16, color: kColorBeeBrown),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildActionButtons(FlashCardViewModel viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _styledButton("Menu", viewModel.routeToMenuView),
        _styledButton("Start Game", viewModel.routeToPlayGameView),
        _styledButton("Learn", viewModel.routeToLearnView),
      ],
    );
  }

  Widget _styledButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: kColorHoneyYellow,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
        child: Text(text, style: TextStyle(color: kColorBeeBrown)),
      ),
    );
  }

  CardState _createCardState(int index, List<CardState> cardStateList) {
    if (cardStateList.length > index) return cardStateList[index];
    final newState = CardState();
    cardStateList.add(newState);
    return newState;
  }
}

class CardState {
  final GlobalKey<FlipCardState> myKey = GlobalKey<FlipCardState>();
  bool isFlipped = false;

  void updateCardIsFlipped() {
    isFlipped = !isFlipped;
  }
}
