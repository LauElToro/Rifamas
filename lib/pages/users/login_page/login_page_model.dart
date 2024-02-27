import 'dart:developer';
import 'dart:convert';
import 'package:crypto/crypto.dart';

import '/backend/api_requests/api_calls.dart';
import '/ff/ff_theme.dart';
import '/ff/ff_util.dart';
import '/ff/ff_widgets.dart';
import 'login_page_widget.dart' show LoginPageWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:http/http.dart' as http;

class LoginPageModel extends FFModel<LoginPageWidget> {
  ///  Local state fields for this page.

  dynamic jwtData;

  String? username = '';

  String? password = '';

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  FocusNode? emailFocusNode;
  TextEditingController? emailController;
  String? Function(BuildContext, String?)? emailControllerValidator;
  String? _emailControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Requerido';
    }

    return null;
  }

  // State field(s) for password widget.
  FocusNode? passwordFocusNode;
  TextEditingController? passwordController;
  late bool passwordVisibility;
  String? Function(BuildContext, String?)? passwordControllerValidator;
  String? _passwordControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Requerido';
    }

    return null;
  }

  // Stores action output result for [Backend Call - API (login)] action in Button widget.
  ApiCallResponse? response;
  // Stores action output result for [Backend Call - API (get balance)] action in Button widget.
  ApiCallResponse? balance;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    emailControllerValidator = _emailControllerValidator;
    passwordVisibility = false;
    passwordControllerValidator = _passwordControllerValidator;
  }

  void dispose() {
    unfocusNode.dispose();
    emailFocusNode?.dispose();
    emailController?.dispose();

    passwordFocusNode?.dispose();
    passwordController?.dispose();
  }

  Future<dynamic> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        return false;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      String googleCredentialData =
          userCredential.user!.email.toString() + userCredential.user!.uid;
      final secretGooglePassword =
          sha256.convert(utf8.encode(googleCredentialData)).toString();

      log(secretGooglePassword);
      print("Primer inicio de sesion");
      ApiCallResponse loginResponse = await LoginCall.call(
          username: userCredential.user!.email, // "demo_test@rifamas.es",
          password: secretGooglePassword // "EWFQYV57Qknx"
          );

      if (loginResponse.statusCode == 200) {
        print(loginResponse.jsonBody);
        return loginResponse.jsonBody;
      }

      String regex =
          r'[^\p{Alphabetic}\p{Mark}\p{Decimal_Number}\p{Connector_Punctuation}\p{Join_Control}\s]+';

      print("Registrando usuario...");
      ApiCallResponse registerResponse = await RegisterCall.call(
        username: "Google " +
            userCredential.user!.displayName!
                .replaceAll(RegExp(regex, unicode: true), ''),
        email: userCredential.user!.email,
        firstName: userCredential.user!.displayName!.split(' ')[0],
        lastName: userCredential.user!.displayName!.split(' ').length < 2
            ? " "
            : userCredential.user!.displayName!.split(' ')[1],
        password: secretGooglePassword,
      );

      if (registerResponse.statusCode == 201) {
        print("Segundo inicio de sesion");
        ApiCallResponse logintoResponse = await LoginCall.call(
            username: userCredential.user!.email, // "demo_test@rifamas.es",
            password: secretGooglePassword // "EWFQYV57Qknx"
            );

        return logintoResponse.jsonBody;
      }

      return false;
      // Resto del código de manejo de sesión
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<dynamic> signInWithFacebook() async {
    try {
      final LoginResult? loginResult = await FacebookAuth.instance.login();

      if (loginResult == null) {
        return false;
      }
      if (loginResult.status == LoginStatus.success) {
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(loginResult.accessToken!.token);

        final userCredential = await FirebaseAuth.instance
            .signInWithCredential(facebookAuthCredential);

        String facebookCredentialData =
            userCredential.user!.email.toString() + userCredential.user!.uid;
        final secretFacebookPassword =
            sha256.convert(utf8.encode(facebookCredentialData)).toString();

        print(userCredential.user!.email.toString());
        print(userCredential.user!.displayName);
        log(userCredential.toString());
        ApiCallResponse loginResponse = await LoginCall.call(
            username: userCredential.user!.email,
            password: secretFacebookPassword);
        if (loginResponse.statusCode == 200) {
          print(loginResponse.jsonBody);
          return loginResponse.jsonBody;
        }

        String regex =
            r'[^\p{Alphabetic}\p{Mark}\p{Decimal_Number}\p{Connector_Punctuation}\p{Join_Control}\s]+';

        print("Registrando usuario...");
        ApiCallResponse registerResponse = await RegisterCall.call(
          username: "Facebook " +
              userCredential.user!.displayName!
                  .replaceAll(RegExp(regex, unicode: true), ''),
          email: userCredential.user!.email,
          firstName: userCredential.user!.displayName!.split(' ')[0],
          lastName: userCredential.user!.displayName!.split(' ').length < 2
              ? " "
              : userCredential.user!.displayName!.split(' ')[1],
          password: secretFacebookPassword,
        );

        if (registerResponse.statusCode == 201) {
          print("Segundo inicio de sesion");
          ApiCallResponse logintoResponse = await LoginCall.call(
              username: userCredential.user!.email,
              password: secretFacebookPassword);

          return logintoResponse.jsonBody;
        }
      } else {
        print("Error: ${loginResult.message}");
        return;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    print("entre");
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print(credential.user!.email);
      print("buen logeo");
      return true;
    } on FirebaseAuthException catch (e) {
      print(e);
      return false;
    }
  }
}
