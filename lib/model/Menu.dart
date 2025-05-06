import 'package:flutter/cupertino.dart';

class Menu {
  final String uid;       // Unique identifier for the menu
  final String menuItem;  // Name of the menu item

  // Constructor
  Menu({
    required this.uid,
    required this.menuItem,
  });

  // Factory constructor for creating a Menu instance from a JSON map
  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      uid: json['uid'] as String,
      menuItem: json['menuItem'] as String,
    );
  }

  // Method to convert a Menu instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'menuItem': menuItem,
    };
  }

  // String representation for debugging
  @override
  String toString() => 'Menu(uid: $uid, menuItem: $menuItem)';
}
