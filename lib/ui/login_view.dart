import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:skyline_template_app/core/utilities/constants.dart';
import 'package:skyline_template_app/viewmodels/login_viewmodel.dart';
import 'package:skyline_template_app/locator.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      disposeViewModel: false,
      viewModelBuilder: () => locator<LoginViewModel>(),
      onViewModelReady: (viewModel) async {
        try {
          await viewModel.init();
        } catch (e) {
          print('🔥 LoginViewModel init failed: \$e');
        }
      },
      builder: (context, viewModel, child) => Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFFF8E1), Color(0xFFFBE9E7)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 40.0),
                Container(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.brown[700]),
                    onPressed: () => viewModel.routeToHomeView(),
                  ),
                ),
                SizedBox(height: 60.0),
                Center(
                  child: Text(
                    "HoneyCombOS",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.brown[900],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Image.asset('assets/logo3.png', width: 150, height: 150),
                SizedBox(height: 18.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: TextField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => viewModel.setEmailAddress(value),
                    decoration: _inputDecoration("Enter your email"),
                  ),
                ),
                SizedBox(height: 8.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: TextField(
                    textAlign: TextAlign.center,
                    obscureText: true,
                    onChanged: (value) => viewModel.setPassword(value),
                    decoration: _inputDecoration("Enter your password."),
                  ),
                ),
                SizedBox(height: 24.0),
                _buildActionButton(
                  text: "Log In",
                  onPressed: () async {
                    String email = viewModel.email ?? 'No Email Provided';
                    String password = viewModel.password ?? 'No Password Provided';
                    print('🔑 login pressed \nEmail: \$email \nPassword: \$password');

                    await viewModel.loginUser();

                    String errorMessage = viewModel.errorMessage ?? '';
                    print('🧾 Login result: \$errorMessage');

                    if (errorMessage.isNotEmpty) {
                      _showDialog(context, viewModel);
                    }
                  },
                ),
                _buildActionButton(
                  text: "Register New User",
                  onPressed: () {
                    print('👤 Register new user');
                    viewModel.routeToRegistrationView();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hintText) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      hintText: hintText,
      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.amber[200]!, width: 1.0),
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.orange[300]!, width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
      ),
    );
  }

  Widget _buildActionButton({required String text, required VoidCallback onPressed}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Material(
        color: Color(0xFFFFD54F),
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
        elevation: 4.0,
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 330.0,
          height: 44.0,
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.brown[900],
            ),
          ),
        ),
      ),
    );
  }

  void _showDialog(BuildContext context, LoginViewModel viewModel) {
    String errorMessage = viewModel.errorMessage ?? 'Unknown error occurred.';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Oops! 🐻"),
          content: Text("Login Error: \$errorMessage"),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                viewModel.errorMessage = "";
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}