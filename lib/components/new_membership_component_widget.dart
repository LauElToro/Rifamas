import 'package:rifamas/index.dart';

import '/backend/api_requests/api_calls.dart';
import '/ff/ff_theme.dart';
import '/ff/ff_util.dart';
import '/ff/ff_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'new_membership_component_model.dart';
export 'new_membership_component_model.dart';

class NewMembershipComponentWidget extends StatefulWidget {
  const NewMembershipComponentWidget({Key? key}) : super(key: key);

  @override
  _NewMembershipComponentWidgetState createState() =>
      _NewMembershipComponentWidgetState();
}

class _NewMembershipComponentWidgetState
    extends State<NewMembershipComponentWidget> {
  late NewMembershipComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NewMembershipComponentModel());

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

    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
      child: Container(
        width: MediaQuery.sizeOf(context).width * 1.0,
        height: 400.0,
        decoration: BoxDecoration(
          color: FFTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Para poder crear una membresia es necesario que te subscribas.',
                textAlign: TextAlign.center,
                style: FFTheme.of(context).bodyMedium.override(
                      fontFamily: 'Montserrat',
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 15.0),
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 0.5,
                  height: 130.0,
                  decoration: BoxDecoration(
                    color: FFTheme.of(context).secondaryBackground,
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(
                      color: FFTheme.of(context).primary,
                    ),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'SUSCRIPCION',
                          style: FFTheme.of(context).bodyMedium.override(
                                fontFamily: 'Montserrat',
                                color: FFTheme.of(context).primary,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Text(
                          '24,99 €',
                          style: FFTheme.of(context).displayMedium.override(
                                fontFamily: 'Montserrat',
                                fontSize: 34.0,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              FFButtonWidget(
                onPressed: () async {
                  /*
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            FirstCreatePageWidget()), // Reemplaza NuevaPagina con el nombre de tu página
                  );
*/
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Redirigendo a la pasarela',
                        style: TextStyle(
                          color: FFTheme.of(context).primaryText,
                        ),
                      ),
                      duration: Duration(milliseconds: 4000),
                      backgroundColor: FFTheme.of(context).secondary,
                    ),
                  );
                  _model.apiResultywtCopyCopy = await AddToCartCall.call(
                    productId: 27044,
                    userId: getJsonField(
                      FFAppState().jwtuser,
                      r'''$.ID''',
                    ),
                  );
                  if ((_model.apiResultywtCopyCopy?.succeeded ?? true)) {
                    Navigator.pop(context);

                    context.pushNamed('webViewPage', queryParameters: {
                      'route': 'membership',
                    });
                  }

                  setState(() {});
                },
                text: 'SUBSCRIBIRME',
                options: FFButtonOptions(
                  height: 50.0,
                  padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                  iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: FFTheme.of(context).primary,
                  textStyle: FFTheme.of(context).titleSmall.override(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                  elevation: 0.0,
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
