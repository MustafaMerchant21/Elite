// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyDybDxhVvM3hQh7fBzBkv89ULviHDkkORc',
    appId: '1:682145792163:web:4d30a8cd46b4c6f96fff16',
    messagingSenderId: '682145792163',
    projectId: 'elite-5c037',
    authDomain: 'elite-5c037.firebaseapp.com',
    storageBucket: 'elite-5c037.appspot.com',
    measurementId: 'G-WY60C78KK3',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA_ythWvs0nlbawUnKJjPesFNYfYNXLdFk',
    appId: '1:682145792163:android:9626b7dffeb33a4b6fff16',
    messagingSenderId: '682145792163',
    projectId: 'elite-5c037',
    storageBucket: 'elite-5c037.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAZqLSUVcQCMb3IAqocbk-NS697Yv3lVKg',
    appId: '1:682145792163:ios:3223872e6dc13c466fff16',
    messagingSenderId: '682145792163',
    projectId: 'elite-5c037',
    storageBucket: 'elite-5c037.appspot.com',
    iosBundleId: 'com.example.shoesShop',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAZqLSUVcQCMb3IAqocbk-NS697Yv3lVKg',
    appId: '1:682145792163:ios:3223872e6dc13c466fff16',
    messagingSenderId: '682145792163',
    projectId: 'elite-5c037',
    storageBucket: 'elite-5c037.appspot.com',
    iosBundleId: 'com.example.shoesShop',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDybDxhVvM3hQh7fBzBkv89ULviHDkkORc',
    appId: '1:682145792163:web:523247f47780337d6fff16',
    messagingSenderId: '682145792163',
    projectId: 'elite-5c037',
    authDomain: 'elite-5c037.firebaseapp.com',
    storageBucket: 'elite-5c037.appspot.com',
    measurementId: 'G-PSJQDPKS3H',
  );
}
