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
    apiKey: 'AIzaSyDs4vgjzvdaJoHPpwRHdFs7mbPX2hkGoGQ',
    appId: '1:170982785407:web:5d9edd84bb1597e4f21a4a',
    messagingSenderId: '170982785407',
    projectId: 'orgami-7d8b7',
    authDomain: 'orgami-7d8b7.firebaseapp.com',
    storageBucket: 'orgami-7d8b7.appspot.com',
    measurementId: 'G-G7N66VV0JK',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA_oO60E7KR-BoknAY7uqADLol_htPpP50',
    appId: '1:170982785407:android:ce66c69e18e16d53f21a4a',
    messagingSenderId: '170982785407',
    projectId: 'orgami-7d8b7',
    storageBucket: 'orgami-7d8b7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA6_zR5Zm07MgBLW9Wo6wySqwRyxEMAc4o',
    appId: '1:170982785407:ios:53611ea0d18cc68df21a4a',
    messagingSenderId: '170982785407',
    projectId: 'orgami-7d8b7',
    storageBucket: 'orgami-7d8b7.appspot.com',
    iosBundleId: 'com.example.orgami',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA6_zR5Zm07MgBLW9Wo6wySqwRyxEMAc4o',
    appId: '1:170982785407:ios:4b6d26ff5640b288f21a4a',
    messagingSenderId: '170982785407',
    projectId: 'orgami-7d8b7',
    storageBucket: 'orgami-7d8b7.appspot.com',
    iosBundleId: 'com.example.orgami.RunnerTests',
  );
}
