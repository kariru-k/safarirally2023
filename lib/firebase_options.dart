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
    apiKey: 'AIzaSyDcw0O8EfBhdGjnIXJMKJHf_N2T0xoEhKs',
    appId: '1:372363936392:web:44a3dc14ab23cf8da8953d',
    messagingSenderId: '372363936392',
    projectId: 'safari-rally-2023',
    authDomain: 'safari-rally-2023.firebaseapp.com',
    storageBucket: 'safari-rally-2023.appspot.com',
    measurementId: 'G-NN9ZXXG0PB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBCjRmIh_3bSs2kmfRKUUxOM7BBB9BSKuQ',
    appId: '1:372363936392:android:15703ed19d3e1448a8953d',
    messagingSenderId: '372363936392',
    projectId: 'safari-rally-2023',
    storageBucket: 'safari-rally-2023.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDu1lb_A01XndlxMFhoMTg74yBs4hLbzeE',
    appId: '1:372363936392:ios:f7d390a6804b4c81a8953d',
    messagingSenderId: '372363936392',
    projectId: 'safari-rally-2023',
    storageBucket: 'safari-rally-2023.appspot.com',
    iosClientId: '372363936392-t8lto6o14npo8o6pk5dmqdmg7gv9ouf5.apps.googleusercontent.com',
    iosBundleId: 'com.example.safarirally2023',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDu1lb_A01XndlxMFhoMTg74yBs4hLbzeE',
    appId: '1:372363936392:ios:104412d4332a0be2a8953d',
    messagingSenderId: '372363936392',
    projectId: 'safari-rally-2023',
    storageBucket: 'safari-rally-2023.appspot.com',
    iosClientId: '372363936392-djj6t1gptv9797fjg8juflsr92186bm8.apps.googleusercontent.com',
    iosBundleId: 'com.example.safarirally2023.RunnerTests',
  );
}