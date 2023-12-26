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
    apiKey: 'AIzaSyA0ox-QXT6A6nsp-HDxZd9qFsJAOD0_pKY',
    appId: '1:605395627417:web:3a53736329b6e81feef708',
    messagingSenderId: '605395627417',
    projectId: 'beyondlottotv',
    authDomain: 'beyondlottotv.firebaseapp.com',
    storageBucket: 'beyondlottotv.appspot.com',
    measurementId: 'G-3JBN13BE7G',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA4IwzxVIEMib_NBL_RmQIi7AH_Ja1JDdo',
    appId: '1:605395627417:android:8eae2d376c5bf8cbeef708',
    messagingSenderId: '605395627417',
    projectId: 'beyondlottotv',
    storageBucket: 'beyondlottotv.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCnFVfTqiDPKFX2OIsgn4iYHFx7F9cZhvM',
    appId: '1:605395627417:ios:bc842e5fd8ff56d0eef708',
    messagingSenderId: '605395627417',
    projectId: 'beyondlottotv',
    storageBucket: 'beyondlottotv.appspot.com',
    iosBundleId: 'com.duetatech.inventoryIos',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCnFVfTqiDPKFX2OIsgn4iYHFx7F9cZhvM',
    appId: '1:605395627417:ios:2060eb6f91a3f99deef708',
    messagingSenderId: '605395627417',
    projectId: 'beyondlottotv',
    storageBucket: 'beyondlottotv.appspot.com',
    iosBundleId: 'com.duetatech.inventoryIos.RunnerTests',
  );
}
