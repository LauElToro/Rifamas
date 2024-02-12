import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyC_KE950e984dKFF_XtmXvikB51p0uC3-8",
            authDomain: "rifamas-8ab33.firebaseapp.com",
            projectId: "rifamas-8ab33",
            storageBucket: "rifamas-8ab33.appspot.com",
            messagingSenderId: "282073103436",
            appId: "1:282073103436:web:23cf2e539434646a7288e9"));
  } else {
    await Firebase.initializeApp(
        options: FirebaseOptions(
      apiKey: "AIzaSyBRZQlXh4CjdKtsQ8f3kK6KKYDPX5hBqfU",
      appId: "1:352707650401:android:4328f1ddc02e5d8d75db20",
      messagingSenderId: "352707650401",
      projectId: "apprifa-d88c7",
    ));
  }

  // switch (defaultTargetPlatform) {
  //   case TargetPlatform.android:
  //     return android;

  //   default:
  //     throw UnsupportedError(
  //       'DefaultFirebaseOptions are not supported for this platform.',
  //     );
  // }
}

// const FirebaseOptions android = FirebaseOptions(
//   apiKey: "AIzaSyBRZQlXh4CjdKtsQ8f3kK6KKYDPX5hBqfU",
//   appId: "1:352707650401:android:4328f1ddc02e5d8d75db20",
//   messagingSenderId: "352707650401",
//   projectId: "apprifa-d88c7",
// );
