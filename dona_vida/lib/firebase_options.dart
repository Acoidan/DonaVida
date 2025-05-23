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
    apiKey: 'AIzaSyCJ9Hdx88kpDtwvPo6yKoAZIpMQzUFImXU',
    appId: '1:994542157462:web:46b861ed71cd477c960cb7',
    messagingSenderId: '994542157462',
    projectId: 'donavida-1db14',
    authDomain: 'donavida-1db14.firebaseapp.com',
    storageBucket: 'donavida-1db14.firebasestorage.app',
    measurementId: 'G-K218HGD357',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDRz9-W_OM3P-flpGzN6occ5Tteecta5ow',
    appId: '1:994542157462:android:02eef1ab6670ed9c960cb7',
    messagingSenderId: '994542157462',
    projectId: 'donavida-1db14',
    storageBucket: 'donavida-1db14.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD_FcFkHc42uau5rsSblaxaSi7GZzXwFTk',
    appId: '1:994542157462:ios:ca401f64b371cdd1960cb7',
    messagingSenderId: '994542157462',
    projectId: 'donavida-1db14',
    storageBucket: 'donavida-1db14.firebasestorage.app',
    iosBundleId: 'com.example.donaVida',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD_FcFkHc42uau5rsSblaxaSi7GZzXwFTk',
    appId: '1:994542157462:ios:ca401f64b371cdd1960cb7',
    messagingSenderId: '994542157462',
    projectId: 'donavida-1db14',
    storageBucket: 'donavida-1db14.firebasestorage.app',
    iosBundleId: 'com.example.donaVida',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCJ9Hdx88kpDtwvPo6yKoAZIpMQzUFImXU',
    appId: '1:994542157462:web:c8083d12e3dc051c960cb7',
    messagingSenderId: '994542157462',
    projectId: 'donavida-1db14',
    authDomain: 'donavida-1db14.firebaseapp.com',
    storageBucket: 'donavida-1db14.firebasestorage.app',
    measurementId: 'G-36R1M5VZEV',
  );
}
