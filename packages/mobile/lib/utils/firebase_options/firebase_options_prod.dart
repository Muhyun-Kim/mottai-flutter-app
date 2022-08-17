// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options_prod.dart';
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
    // ignore: missing_enum_constant_in_switch
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAihWVaLzU49X_hsetNdSsjL34fW0JT8iM',
    appId: '1:1078704622453:android:387cec9b0b0501702aa13c',
    messagingSenderId: '1078704622453',
    projectId: 'mottai-app-prod',
    storageBucket: 'mottai-app-prod.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAIhSvJrppbl82bvDfsBz4dRvBZkKHnvvo',
    appId: '1:1078704622453:ios:e9250e5571073ce42aa13c',
    messagingSenderId: '1078704622453',
    projectId: 'mottai-app-prod',
    storageBucket: 'mottai-app-prod.appspot.com',
    iosClientId: '1078704622453-m4r4jkr23viej9ug2hedgtu9p5fb8uj1.apps.googleusercontent.com',
    iosBundleId: 'com.kosukesaigusa.mottaiFlutterApp',
  );
}
