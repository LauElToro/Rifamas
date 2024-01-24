import '/ff/ff_radio_button.dart';
import '/ff/ff_theme.dart';
import '/ff/ff_util.dart';
import '/ff/form_field_controller.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'filter_component_model.dart';
export 'filter_component_model.dart';

class FilterComponentWidget extends StatefulWidget {
  const FilterComponentWidget({Key? key}) : super(key: key);

  @override
  _FilterComponentWidgetState createState() => _FilterComponentWidgetState();
}

class _FilterComponentWidgetState extends State<FilterComponentWidget> {
  late FilterComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FilterComponentModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
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
      padding: EdgeInsetsDirectional.fromSTEB(10.0, 50.0, 10.0, 10.0),
      child: Container(
        width: MediaQuery.sizeOf(context).width * 1.0,
        height: 380.0,
        decoration: BoxDecoration(
          color: FFTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width * 1.0,
                height: 50.0,
                decoration: BoxDecoration(
                  color: FFTheme.of(context).alternate,
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              8.0, 0.0, 8.0, 0.0),
                          child: TextFormField(
                            controller: _model.textController,
                            focusNode: _model.textFieldFocusNode,
                            onChanged: (_) => EasyDebounce.debounce(
                              '_model.textController',
                              Duration(milliseconds: 2000),
                              () async {
                                FFAppState().update(() {
                                  FFAppState().search =
                                      _model.textController.text;
                                });
                              },
                            ),
                            onFieldSubmitted: (_) async {
                              setState(() {
                                FFAppState().search =
                                    _model.textController.text;
                              });

                              context.pushNamed('productListPage');
                            },
                            autofocus: true,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelStyle: FFTheme.of(context).labelMedium,
                              hintText: 'Buscar',
                              hintStyle: FFTheme.of(context).labelMedium,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00E0E3E7),
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            style: FFTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Montserrat',
                                  lineHeight: 0.0,
                                ),
                            validator: _model.textControllerValidator
                                .asValidator(context),
                          ),
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          context.pushNamed('productListPage');
                        },
                        child: Icon(
                          Icons.search_outlined,
                          color: FFTheme.of(context).primaryText,
                          size: 35.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                  child: FFRadioButton(
                    options: ['Rifas', 'Membresias'].toList(),
                    onChanged: (val) => setState(() {}),
                    controller: _model.radioButtonValueController ??=
                        FormFieldController<String>('Rifas'),
                    optionHeight: 32.0,
                    textStyle: FFTheme.of(context).labelMedium.override(
                          fontFamily: 'Montserrat',
                          color: FFTheme.of(context).primary,
                          fontWeight: FontWeight.bold,
                        ),
                    buttonPosition: RadioButtonPosition.left,
                    direction: Axis.horizontal,
                    radioButtonColor: FFTheme.of(context).primary,
                    inactiveRadioButtonColor: FFTheme.of(context).primaryText,
                    toggleable: false,
                    horizontalAlignment: WrapAlignment.spaceAround,
                    verticalAlignment: WrapCrossAlignment.start,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                child: Text(
                  'Filtrar por:',
                  style: FFTheme.of(context).titleLarge.override(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                child: Text(
                  'Tipo de publicacion',
                  style: FFTheme.of(context).titleSmall.override(
                        fontFamily: 'Montserrat',
                        color: FFTheme.of(context).secondaryText,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                child: Text(
                  'Precio mas bajo a mas alto',
                  style: FFTheme.of(context).titleSmall.override(
                        fontFamily: 'Montserrat',
                        color: FFTheme.of(context).primary,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                child: Text(
                  'Precio mas alto a mas bajo',
                  style: FFTheme.of(context).titleSmall.override(
                        fontFamily: 'Montserrat',
                        color: FFTheme.of(context).primary,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                child: Text(
                  'Popularidad',
                  style: FFTheme.of(context).titleSmall.override(
                        fontFamily: 'Montserrat',
                        color: FFTheme.of(context).secondaryText,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                child: Text(
                  'Calificacion',
                  style: FFTheme.of(context).titleSmall.override(
                        fontFamily: 'Montserrat',
                        color: FFTheme.of(context).secondaryText,
                        fontWeight: FontWeight.w600,
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
