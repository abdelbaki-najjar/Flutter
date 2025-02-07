import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return const FirebaseOptions(
      apiKey: "AIzaSyD6x9rPomFDjILF66UAffRQwUWhVhR5tv0",
      authDomain: "appkids-94c3a.firebaseapp.com",
      projectId: "appkids-94c3a",
      storageBucket: "appkids-94c3a.appspot.com", // تم   ليكون صحي
      messagingSenderId: "508653276326",
      appId: "1:508653276326:web:3d9779f820bd75392ff867",
    );
  }
}
