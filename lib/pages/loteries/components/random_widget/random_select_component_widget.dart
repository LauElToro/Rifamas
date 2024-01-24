import 'package:rifamas/pages/loteries/components/mid_widget/mid_select_component_widget.dart';

import '/backend/api_requests/api_calls.dart';
import '/ff/ff_icon_button.dart';
import '/ff/ff_theme.dart';
import '/ff/ff_util.dart';
import '/ff/ff_widgets.dart';
import '/pages/loteries/components/number_select_component/number_select_component_widget.dart';
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'random_select_component_model.dart';
export 'random_select_component_model.dart';
import 'dart:math';
import '/ff/custom_functions.dart' as functions;

class RandomSelectComponentWidget extends StatefulWidget {
  const RandomSelectComponentWidget({
    Key? key,
    required this.idProduct,
    required this.numberTickets,
    required this.ticketsSelected,
  }) : super(key: key);

  final int? idProduct;
  final String? numberTickets;
  final List<int> ticketsSelected;

  @override
  _RandomSelectComponentWidgetState createState() =>
      _RandomSelectComponentWidgetState();
}

class _RandomSelectComponentWidgetState
    extends State<RandomSelectComponentWidget> {
  late RandomSelectComponentModel _model;
  final myController = TextEditingController();

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RandomSelectComponentModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();
    myController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Align(
      alignment: AlignmentDirectional(0.00, 0.00),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 20.0),
        child: Container(
          width: MediaQuery.sizeOf(context).width * 0.85,
          height: 300.0,
          decoration: BoxDecoration(
            color: FFTheme.of(context).secondaryBackground,
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FFIconButton(
                      borderColor: FFTheme.of(context).primary,
                      borderRadius: 20.0,
                      borderWidth: 2.0,
                      buttonSize: 40.0,
                      fillColor: FFTheme.of(context).secondaryBackground,
                      icon: Icon(
                        Icons.close,
                        color: FFTheme.of(context).primary,
                        size: 24.0,
                      ),
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 1.0,
                color: Color(0x5F14181B),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  height: 200.0,
                  decoration: BoxDecoration(
                    color: FFTheme.of(context).secondaryBackground,
                  ),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextField(
                          controller: myController,
                          decoration: new InputDecoration(
                              labelText: "Elija cantidad de tickets a generar"),
                          //keyboardType: TextInputType.number,
                          /*
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          */
                        ),
                        /*
                        FFButtonWidget(                          
                          onPressed: () async {
                            Navigator.pop(context);
                            await AddToCartCall.call(
                              userId: getJsonField(
                                FFAppState().jwtuser,
                                r'''$.ID''',
                              ),
                              productId: widget.idProduct,
                            );

                            context.pushNamed('webViewPage');
                          },
                          text: 'SELECCION AL sssAZAR',
                          icon: FaIcon(
                            FontAwesomeIcons.arrowRight,
                          ),
                          options: FFButtonOptions(
                            height: 50.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                24.0, 0.0, 24.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
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
                        */
                        Builder(
                          builder: (context) => FFButtonWidget(
                            onPressed: () async {
                              int randomsNeeded = int.parse(myController.text);
                              int randomsGen = 0;
                              List<int> randomedTickets = [];
                              var papeletas = functions
                                  .numberOfPapeletas(functions
                                      .numberOfPapeletas(widget.numberTickets!)
                                      .length
                                      .toString())
                                  .toList();
                              while (randomsNeeded != randomsGen) {
                                Random rnd;
                                int min = 0;
                                int max = papeletas.length;
                                rnd = new Random();
                                int r = min + rnd.nextInt(max - min);
                                bool isRepeated = false;

                                for (var j = 0;
                                    j < FFAppState().ticketsSelected.length;
                                    j++) {
                                  if (FFAppState().ticketsSelected[j] == r) {
                                    isRepeated = true;
                                  }
                                }

                                if (!isRepeated) {
                                  randomedTickets.add(r);
                                  randomsGen++;
                                }
                              }
                              _model.apiResultywtCopy =
                                  await AddToCartCall.call(
                                productId: widget.idProduct,
                                userId: getJsonField(
                                  FFAppState().jwtuser,
                                  r'''$.ID''',
                                ),
                                ticketsList: randomedTickets,
                              );
                              /*
                              String res = "";
                              for (int i = 0; i < randomedTickets.length; i++) {
                                res =
                                    res + randomedTickets[i].toString() + ", ";
                              }
                              myController.text = res;
                              */

                              Navigator.pop(context);

                              await showAlignedDialog(
                                barrierColor: Color(0xAA000000),
                                context: context,
                                isGlobal: true,
                                avoidOverflow: false,
                                targetAnchor: AlignmentDirectional(0.0, 0.0)
                                    .resolve(Directionality.of(context)),
                                followerAnchor: AlignmentDirectional(0.0, 0.0)
                                    .resolve(Directionality.of(context)),
                                builder: (dialogContext) {
                                  return Material(
                                    color: Colors.transparent,
                                    child: MidSelectComponentWidget(
                                      idProduct: widget.idProduct!,
                                      numberTickets: widget.numberTickets!,
                                      ticketsSelected: randomedTickets,
                                    ),
                                  );
                                },
                              ).then((value) => setState(() {}));
                            },
                            text: 'GENERAR AL AZAR',
                            icon: FaIcon(
                              FontAwesomeIcons.arrowRight,
                            ),
                            options: FFButtonOptions(
                              height: 50.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  24.0, 0.0, 24.0, 0.0),
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
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                        ),
                      ],
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
