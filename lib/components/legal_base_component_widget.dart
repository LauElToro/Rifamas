import '/ff/ff_theme.dart';
import '/ff/ff_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'legal_base_component_model.dart';
export 'legal_base_component_model.dart';

class LegalBaseComponentWidget extends StatefulWidget {
  const LegalBaseComponentWidget({Key? key}) : super(key: key);

  @override
  _LegalBaseComponentWidgetState createState() =>
      _LegalBaseComponentWidgetState();
}

class _LegalBaseComponentWidgetState extends State<LegalBaseComponentWidget> {
  late LegalBaseComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LegalBaseComponentModel());

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
        height: MediaQuery.sizeOf(context).height * 0.5,
        decoration: BoxDecoration(
          color: FFTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'BASES LEGALES',
                  style: FFTheme.of(context).bodyMedium.override(
                        fontFamily: 'Montserrat',
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 0.5,
                          decoration: BoxDecoration(
                            color: FFTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: Text(
                            'Organizador',
                            style: FFTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Montserrat',
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 0.5,
                          decoration: BoxDecoration(
                            color: FFTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: Text(
                            'Organizador',
                            style: FFTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Montserrat',
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 0.5,
                          decoration: BoxDecoration(
                            color: FFTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: Text(
                            'Plataforma de aplicaciones',
                            style: FFTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Montserrat',
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 0.5,
                          decoration: BoxDecoration(
                            color: FFTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: Text(
                            'Las plataformas proveedoras de aplicaciones como “App Store” de Apple o “Google Play” de Android (Google) \"NO\" tienen ninguna participación y \"NO\" patrocinan los productos publicados en este sitio.\n',
                            style: FFTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Montserrat',
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 0.5,
                          decoration: BoxDecoration(
                            color: FFTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: Text(
                            'Alcance',
                            style: FFTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Montserrat',
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 0.5,
                          decoration: BoxDecoration(
                            color: FFTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: Text(
                            'Publica',
                            style: FFTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Montserrat',
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 0.5,
                          decoration: BoxDecoration(
                            color: FFTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: Text(
                            'PUBLICACIÓN DEL NOMBRE E IMAGEN DEL GANADOR:',
                            style: FFTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Montserrat',
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 0.5,
                          decoration: BoxDecoration(
                            color: FFTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: Text(
                            'Por motivos de transparencia, el ganador autoriza a publicar su nombre, apellidos e imagen en cualquier actividad publicitaria y/o promocional que esté relacionada con esta acción, todo ello en cualquier medio (perfiles de redes sociales y web site, entre otros) sin que se obtenga derecho de remuneración o beneficio alguno con excepción hecha de la entrega del premio ganado conforme a estas bases.\n\n',
                            style: FFTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Montserrat',
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 0.5,
                          decoration: BoxDecoration(
                            color: FFTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: Text(
                            'NOVENA: RESPONSABILIDAD Y RESERVA DE DERECHOS:\t\n',
                            style: FFTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Montserrat',
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 0.5,
                          decoration: BoxDecoration(
                            color: FFTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: Text(
                            'Se excluirá de participación o se dejará el premio desierto en el caso de que existan presunciones de fraude por parte de alguno de los participantes. Se podrá realizar modificaciones a la mecánica con el objeto de mejorarla o de evitar actitudes fraudulentas. También podrá realizar otro tipo de modificaciones siempre que éstas estén justificadas y no perjudiquen a los participantes.\n\n\n',
                            style: FFTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Montserrat',
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                      ),
                    ],
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
