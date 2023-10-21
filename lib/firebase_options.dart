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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAqeiclNSNzw16CJOsGfyWpOQezlsjgnGM',
    appId: '1:716165936197:android:af093324fc4b0bfe521f2c',
    messagingSenderId: '716165936197',
    projectId: 'wedding-service-wss',
    databaseURL: 'https://wedding-service-wss-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'wedding-service-wss.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB6Pm2J5lauCnvwntFl4GwBRStqkzPKYxY',
    appId: '1:716165936197:ios:5bd691fb92920228521f2c',
    messagingSenderId: '716165936197',
    projectId: 'wedding-service-wss',
    databaseURL: 'https://wedding-service-wss-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'wedding-service-wss.appspot.com',
    iosClientId: '716165936197-v53brv1nlfj2b1r798k0ik52iji30i29.apps.googleusercontent.com',
    iosBundleId: 'com.example.weddingPlannerManagement',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB6Pm2J5lauCnvwntFl4GwBRStqkzPKYxY',
    appId: '1:716165936197:ios:d9fad0c3a6513c63521f2c',
    messagingSenderId: '716165936197',
    projectId: 'wedding-service-wss',
    databaseURL: 'https://wedding-service-wss-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'wedding-service-wss.appspot.com',
    iosClientId: '716165936197-4gp8h4bg80cnqh9s74t6e88nob961hic.apps.googleusercontent.com',
    iosBundleId: 'com.example.weddingPlannerManagement.RunnerTests',
  );
}
