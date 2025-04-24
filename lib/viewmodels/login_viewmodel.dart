import 'dart:async';
import 'package:skyline_template_app/viewmodels/base_viewmodel.dart';
import 'package:skyline_template_app/core/enums/view_state.dart';
import 'package:skyline_template_app/locator.dart';
import 'package:skyline_template_app/core/services/navigation_service.dart';
import 'package:skyline_template_app/core/utilities/route_names.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _firebaseAuth = FirebaseAuth.instance;

  String? _email;
  String? get email => _email;

  String? _password;
  String? get password => _password;

  String errorMessage = "";

  void setEmailAddress(String inputString) {
    _email = inputString.trim();
  }

  void setPassword(String inputString) {
    _password = inputString.trim();
  }

  // Navigation Methods
  void routeToTeacherView() => _navigationService.navigateTo(AddCardViewRoute);
  void routeToRegistrationView() => _navigationService.navigateTo(RegistrationViewRoute);
  void routeToFlashCardsView() => _navigationService.navigateTo(FlashCardViewRoute);
  void routeToMenuView() => _navigationService.navigateTo(MenuViewRoute);
  void routeToHomeView() => _navigationService.navigateTo(HomeViewRoute);

  Future<void> init() async {
    setState(ViewState.Busy);
    try {
      print("🔧 LoginViewModel initialized");
    } catch (e) {
      print("🚨 Error during init: \$e");
      setState(ViewState.Error);
    } finally {
      setState(ViewState.Idle);
    }
  }

  Future<void> loginUser() async {
    if (_email == null || _password == null || _email!.isEmpty || _password!.isEmpty) {
      errorMessage = "Email and Password cannot be empty.";
      print("🚫 \$errorMessage");
      return;
    }

    setState(ViewState.Busy);
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: _email!,
        password: _password!,
      );

      if (userCredential.user?.uid.isNotEmpty ?? false) {
        print("✅ Login successful. UID: \${userCredential.user?.uid}");
        errorMessage = ""; // Clear any old errors
        routeToMenuView();
      } else {
        errorMessage = "Login failed. User UID is empty.";
        print("⚠️ \$errorMessage");
      }
    } on FirebaseAuthException catch (e) {
      errorMessage = e.message ?? "An authentication error occurred.";
      print("🔥 FirebaseAuthException: \$errorMessage");
    } catch (e) {
      errorMessage = "An unexpected error occurred.";
      print("💥 Unexpected Error: \$e");
    } finally {
      setState(ViewState.Idle);
    }
  }
}
