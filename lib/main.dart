import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:skyline_template_app/core/services/navigation_service.dart';
import 'package:skyline_template_app/core/utilities/router.dart' as router;
import 'package:skyline_template_app/ui/login_view.dart';
import 'firebase_options.dart';
import 'locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Load .env
  try {
    await dotenv.load(fileName: ".env");
    print("✅ .env loaded");
  } catch (e) {
    print("❌ Failed to load .env: $e");
  }

  // ✅ Initialize Firebase only if not already initialized
  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: Platform.isAndroid || Platform.isIOS
            ? DefaultFirebaseOptions.currentPlatform
            : null,
      );
      print("🔥 Firebase initialized");
    } else {
      print("🔥 Firebase already initialized");
    }
  } catch (e, stack) {
    print("🔥 Firebase init error: $e\n$stack");
  }

  // ✅ Set up service locator
  await setupLocator();

  runApp(const MySkylineApp());
}

class MySkylineApp extends StatelessWidget {
  const MySkylineApp({super.key});

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
