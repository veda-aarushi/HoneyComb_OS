import 'package:skyline_template_app/viewmodels/add_card_viewmodel.dart';
import 'package:skyline_template_app/viewmodels/cards_admin_viewmodel.dart';
import 'package:skyline_template_app/viewmodels/edit_card_viewmodel.dart';
import 'package:skyline_template_app/viewmodels/flash_card_viewmodel.dart';
import 'package:skyline_template_app/viewmodels/menu_viewmodel.dart';
import 'package:skyline_template_app/viewmodels/login_viewmodel.dart';
import 'package:skyline_template_app/viewmodels/registration_viewmodel.dart';
import 'package:skyline_template_app/viewmodels/learn_viewmodel.dart';
import 'package:skyline_template_app/viewmodels/play_game_viewmodel.dart';
import 'package:skyline_template_app/core/services/navigation_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  _setupViewModels();
  _setupServices();
}

// Register all view models
Future<void> _setupViewModels() async {
  locator.registerLazySingleton<LoginViewModel>(() => LoginViewModel());
  locator.registerLazySingleton<RegistrationViewModel>(() => RegistrationViewModel());
  locator.registerLazySingleton<MenuViewModel>(() => MenuViewModel());
  locator.registerLazySingleton<CardsAdminViewModel>(() => CardsAdminViewModel());
  locator.registerLazySingleton<AddCardViewModel>(() => AddCardViewModel());
  locator.registerLazySingleton<EditCardViewModel>(() => EditCardViewModel());
  locator.registerLazySingleton<FlashCardViewModel>(() => FlashCardViewModel());
  locator.registerLazySingleton<PlayGameViewModel>(() => PlayGameViewModel());
  locator.registerLazySingleton<LearnViewModel>(() => LearnViewModel());

}

// Register all services
Future<void> _setupServices() async {
  locator.registerLazySingleton<NavigationService>(() => NavigationServiceImpl());
}