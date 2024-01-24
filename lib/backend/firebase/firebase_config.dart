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
    await Firebase.initializeApp();
  }
}
