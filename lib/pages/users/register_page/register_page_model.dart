import '/backend/api_requests/api_calls.dart';
import '/ff/ff_theme.dart';
import '/ff/ff_util.dart';
import '/ff/ff_widgets.dart';
import 'register_page_widget.dart' show RegisterPageWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
class RegisterPageModel extends FFModel<RegisterPageWidget> {
  ///  Local state fields for this page.

  String email = '';

  String username = '';

  String firstName = '';

  String lastName = '';

  String password = '';

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode3;
  TextEditingController? textController3;
  String? Function(BuildContext, String?)? textController3Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode4;
  TextEditingController? textController4;
  String? Function(BuildContext, String?)? textController4Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode5;
  TextEditingController? textController5;
  late bool passwordVisibility;
  String? Function(BuildContext, String?)? textController5Validator;
  // Stores action output result for [Backend Call - API (register)] action in Button widget.
  ApiCallResponse? apiResultsm0;
  // Stores action output result for [Backend Call - API (login)] action in Button widget.
  ApiCallResponse? apiResultxpt;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    passwordVisibility = false;
  }

  void dispose() {
    unfocusNode.dispose();
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    textFieldFocusNode2?.dispose();
    textController2?.dispose();

    textFieldFocusNode3?.dispose();
    textController3?.dispose();

    textFieldFocusNode4?.dispose();
    textController4?.dispose();

    textFieldFocusNode5?.dispose();
    textController5?.dispose();
  }

  /// Action blocks are added here.

  Future<void> registerWithGoogle() async {
    try {
      final UserCredential? userCredential = await _registerWithGoogle();

      if (userCredential != null) {
        print('Usuario registrado con Google con éxito');
        // Puedes realizar acciones adicionales si es necesario
      } else {
        print('Error en el registro con Google');
      }
    } catch (e) {
      print('Error durante el registro con Google: $e');
    }
  }

  Future<void> registerWithFacebook() async {
    try {
      final UserCredential? userCredential = await _registerWithFacebook();

      if (userCredential != null) {
        print('Usuario registrado con Facebook con éxito');
        // Puedes realizar acciones adicionales si es necesario
      } else {
        print('Error en el registro con Facebook');
      }
    } catch (e) {
      print('Error durante el registro con Facebook: $e');
    }
  }

  Future<UserCredential?> _registerWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      return null;
    }

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential?> _registerWithFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();

    if (loginResult.status == LoginStatus.success) {
      final AccessToken accessToken = loginResult.accessToken!;
      final AuthCredential credential = FacebookAuthProvider.credential(accessToken.token);

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } else {
      return null;
    }
  }
}
