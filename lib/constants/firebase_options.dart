import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show kIsWeb;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    throw UnsupportedError(
      'DefaultFirebaseOptions are only configured for web in this build.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAWRd-r6saG96EA-TiehgoKgXcHE8N-k_I',
    appId: '1:44553271030:android:d890c49ea2b5df265bded7',
    messagingSenderId: '44553271030',
    projectId: 'aroundu-community',
    storageBucket: 'aroundu-community.firebasestorage.app',
    authDomain: 'aroundu-community.firebaseapp.com',
    measurementId: 'G-10XSPGGSB8',
  );
}
