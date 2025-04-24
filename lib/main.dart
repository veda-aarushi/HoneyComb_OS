import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:skyline_template_app/core/services/navigation_service.dart';
import 'package:skyline_template_app/core/utilities/router.dart' as router;
import 'package:skyline_template_app/ui/login_view.dart';
import 'locator.dart';
import 'firebase_options.dart';
import 'dart:io' show Platform;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Load .env before anything else
  try {
    await dotenv.load(fileName: ".env");
    print("✅ .env loaded");
  } catch (e) {
    print("❌ Failed to load .env file: $e");
  }

  try {
    final apps = Firebase.apps;
    if (apps.isEmpty) {
      if (Platform.isAndroid || Platform.isIOS) {
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );
      } else {
        await Firebase.initializeApp(); // macOS, Windows, Linux, Web
      }
    } else {
      print("🔥 Firebase already initialized");
    }
  } catch (e, stack) {
    print("🔥 Firebase initialization error: $e\n$stack");
  }


  await setupLocator();

  runApp(MySkylineApp());
}

class MySkylineApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: locator<NavigationService>().navigationKey,
      onGenerateRoute: (settings) =>
          router.Router.generateRoute(context, settings),
      home: LoginView(),
    );
  }
}
