import 'package:flutter/material.dart';

abstract class NavigationService {
  GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> get navigationKey => _navigationKey;
  void pop(returnValue);
  Future<dynamic> navigateTo(String routeName, {dynamic arguments});
  Future<dynamic> pushNamed(String routeName, {required Object arguments});
  Future<dynamic> pushReplacementNamed(String routeName, {required Object arguments});
  Future<dynamic> popAllAndPushNamed(
      String routeName, {
        required Object arguments,
      });
  void popUntil(bool Function(Route<dynamic>) predicate);
}

class NavigationServiceImpl implements NavigationService {
  GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigationKey => _navigationKey;

  void pop(returnValue) {
    _navigationKey.currentState?.pop(returnValue);  // Null safety: conditionally pop if not null
  }

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    print('NavigationService navigateTo $routeName');
    // Ensure that we are returning a non-nullable Future
    return _navigationKey.currentState!
        .pushNamed(routeName, arguments: arguments) as Future<dynamic>;  // Cast to Future<dynamic>
  }

  // New from provider architecture reference
  Future<dynamic> pushNamed(String routeName, {required Object arguments}) {
    return navigationKey.currentState!
        .pushNamed(routeName, arguments: arguments) as Future<dynamic>;  // Cast to Future<dynamic>
  }

  Future<dynamic> pushReplacementNamed(String routeName, {required Object arguments}) {
    return navigationKey.currentState!
        .pushReplacementNamed(routeName, arguments: arguments) as Future<dynamic>;  // Cast to Future<dynamic>
  }

  Future<dynamic> popAllAndPushNamed(
      String routeName, {
        required Object arguments,
      }) {
    return navigationKey.currentState!
        .pushNamedAndRemoveUntil(routeName, (_) => false, arguments: arguments) as Future<dynamic>;  // Cast to Future<dynamic>
  }

  void popUntil(bool Function(Route<dynamic>) predicate) {
    navigationKey.currentState?.popUntil(predicate);  // Null safety: conditionally popUntil
  }
}