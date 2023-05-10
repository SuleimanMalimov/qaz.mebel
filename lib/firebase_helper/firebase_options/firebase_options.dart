import 'dart:io';

import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseConfig {
  static FirebaseOptions get platformOptions {
    if (Platform.isIOS) {
      // iOS and MacOS
      return const FirebaseOptions(
        appId: '1:283466351178:ios:11f94d8546d09dc5939cb3',
        apiKey: 'AIzaSyDZMrO_9KcpEJc8yMiIL4oYEi9a5gFOzHI',
        projectId: 'e-commerce-6455a',
        messagingSenderId: '283466351178	',
        iosBundleId: 'com.example.youtubeEcommerce',
      );
    } else {
      // Android
      return const FirebaseOptions(
        appId: '1:118011090516:android:4be646397317e576633fc1',
        apiKey: 'AIzaSyDGTENZwYZMcRbAcmuFKyNrSfkYP1XKK7U',
        projectId: 'com.malimov.qazmebel.qaz_mebel',
        messagingSenderId: '283466351178',
      );
    }
  }
}
