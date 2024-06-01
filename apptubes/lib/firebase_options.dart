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
    apiKey: 'AIzaSyDxqwSJNmaLNJf5srmzI85R5Lrrd5TlovA',
    appId: '1:323745745127:web:bdde4292c91a8c7236fa42',
    messagingSenderId: '323745745127',
    projectId: 'firendisasterapp-ecd06',
    authDomain: 'firendisasterapp-ecd06.firebaseapp.com',
    storageBucket: 'firendisasterapp-ecd06.appspot.com',
    measurementId: 'G-G50BMNPDZY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBujeKK8AtDWu7FiGsLkgebTEUxEFnbdp4',
    appId: '1:323745745127:android:cc7227e85648994836fa42',
    messagingSenderId: '323745745127',
    projectId: 'firendisasterapp-ecd06',
    storageBucket: 'firendisasterapp-ecd06.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDqNFdrVutIcyWVM2ZKxMGT2MEhcNTWFmo',
    appId: '1:323745745127:ios:e953dcef3b0688f436fa42',
    messagingSenderId: '323745745127',
    projectId: 'firendisasterapp-ecd06',
    storageBucket: 'firendisasterapp-ecd06.appspot.com',
    iosBundleId: 'com.example.apptubes',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDqNFdrVutIcyWVM2ZKxMGT2MEhcNTWFmo',
    appId: '1:323745745127:ios:e953dcef3b0688f436fa42',
    messagingSenderId: '323745745127',
    projectId: 'firendisasterapp-ecd06',
    storageBucket: 'firendisasterapp-ecd06.appspot.com',
    iosBundleId: 'com.example.apptubes',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDxqwSJNmaLNJf5srmzI85R5Lrrd5TlovA',
    appId: '1:323745745127:web:db6610d208d14f3236fa42',
    messagingSenderId: '323745745127',
    projectId: 'firendisasterapp-ecd06',
    authDomain: 'firendisasterapp-ecd06.firebaseapp.com',
    storageBucket: 'firendisasterapp-ecd06.appspot.com',
    measurementId: 'G-CEGPE6FY9T',
  );
}