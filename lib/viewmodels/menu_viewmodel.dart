import 'package:flutter/material.dart';
import 'package:skyline_template_app/core/utilities/route_names.dart';
import 'package:skyline_template_app/model/Menu.dart';
import 'package:skyline_template_app/viewmodels/base_viewmodel.dart';
import 'package:skyline_template_app/core/enums/view_state.dart';
import 'package:skyline_template_app/core/services/navigation_service.dart';
import 'package:skyline_template_app/locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MenuViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  List<Menu> menuOptions = [];
  bool pageLoaded = false;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final _firebaseAuth = FirebaseAuth.instance;

  Future init() async {
    print("MenuViewModel init()");
    setState(ViewState.Busy);
    try {
      await _loadMenuFromDB();
      pageLoaded = true;
    } catch (e) {
      setState(ViewState.Error);
      print('Error loading menu: $e');
    }
    setState(ViewState.Idle);
  }

  Future<void> _loadMenuFromDB() async {
    try {
      CollectionReference menuItemslist = FirebaseFirestore.instance.collection('menu_items');
      QuerySnapshot querySnapshot = await menuItemslist.get();

      // Clear current menu options before adding new ones
      menuOptions.clear();

      querySnapshot.docs.forEach((doc) {
        print(" --- Menu Item --- ");
        print("ID: ${doc['id']}, Menu Item: ${doc['menu_item']}");
        menuOptions.add(Menu(
          uid: doc['id'],
          menuItem: doc['menu_item'],
        ));
      });

      // Adding some default menu items
      menuOptions.add(Menu(uid: '4', menuItem: 'Memory Game'));
      menuOptions.add(Menu(uid: '5', menuItem: 'Teachers Page'));

      notifyListeners(); // Notify the UI to update
    } catch (e) {
      print('Error fetching menu from Firestore: $e');
      rethrow;
    }
  }

  void routeToHomeView() {
    _navigationService.navigateTo(HomeViewRoute);
  }

  void routeToLoginPage() {
    _navigationService.navigateTo(LoginViewRoute);
  }

  void signOut() {
    print('Signing out current user');
    _firebaseAuth.signOut();
    routeToLoginPage();
  }

  void routeToMemGame() {
    _navigationService.navigateTo(FlashCardViewRoute);
  }

  void routeTeachersPage() {
    _navigationService.navigateTo(AddCardViewRoute);
  }
}
