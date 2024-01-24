import '/components/secondaary_header_component_widget.dart';
import '/ff/ff_theme.dart';
import '/ff/ff_util.dart';
import '/ff/ff_web_view.dart';
import '/ff/ff_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'web_view_page_model.dart';
export 'web_view_page_model.dart';

class WebViewPageWidget extends StatefulWidget {
  const WebViewPageWidget({
    Key? key,
    this.route,
  }) : super(key: key);

  final String? route;

  @override
  _WebViewPageWidgetState createState() => _WebViewPageWidgetState();
}

class _WebViewPageWidgetState extends State<WebViewPageWidget> {
  late WebViewPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => WebViewPageModel());

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
        backgroundColor: FFTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width * 1.0,
                height: MediaQuery.sizeOf(context).height * 1.0,
                decoration: BoxDecoration(
                  color: FFTheme.of(context).secondaryBackground,
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 80.0, 0.0, 0.0),
                  child: FFWebView(
                    content:
                        'https://staging.rifamas.es/?user_id=${getJsonField(
                      FFAppState().jwtuser,
                      r'''$.ID''',
                    ).toString()}',
                    bypass: false,
                    height: 500.0,
                    verticalScroll: false,
                    horizontalScroll: false,
                  ),
                ),
              ),
              wrapWithModel(
                model: _model.secondaaryHeaderComponentModel,
                updateCallback: () => setState(() {}),
                child: SecondaaryHeaderComponentWidget(
                  title: 'Finalizar compra',
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.00, 1.00),
                child: FFButtonWidget(
                  onPressed: () async {
                    if (widget.route == 'subscription') {
                      context.pushNamed('membershipSubscribedPage');
                    } else {
                      if (widget.route == 'product') {
                        context.pushNamed('loterySubscribedPage');
                      } else {
                        context.pushNamed('firstCreatePage');
                      }
                    }
                  },
                  text: 'Button',
                  options: FFButtonOptions(
                    height: 40.0,
                    padding:
                        EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: Color(0x001372B4),
                    textStyle: FFTheme.of(context).titleSmall.override(
                          fontFamily: 'Montserrat',
                          color: Colors.white,
                        ),
                    elevation: 0.0,
                    borderSide: BorderSide(
                      color: Color(0x12000000),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
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
