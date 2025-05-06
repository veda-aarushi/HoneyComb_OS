import 'package:flutter/material.dart';
import 'package:skyline_template_app/viewmodels/menu_viewmodel.dart';
import 'package:skyline_template_app/core/utilities/constants.dart';
import 'package:stacked/stacked.dart';
import 'package:skyline_template_app/locator.dart';

class MenuView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MenuViewModel>.reactive(
      viewModelBuilder: () => locator<MenuViewModel>(),
      disposeViewModel: false,
      onModelReady: (viewModel) => viewModel.init(),
      builder: (context, viewModel, child) => Scaffold(
        backgroundColor: kColorHoneyCream,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "🍯 HoneyCombOS",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                        color: kColorBeeBrown,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Flash Cards Menu",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: kColorBeeBrown,
                      ),
                    ),
                    SizedBox(height: 20),
                    Image.asset('assets/logo3.png', width: 150, height: 150),
                    SizedBox(height: 30),
                    _menuButton("Learn Flashcards", viewModel.routeToMemGame),
                    SizedBox(height: 12),
                    _menuButton("Cards Admin Menu", viewModel.routeToHomeView),
                    SizedBox(height: 12),
                    _menuButton("Sign Out", viewModel.signOut),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _menuButton(String label, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: kColorHoneyYellow,
          foregroundColor: kColorBeeBrown,
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        child: Text(label),
      ),
    );
  }
}
