import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb;
import 'dart:io' show Platform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError('DefaultFirebaseOptions are not supported for web.');
    }
    if (Platform.isAndroid) {
      return android;
    }
    if (Platform.isIOS) {
      return ios;
    }
    if (Platform.isMacOS) {
      return macos;
    }
    throw UnsupportedError('DefaultFirebaseOptions are not supported for this platform.');
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyArYnFp3DlYFywI2aoNH3x9en5XWtYtJQE',
    authDomain: 'my-updated-flashcard.firebaseapp.com',
    projectId: 'my-updated-flashcard',
    storageBucket: 'my-updated-flashcard.firebasestorage.app',
    messagingSenderId: '180178747118',
    appId: '1:180178747118:web:7b5a47c2103cc07234fdff',
    measurementId: 'G-86VT5MXYF0',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyArYnFp3DlYFywI2aoNH3x9en5XWtYtJQE',
    authDomain: 'my-updated-flashcard.firebaseapp.com',
    projectId: 'my-updated-flashcard',
    storageBucket: 'my-updated-flashcard.firebasestorage.app',
    messagingSenderId: '180178747118',
    appId: '1:180178747118:web:7b5a47c2103cc07234fdff',
    measurementId: 'G-86VT5MXYF0',
  );

  static const FirebaseOptions macos = ios;
}

