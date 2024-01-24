import '/backend/api_requests/api_calls.dart';
import '/ff/ff_theme.dart';
import '/ff/ff_util.dart';
import '/ff/ff_widgets.dart';
import '/pages/loteries/components/lottery_select_component/lottery_select_component_widget.dart';
import '/ff/custom_functions.dart' as functions;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'bottom_navigation_widget_product_model.dart';
export 'bottom_navigation_widget_product_model.dart';
import 'dart:developer';

class BottomNavigationWidgetProductWidget extends StatefulWidget {
  const BottomNavigationWidgetProductWidget({
    Key? key,
    required this.idProduct,
    required this.metadata,
    required this.ticketsSelected,
    String? type,
  })  : this.type = type ?? 'Rifa',
        super(key: key);

  final int? idProduct;
  final dynamic metadata;
  final String type;
  final List<int> ticketsSelected;

  @override
  _BottomNavigationWidgetProductWidgetState createState() =>
      _BottomNavigationWidgetProductWidgetState();
}

class _BottomNavigationWidgetProductWidgetState
    extends State<BottomNavigationWidgetProductWidget> {
  late BottomNavigationWidgetProductModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BottomNavigationWidgetProductModel());
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
    log('data: $widget.metadata');
    return Container(
      width: MediaQuery.sizeOf(context).width * 1.0,
      height: 70.0,
      decoration: BoxDecoration(
        color: FFTheme.of(context).secondaryBackground,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          if (widget.type == 'lottery')
            Container(
              width: MediaQuery.sizeOf(context).width * 1.0,
              height: 70.0,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4.0,
                    color: Color(0x33000000),
                    offset: Offset(0.0, 2.0),
                  )
                ],
              ),
              child: Align(
                alignment: AlignmentDirectional(0.00, 0.00),
                child: Builder(
                  builder: (context) => FFButtonWidget(
                    onPressed: () async {
                      await showAlignedDialog(
                        barrierColor: Color(0x7F000000),
                        barrierDismissible: false,
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
                            child: Container(
                              height: MediaQuery.sizeOf(context).height * 3.0,
                              width: MediaQuery.sizeOf(context).width * 0.9,
                              child: LotterySelectComponentWidget(
                                idProduct: widget.idProduct!,
                                numberTickets:
                                    functions.maxParticipants(widget.metadata!),
                                ticketsSelected: widget.ticketsSelected,
                              ),
                            ),
                          );
                        },
                      ).then((value) => setState(() {}));
                    },
                    text: 'PARTICIPAR',
                    options: FFButtonOptions(
                      width: MediaQuery.sizeOf(context).width * 0.8,
                      height: 50.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FFTheme.of(context).primary,
                      textStyle: FFTheme.of(context).titleSmall.override(
                            fontFamily: 'Montserrat',
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                      elevation: 0.0,
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ),
            ),
          if (widget.type == 'rifa/venta')
            Container(
              width: MediaQuery.sizeOf(context).width * 1.0,
              height: 70.0,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4.0,
                    color: Color(0x33000000),
                    offset: Offset(0.0, 2.0),
                  )
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: AlignmentDirectional(0.00, 0.00),
                    child: Builder(
                      builder: (context) => FFButtonWidget(
                        onPressed: () async {
                          await showAlignedDialog(
                            barrierColor: Color(0x7F000000),
                            barrierDismissible: false,
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
                                child: Container(
                                  height:
                                      MediaQuery.sizeOf(context).height * 3.0,
                                  width: MediaQuery.sizeOf(context).width * 0.9,
                                  child: LotterySelectComponentWidget(
                                    idProduct: widget.idProduct!,
                                    numberTickets: functions
                                        .maxParticipants(widget.metadata!),
                                    ticketsSelected: widget.ticketsSelected,
                                  ),
                                ),
                              );
                            },
                          ).then((value) => setState(() {}));
                        },
                        text: 'PARTICIPAR',
                        options: FFButtonOptions(
                          width: MediaQuery.sizeOf(context).width * 0.4,
                          height: 50.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FFTheme.of(context).primary,
                          textStyle: FFTheme.of(context).titleSmall.override(
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                          elevation: 0.0,
                          borderSide: BorderSide(
                            color: Color(0x5914181B),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30.0),
                            bottomRight: Radius.circular(0.0),
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(0.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(0.00, 0.00),
                    child: FFButtonWidget(
                      onPressed: () async {
                        await AddToCartCall.call(
                          userId: getJsonField(
                            FFAppState().jwtuser,
                            r'''$.ID''',
                          ),
                          productId: widget.idProduct,
                        );

                        context.pushNamed('webViewPage');
                      },
                      text: 'COMPRAR',
                      options: FFButtonOptions(
                        width: MediaQuery.sizeOf(context).width * 0.4,
                        height: 50.0,
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FFTheme.of(context).primaryText,
                        textStyle: FFTheme.of(context).titleSmall.override(
                              fontFamily: 'Montserrat',
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                        elevation: 0.0,
                        borderSide: BorderSide(
                          color: Color(0x5914181B),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(0.0),
                          bottomRight: Radius.circular(30.0),
                          topLeft: Radius.circular(0.0),
                          topRight: Radius.circular(30.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          if (widget.type == 'simple')
            Container(
              width: MediaQuery.sizeOf(context).width * 1.0,
              height: 70.0,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4.0,
                    color: Color(0x33000000),
                    offset: Offset(0.0, 2.0),
                  )
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: AlignmentDirectional(0.00, 0.00),
                    child: FFButtonWidget(
                      onPressed: () async {
                        await AddToCartCall.call(
                          userId: getJsonField(
                            FFAppState().jwtuser,
                            r'''$.ID''',
                          ),
                          productId: widget.idProduct,
                        );

                        context.pushNamed('webViewPage');
                      },
                      text: 'COMPRAR',
                      options: FFButtonOptions(
                        width: MediaQuery.sizeOf(context).width * 0.8,
                        height: 50.0,
                        padding: EdgeInsetsDirectional.fromSTEB(
                            24.0, 0.0, 24.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FFTheme.of(context).primaryText,
                        textStyle: FFTheme.of(context).titleSmall.override(
                              fontFamily: 'Montserrat',
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                        elevation: 0.0,
                        borderSide: BorderSide(
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
