import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return const FirebaseOptions(
      apiKey: 'AIzaSyCVcgjW8lXc2-zvwhlwY9IwA5eFYROShIA',
      appId: '1:529102888453:android:463d1cbc7e0efcacfd866c',
      messagingSenderId: '529102888453',
      projectId: 'myapp-32c76',
      storageBucket: 'myapp-32c76.appspot.com',
      authDomain: 'myapp-32c76.firebaseapp.com', // Add this line
    );
  }
}
