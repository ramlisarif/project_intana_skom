import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.windows:
        return windows;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions belum dikonfigurasi untuk platform ini.',
        );
    }
  }

  // Ganti nilai string di bawah dengan data Firebase kamu:
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSy...', 
    appId: '1:123456789:android:...',
    messagingSenderId: '123456789',
    projectId: 'nama-project-kamu',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSy...',
    appId: '1:123456789:web:...',
    messagingSenderId: '123456789',
    projectId: 'nama-project-kamu',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSy...',
    appId: '1:123456789:web:...', // Windows bisa menggunakan App ID Web
    messagingSenderId: '123456789',
    projectId: 'nama-project-kamu',
  );
}