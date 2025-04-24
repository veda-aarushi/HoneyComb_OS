import 'package:flutter/material.dart';
import 'package:skyline_template_app/ui/flash_card_view.dart';
import 'package:skyline_template_app/ui/play_game_view.dart';
import 'package:skyline_template_app/ui/cards_admin_view.dart';
import 'package:skyline_template_app/ui/menu_view.dart';
import 'package:skyline_template_app/ui/registration_view.dart';
import 'package:skyline_template_app/ui/add_card_view.dart';
import 'package:skyline_template_app/ui/edit_card_view.dart';
import 'package:skyline_template_app/ui/login_view.dart';
import 'package:skyline_template_app/ui/learn_view.dart';
import 'package:skyline_template_app/core/utilities/route_names.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// Router class for generating application routes
class Router {
  static String? currentScreenName;

  static Route<dynamic> generateRoute(BuildContext context,
      RouteSettings settings,) {
    currentScreenName = settings.name; // Set current route name

    return platformPageRoute(
      context: context,
      settings: RouteSettings(name: settings.name),
      builder: (context) => _buildRoute(settings),
    );
  }

  static Widget _buildRoute(RouteSettings settings) {
    final arguments = settings.arguments;

    switch (settings.name) {
      case HomeViewRoute:
        return HomeView();
      case AddCardViewRoute:
        return AddCardView();
      case EditCardViewRoute:
        return EditCardView();
      case LoginViewRoute:
        return LoginView();
      case RegistrationViewRoute:
        return RegistrationView();
      case FlashCardViewRoute:
        return FlashCardView();
      case MenuViewRoute:
        return MenuView();
      case LearnViewRoute:
        return LearnView();
      case PlayGameViewRoute:
        return PlayGameView();
      default:
      // Default fallback for undefined routes
        return Scaffold(
          body: Center(
            child: Text(
              'No route defined for ${settings.name}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        );
    }
  }
}
