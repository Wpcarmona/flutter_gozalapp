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
    apiKey: 'AIzaSyBhDSgVDQtdYdGwsxf50PTxkSy7omHWaH0',
    appId: '1:951183260820:web:34ea7e622b92e6e3bbc881',
    messagingSenderId: '951183260820',
    projectId: 'gozalapp',
    authDomain: 'gozalapp.firebaseapp.com',
    storageBucket: 'gozalapp.firebasestorage.app',
    measurementId: 'G-EMQ8BJMYKZ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyABBQjS8fM-mqeO37c8k5suxcjgA_mNEHU',
    appId: '1:951183260820:android:999a3097a433638ebbc881',
    messagingSenderId: '951183260820',
    projectId: 'gozalapp',
    storageBucket: 'gozalapp.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD4-kbF3K_kQw7rMtrBE2dDtpOqMJWVSX4',
    appId: '1:951183260820:ios:b5bbcde6fa0a8e98bbc881',
    messagingSenderId: '951183260820',
    projectId: 'gozalapp',
    storageBucket: 'gozalapp.firebasestorage.app',
    iosBundleId: 'com.superliker.gozalapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD4-kbF3K_kQw7rMtrBE2dDtpOqMJWVSX4',
    appId: '1:951183260820:ios:b5bbcde6fa0a8e98bbc881',
    messagingSenderId: '951183260820',
    projectId: 'gozalapp',
    storageBucket: 'gozalapp.firebasestorage.app',
    iosBundleId: 'com.superliker.gozalapp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBhDSgVDQtdYdGwsxf50PTxkSy7omHWaH0',
    appId: '1:951183260820:web:641d4aac0e6acca0bbc881',
    messagingSenderId: '951183260820',
    projectId: 'gozalapp',
    authDomain: 'gozalapp.firebaseapp.com',
    storageBucket: 'gozalapp.firebasestorage.app',
    measurementId: 'G-0HWQ0WF15C',
  );
}
