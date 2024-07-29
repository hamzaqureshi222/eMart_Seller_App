// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyA-T7Vd3xHJoGGXcIZtjLYmVU-qyB3o56A',
    appId: '1:1046714028915:web:15e9f203be9f357da2eb06',
    messagingSenderId: '1046714028915',
    projectId: 'emart-3aa2e',
    authDomain: 'emart-3aa2e.firebaseapp.com',
    databaseURL: 'https://emart-3aa2e-default-rtdb.firebaseio.com',
    storageBucket: 'emart-3aa2e.appspot.com',
    measurementId: 'G-TMQP792RGH',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAiYuxVwPhkw1XnVEJMX3ZcpcSGKWqsfjU',
    appId: '1:1046714028915:android:804b1db7b5e3bc9aa2eb06',
    messagingSenderId: '1046714028915',
    projectId: 'emart-3aa2e',
    databaseURL: 'https://emart-3aa2e-default-rtdb.firebaseio.com',
    storageBucket: 'emart-3aa2e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAun-stUz2HM8btZwqcjXP-EoFlKWLQuC0',
    appId: '1:1046714028915:ios:1097e357e84b2d63a2eb06',
    messagingSenderId: '1046714028915',
    projectId: 'emart-3aa2e',
    databaseURL: 'https://emart-3aa2e-default-rtdb.firebaseio.com',
    storageBucket: 'emart-3aa2e.appspot.com',
    iosBundleId: 'com.example.emartSeller',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAun-stUz2HM8btZwqcjXP-EoFlKWLQuC0',
    appId: '1:1046714028915:ios:1097e357e84b2d63a2eb06',
    messagingSenderId: '1046714028915',
    projectId: 'emart-3aa2e',
    databaseURL: 'https://emart-3aa2e-default-rtdb.firebaseio.com',
    storageBucket: 'emart-3aa2e.appspot.com',
    iosBundleId: 'com.example.emartSeller',
  );
}