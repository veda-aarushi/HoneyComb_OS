import 'package:flutter/material.dart';
import 'package:skyline_template_app/core/utilities/constants.dart';
import 'package:skyline_template_app/viewmodels/cards_admin_viewmodel.dart';
import 'package:skyline_template_app/locator.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CardsAdminViewModel>.reactive(
      disposeViewModel: false,
      viewModelBuilder: () => locator<CardsAdminViewModel>(),
      onModelReady: (viewModel) => viewModel.init(),
      builder: (context, viewModel, child) => Scaffold(
        backgroundColor: kColorHoneyCream,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [kColorHoneyCream, Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 40),
                  Text(
                    "🐝 Card Admin Page",
                    style: TextStyle(
                      color: kColorBeeBrown,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Image.asset(
                    'assets/logo3.png',
                    width: 150,
                    height: 150,
                  ),
                  SizedBox(height: 30),
                  _buildHoneyButton("Add Flash cards", viewModel.routeToAddCardsView),
                  _buildHoneyButton("Edit Flash cards", viewModel.routeToEditCardsView),
                  _buildHoneyButton("Return to Menu", viewModel.routeToMenuView),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHoneyButton(String text, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 32),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: kColorHoneyYellow,
          foregroundColor: kColorBeeBrown,
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: StadiumBorder(),
          elevation: 4,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
