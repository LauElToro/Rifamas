import '/backend/api_requests/api_calls.dart';
import '/ff/ff_theme.dart';
import '/ff/ff_util.dart';
import '/ff/ff_widgets.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'login_page_model.dart';
export 'login_page_model.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

class LoginPageWidget extends StatefulWidget {
  const LoginPageWidget({Key? key}) : super(key: key);

  @override
  _LoginPageWidgetState createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget> {
  late LoginPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoginPageModel());

    _model.emailController ??= TextEditingController(text: _model.username);
    _model.emailFocusNode ??= FocusNode();
    _model.passwordController ??= TextEditingController(text: _model.password);
    _model.passwordFocusNode ??= FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FFTheme.of(context).secondaryBackground,
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: 140.0,
                  decoration: BoxDecoration(
                    color: FFTheme.of(context).secondaryBackground,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16.0),
                      bottomRight: Radius.circular(16.0),
                      topLeft: Radius.circular(0.0),
                      topRight: Radius.circular(0.0),
                    ),
                  ),
                  alignment: AlignmentDirectional(0.00, 0.00),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 300.0,
                      height: 200.0,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0.00, 0.00),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(32.0, 32.0, 32.0, 32.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Bienvenido',
                          style: FFTheme.of(context).displaySmall.override(
                                fontFamily: 'Readex Pro',
                              ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 12.0, 0.0, 24.0),
                          child: Text(
                            'Inicia sesion ahora',
                            style: FFTheme.of(context).labelMedium,
                          ),
                        ),
                        Form(
                          key: _model.formKey,
                          autovalidateMode: AutovalidateMode.always,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 16.0),
                                child: TextFormField(
                                  controller: _model.emailController,
                                  focusNode: _model.emailFocusNode,
                                  onChanged: (_) => EasyDebounce.debounce(
                                    '_model.emailController',
                                    Duration(milliseconds: 2000),
                                    () async {
                                      setState(() {
                                        _model.username =
                                            _model.emailController.text;
                                      });
                                    },
                                  ),
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Nombre de usuario',
                                    hintStyle: FFTheme.of(context).bodyLarge,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FFTheme.of(context).alternate,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FFTheme.of(context).alternate,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                  ),
                                  style: FFTheme.of(context).bodyMedium,
                                  validator: _model.emailControllerValidator
                                      .asValidator(context),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 16.0),
                                child: TextFormField(
                                  controller: _model.passwordController,
                                  focusNode: _model.passwordFocusNode,
                                  onChanged: (_) => EasyDebounce.debounce(
                                    '_model.passwordController',
                                    Duration(milliseconds: 2000),
                                    () async {
                                      setState(() {
                                        _model.password =
                                            _model.passwordController.text;
                                      });
                                    },
                                  ),
                                  obscureText: !_model.passwordVisibility,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    hintStyle: FFTheme.of(context).bodyLarge,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FFTheme.of(context).alternate,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FFTheme.of(context).alternate,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    suffixIcon: InkWell(
                                      onTap: () => setState(
                                        () => _model.passwordVisibility =
                                            !_model.passwordVisibility,
                                      ),
                                      focusNode: FocusNode(skipTraversal: true),
                                      child: Icon(
                                        _model.passwordVisibility
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        color:
                                            FFTheme.of(context).secondaryText,
                                        size: 22.0,
                                      ),
                                    ),
                                  ),
                                  style: FFTheme.of(context).bodyMedium,
                                  validator: _model.passwordControllerValidator
                                      .asValidator(context),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 16.0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    if (_model.formKey.currentState == null ||
                                        !_model.formKey.currentState!
                                            .validate()) {
                                      return;
                                    }
                                    _model.response = await LoginCall.call(
                                      username: _model.username,
                                      password: _model.password,
                                    );
                                    // if ((_model.response?.succeeded ?? true)) {
                                    if ((_model.response!.succeeded)) {
                                      setState(() {
                                        FFAppState().jwtuser =
                                            (_model.response!.jsonBody);
                                      });
                                      setState(() {
                                        FFAppState().loggedIn = true;
                                      });

                                      _model.balance =
                                          await WalletGroup.getBalanceCall.call(
                                        idUser: getJsonField(
                                          FFAppState().jwtuser,
                                          r'''$.ID''',
                                        ).toString(),
                                      );
                                      setState(() {
                                        FFAppState().currentBalance =
                                            getJsonField(
                                          (_model.balance?.jsonBody ?? ''),
                                          r'''$''',
                                        ).toString();
                                      });

                                      context.pushNamed('HomePage');
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Error de usuario o contraseña',
                                            style: TextStyle(
                                              color: FFTheme.of(context)
                                                  .primaryText,
                                            ),
                                          ),
                                          duration:
                                              Duration(milliseconds: 4000),
                                          backgroundColor:
                                              FFTheme.of(context).error,
                                        ),
                                      );
                                    }

                                    setState(() {});
                                  },
                                  // onPressed: () async {
                                  //   _model.signInWithEmailAndPassword(
                                  //     _model.username ?? "",
                                  //     _model.password ?? "",
                                  //   );

                                  //   FFAppState().loggedIn = true;
                                  // },
                                  text: 'INICIAR SESION',
                                  options: FFButtonOptions(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.5,
                                    height: 50.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color: FFTheme.of(context).primary,
                                    textStyle:
                                        FFTheme.of(context).titleSmall.override(
                                              fontFamily: 'Montserrat',
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                    elevation: 0.0,
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 16.0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    context.pushNamed('HomePage');
                                  },
                                  text: 'ENTRAR COMO INVITADO',
                                  options: FFButtonOptions(
                                    height: 50.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10.0, 0.0, 10.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color:
                                        FFTheme.of(context).secondaryBackground,
                                    textStyle: FFTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily: 'Montserrat',
                                          color: FFTheme.of(context).primary,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                    elevation: 0.0,
                                    borderSide: BorderSide(
                                      color: FFTheme.of(context).primary,
                                    ),
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceAround, // Ajusta la alineación según tus necesidades
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: Container(
                                              height: 60,
                                              width: 50,
                                              child: Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                            ),
                                          );
                                        },
                                      );
                                      final loggin =
                                          await _model.signInWithGoogle();
                                      if (loggin != false) {
                                        setState(() {
                                          FFAppState().jwtuser = loggin;
                                        });
                                        setState(() {
                                          FFAppState().loggedIn = true;
                                        });

                                        _model.balance = await WalletGroup
                                            .getBalanceCall
                                            .call(
                                          idUser: getJsonField(
                                            FFAppState().jwtuser,
                                            r'''$.ID''',
                                          ).toString(),
                                        );
                                        setState(() {
                                          FFAppState().currentBalance =
                                              getJsonField(
                                            (_model.balance?.jsonBody ?? ''),
                                            r'''$''',
                                          ).toString();
                                        });
                                        Navigator.pop(context);
                                        await Future.delayed(
                                            const Duration(milliseconds: 100));
                                        context.pushNamed('HomePage');
                                      } else {
                                        Navigator.pop(context);
                                        await Future.delayed(
                                            const Duration(milliseconds: 100));
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Error de usuario o contraseña',
                                              style: TextStyle(
                                                color: FFTheme.of(context)
                                                    .primaryText,
                                              ),
                                            ),
                                            duration:
                                                Duration(milliseconds: 4000),
                                            backgroundColor:
                                                FFTheme.of(context).error,
                                          ),
                                        );
                                      }
                                    },
                                    child: Image.asset(
                                      'assets/redes/google.png', // Reemplaza esto con la ruta correcta de tu imagen
                                      width:
                                          50, // Ajusta el ancho según tus necesidades
                                      height:
                                          50, // Ajusta la altura según tus necesidades
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: Container(
                                              height: 60,
                                              width: 50,
                                              child: Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                            ),
                                          );
                                        },
                                      );

                                      final loggin =
                                          await _model.signInWithFacebook();
                                      if (loggin != false) {
                                        setState(() {
                                          FFAppState().jwtuser = loggin;
                                        });
                                        setState(() {
                                          FFAppState().loggedIn = true;
                                        });

                                        _model.balance = await WalletGroup
                                            .getBalanceCall
                                            .call(
                                          idUser: getJsonField(
                                            FFAppState().jwtuser,
                                            r'''$.ID''',
                                          ).toString(),
                                        );
                                        setState(() {
                                          FFAppState().currentBalance =
                                              getJsonField(
                                            (_model.balance?.jsonBody ?? ''),
                                            r'''$''',
                                          ).toString();
                                        });
                                        Navigator.pop(context);
                                        context.pushNamed('HomePage');
                                      } else {
                                        Navigator.pop(context);

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Error de usuario o contraseña',
                                              style: TextStyle(
                                                color: FFTheme.of(context)
                                                    .primaryText,
                                              ),
                                            ),
                                            duration:
                                                Duration(milliseconds: 4000),
                                            backgroundColor:
                                                FFTheme.of(context).error,
                                          ),
                                        );
                                      }
                                    },
                                    child: Image.asset(
                                      'assets/redes/facebook.png', // Reemplaza esto con la ruta correcta de tu imagen
                                      width:
                                          50, // Ajusta el ancho según tus necesidades
                                      height:
                                          50, // Ajusta la altura según tus necesidades
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 4.0, 0.0, 4.0),
                              child: Text(
                                'No tienes una cuenta?',
                                style: FFTheme.of(context).bodyMedium,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  4.0, 4.0, 0.0, 4.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  context.pushNamed('registerPage');
                                },
                                child: Text(
                                  'Registrate ahora',
                                  style:
                                      FFTheme.of(context).bodyMedium.override(
                                            fontFamily: 'Montserrat',
                                            color: FFTheme.of(context).primary,
                                          ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
