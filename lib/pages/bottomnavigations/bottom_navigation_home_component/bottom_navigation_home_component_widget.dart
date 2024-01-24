import '/ff/ff_theme.dart';
import '/ff/ff_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'bottom_navigation_home_component_model.dart';
export 'bottom_navigation_home_component_model.dart';

class BottomNavigationHomeComponentWidget extends StatefulWidget {
  const BottomNavigationHomeComponentWidget({
    Key? key,
    required this.page,
  }) : super(key: key);

  final String? page;

  @override
  _BottomNavigationHomeComponentWidgetState createState() =>
      _BottomNavigationHomeComponentWidgetState();
}

class _BottomNavigationHomeComponentWidgetState
    extends State<BottomNavigationHomeComponentWidget> {
  late BottomNavigationHomeComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BottomNavigationHomeComponentModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Align(
      alignment: AlignmentDirectional(0.00, 1.00),
      child: Container(
        width: MediaQuery.sizeOf(context).width * 1.0,
        height: 60.0,
        decoration: BoxDecoration(
          color: FFTheme.of(context).primary,
          borderRadius: BorderRadius.circular(0.0),
          shape: BoxShape.rectangle,
        ),
        alignment: AlignmentDirectional(0.00, 1.00),
        child: Align(
          alignment: AlignmentDirectional(0.00, -5.00),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width * 0.18,
                height: 100.0,
                decoration: BoxDecoration(
                  color: valueOrDefault<Color>(
                    widget.page == 'home'
                        ? Color(0x8D14181B)
                        : Colors.transparent,
                    Colors.transparent,
                  ),
                ),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    if (Navigator.of(context).canPop()) {
                      context.pop();
                    }
                    context.pushNamed('HomePage');
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          'assets/images/Rifamas-inicio.png',
                          width: 30.0,
                          height: 30.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text(
                        'Inicio',
                        style: FFTheme.of(context).bodyMedium.override(
                              fontFamily: 'Montserrat',
                              color: FFTheme.of(context).accent4,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ].divide(SizedBox(height: 5.0)),
                  ),
                ),
              ),
              if (FFAppState().loggedIn == true)
                Container(
                  width: MediaQuery.sizeOf(context).width * 0.18,
                  height: 100.0,
                  decoration: BoxDecoration(
                    color: widget.page == 'rifas'
                        ? Color(0x8D14181B)
                        : Colors.transparent,
                  ),
                  child: Visibility(
                    visible: FFAppState().loggedIn == true,
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        if (Navigator.of(context).canPop()) {
                          context.pop();
                        }
                        context.pushNamed('myProductListAllPage');
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              'assets/images/Rifamas_misrifas.png',
                              width: 30.0,
                              height: 30.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            'Mis rifas',
                            style: FFTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Montserrat',
                                  color: FFTheme.of(context).accent4,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ].divide(SizedBox(height: 5.0)),
                      ),
                    ),
                  ),
                ),
              if (FFAppState().loggedIn == true)
                Container(
                  width: MediaQuery.sizeOf(context).width * 0.18,
                  height: 100.0,
                  decoration: BoxDecoration(
                    color: widget.page == 'publish'
                        ? Color(0x8D14181B)
                        : Colors.transparent,
                  ),
                  child: Visibility(
                    visible: FFAppState().loggedIn == true,
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        if (Navigator.of(context).canPop()) {
                          context.pop();
                        }
                        context.pushNamed('membersHomePage');
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              'assets/images/Rifamas-subirifa.png',
                              width: 30.0,
                              height: 30.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            'Publicar',
                            style: FFTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Montserrat',
                                  color: FFTheme.of(context).accent4,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ].divide(SizedBox(height: 5.0)),
                      ),
                    ),
                  ),
                ),
              if (FFAppState().loggedIn == true)
                Container(
                  width: MediaQuery.sizeOf(context).width * 0.18,
                  height: 100.0,
                  decoration: BoxDecoration(
                    color: widget.page == 'chat'
                        ? Color(0x8D14181B)
                        : Colors.transparent,
                  ),
                  child: Visibility(
                    visible: FFAppState().loggedIn == true,
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        context.pushNamed('chatListPage');
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              'assets/images/Rifamas-mensajes.png',
                              width: 30.0,
                              height: 30.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            'Mensajes',
                            style: FFTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Montserrat',
                                  color: FFTheme.of(context).accent4,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ].divide(SizedBox(height: 5.0)),
                      ),
                    ),
                  ),
                ),
              if (FFAppState().loggedIn == true)
                Container(
                  width: MediaQuery.sizeOf(context).width * 0.2,
                  height: 100.0,
                  decoration: BoxDecoration(
                    color: widget.page == 'profile'
                        ? Color(0x8D14181B)
                        : Colors.transparent,
                  ),
                  child: Visibility(
                    visible: FFAppState().loggedIn == true,
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        if (Navigator.of(context).canPop()) {
                          context.pop();
                        }
                        context.pushNamed('accountPage');
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              'assets/images/Rifamas-perfil.png',
                              width: 30.0,
                              height: 30.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            'Perfil',
                            style: FFTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Montserrat',
                                  color: FFTheme.of(context).accent4,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ].divide(SizedBox(height: 5.0)),
                      ),
                    ),
                  ),
                ),
              if (FFAppState().loggedIn == false)
                Container(
                  width: MediaQuery.sizeOf(context).width * 0.2,
                  height: 100.0,
                  decoration: BoxDecoration(
                    color: widget.page == 'profile'
                        ? Color(0x8D14181B)
                        : Colors.transparent,
                  ),
                  child: Visibility(
                    visible: FFAppState().loggedIn == false,
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        if (Navigator.of(context).canPop()) {
                          context.pop();
                        }
                        context.pushNamed('loginPage');
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.logout,
                            color: FFTheme.of(context).secondaryBackground,
                            size: 30.0,
                          ),
                          Text(
                            'Entrar',
                            style: FFTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Montserrat',
                                  color: FFTheme.of(context).accent4,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ].divide(SizedBox(height: 5.0)),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
