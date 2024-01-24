import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/components/legal_base_component_widget.dart';
import '/components/price_component_widget.dart';
import '/ff/ff_animations.dart';
import '/ff/ff_icon_button.dart';
import '/ff/ff_theme.dart';
import '/ff/ff_util.dart';
import '/ff/ff_widgets.dart';
import '/pages/loteries/components/bottom_navigation_widget_product/bottom_navigation_widget_product_widget.dart';
import '/ff/custom_functions.dart' as functions;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'product_detail_model.dart';
export 'product_detail_model.dart';

class ProductDetailWidget extends StatefulWidget {
  const ProductDetailWidget({
    Key? key,
    int? idProduct,
  })  : this.idProduct = idProduct ?? 0,
        super(key: key);

  final int idProduct;

  @override
  _ProductDetailWidgetState createState() => _ProductDetailWidgetState();
}

class _ProductDetailWidgetState extends State<ProductDetailWidget>
    with TickerProviderStateMixin {
  late ProductDetailModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = {
    'textOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        VisibilityEffect(duration: 300.ms),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 300.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 300.ms,
          duration: 600.ms,
          begin: Offset(0.0, 60.0),
          end: Offset(0.0, 0.0),
        ),
      ],
    ),
    'imageOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        VisibilityEffect(duration: 1.ms),
        FadeEffect(
          curve: Curves.easeOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
        MoveEffect(
          curve: Curves.easeOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: Offset(230.0, 0.0),
          end: Offset(0.0, 0.0),
        ),
      ],
    ),
  };

  @override
  initState() {
    super.initState();
    _model = createModel(context, () => ProductDetailModel());

    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );
    //_model.apiCallser = await viewProduct.call(productId: widget.idProduct);
    _asyncMethod();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  _asyncMethod() async {
    _model.apiCallser = await viewProduct.call(productId: widget.idProduct);
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

    return FutureBuilder<ApiCallResponse>(
      future: GetSingleProductCall.call(
        idProduct: widget.idProduct,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FFTheme.of(context).secondaryBackground,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FFTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }
        final productDetailGetSingleProductResponse = snapshot.data!;
        return GestureDetector(
          onTap: () => _model.unfocusNode.canRequestFocus
              ? FocusScope.of(context).requestFocus(_model.unfocusNode)
              : FocusScope.of(context).unfocus(),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FFTheme.of(context).secondaryBackground,
            body: SafeArea(
              top: true,
              child: Stack(
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 70.0),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: FFTheme.of(context).secondaryBackground,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  24.0, 40.0, 0.0, 0.0),
                              child: Text(
                                getJsonField(
                                  productDetailGetSingleProductResponse
                                      .jsonBody,
                                  r'''$.name''',
                                ).toString(),
                                textAlign: TextAlign.center,
                                style:
                                    FFTheme.of(context).headlineMedium.override(
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w900,
                                        ),
                              ).animateOnPageLoad(
                                  animationsMap['textOnPageLoadAnimation']!),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  10.0, 10.0, 10.0, 10.0),
                              child: Container(
                                width: MediaQuery.sizeOf(context).width * 1.0,
                                height: MediaQuery.sizeOf(context).height * 0.4,
                                decoration: BoxDecoration(
                                  color:
                                      FFTheme.of(context).secondaryBackground,
                                ),
                                child: Card(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  color: FFTheme.of(context).alternate,
                                  elevation: 4.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  child: Container(
                                    width:
                                        MediaQuery.sizeOf(context).width * 1.0,
                                    height:
                                        MediaQuery.sizeOf(context).height * 0.4,
                                    decoration: BoxDecoration(
                                      color: FFTheme.of(context)
                                          .secondaryBackground,
                                    ),
                                    child: Image.network(
                                      getJsonField(
                                        productDetailGetSingleProductResponse
                                            .jsonBody,
                                        r'''$.images[0].src''',
                                      ),
                                      width: double.infinity,
                                      height: 320.0,
                                      fit: BoxFit.fitWidth,
                                    ).animateOnPageLoad(animationsMap[
                                        'imageOnPageLoadAnimation']!),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.sizeOf(context).width * 1.0,
                              height: 100.0,
                              decoration: BoxDecoration(
                                color: FFTheme.of(context).secondaryBackground,
                              ),
                              child: wrapWithModel(
                                model: _model.priceComponentModel,
                                updateCallback: () => setState(() {}),
                                child: PriceComponentWidget(
                                  price: getJsonField(
                                    productDetailGetSingleProductResponse
                                        .jsonBody,
                                    r'''$.price''',
                                  ).toString().replaceAll(".", ","),
                                  regularPrice: getJsonField(
                                    productDetailGetSingleProductResponse
                                        .jsonBody,
                                    r'''$.regular_price''',
                                  ).toString(),
                                  type: functions.productType(getJsonField(
                                    productDetailGetSingleProductResponse
                                        .jsonBody,
                                    r'''$.meta_data''',
                                    true,
                                  )!),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 10.0, 0.0, 10.0),
                              child: Stack(
                                children: [
                                  Material(
                                    color: Colors.transparent,
                                    elevation: 0.0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                    child: Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          1.0,
                                      height: 50.0,
                                      decoration: BoxDecoration(
                                        color: FFTheme.of(context)
                                            .secondaryBackground,
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        border: Border.all(
                                          color: FFTheme.of(context).alternate,
                                          width: 0.0,
                                        ),
                                      ),
                                      child: Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.0,
                                        height: 100.0,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Color(0xFF6FBF6B),
                                              FFTheme.of(context)
                                                  .secondaryBackground
                                            ],
                                            stops: [0.0, 1.0],
                                            begin:
                                                AlignmentDirectional(1.0, 0.0),
                                            end: AlignmentDirectional(-1.0, 0),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(0.00, 1.00),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 5.0, 0.0, 0.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            'Papeletas vendidas',
                                            style: FFTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                          Text(
                                            '${getJsonField(
                                              productDetailGetSingleProductResponse
                                                  .jsonBody,
                                              r'''$.participants''',
                                            ).toString()} de ${functions.maxParticipants(getJsonField(
                                              productDetailGetSingleProductResponse
                                                  .jsonBody,
                                              r'''$.meta_data''',
                                              true,
                                            )!)}',
                                            style: FFTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.w800,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 12.0, 0.0, 0.0),
                              child: Container(
                                width: MediaQuery.sizeOf(context).width * 1.0,
                                height: 100.0,
                                decoration: BoxDecoration(
                                  color:
                                      FFTheme.of(context).secondaryBackground,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.45,
                                      height: 100.0,
                                      decoration: BoxDecoration(
                                        color: FFTheme.of(context)
                                            .secondaryBackground,
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        border: Border.all(
                                          color: FFTheme.of(context).primary,
                                          width: 1.5,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Tipo Sorteo',
                                            style: FFTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Montserrat',
                                                  color: FFTheme.of(context)
                                                      .primary,
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                          Text(
                                            valueOrDefault<String>(
                                              functions.rifaType(getJsonField(
                                                productDetailGetSingleProductResponse
                                                    .jsonBody,
                                                r'''$.meta_data''',
                                                true,
                                              )!),
                                              '[]',
                                            ),
                                            textAlign: TextAlign.center,
                                            style: FFTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                        ].divide(SizedBox(height: 10.0)),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.45,
                                      height: 100.0,
                                      decoration: BoxDecoration(
                                        color: FFTheme.of(context)
                                            .secondaryBackground,
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        border: Border.all(
                                          color: FFTheme.of(context).primary,
                                          width: 1.5,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Estado producto',
                                            style: FFTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Montserrat',
                                                  color: FFTheme.of(context)
                                                      .primary,
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                          Text(
                                            valueOrDefault<String>(
                                              functions.findProductState(
                                                  getJsonField(
                                                productDetailGetSingleProductResponse
                                                    .jsonBody,
                                                r'''$.meta_data''',
                                                true,
                                              )!),
                                              'N/A',
                                            ),
                                            textAlign: TextAlign.center,
                                            style: FFTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                        ].divide(SizedBox(height: 10.0)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 12.0, 0.0, 0.0),
                              child: Container(
                                width: MediaQuery.sizeOf(context).width * 1.0,
                                height: 100.0,
                                decoration: BoxDecoration(
                                  color:
                                      FFTheme.of(context).secondaryBackground,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.45,
                                      height: 100.0,
                                      decoration: BoxDecoration(
                                        color: FFTheme.of(context)
                                            .secondaryBackground,
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        border: Border.all(
                                          color: FFTheme.of(context).primary,
                                          width: 1.5,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Envios',
                                            style: FFTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Montserrat',
                                                  color: FFTheme.of(context)
                                                      .primary,
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                          Text(
                                            'Solo Peninsula',
                                            textAlign: TextAlign.center,
                                            style: FFTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                        ].divide(SizedBox(height: 10.0)),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.45,
                                      height: 100.0,
                                      decoration: BoxDecoration(
                                        color: FFTheme.of(context)
                                            .secondaryBackground,
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        border: Border.all(
                                          color: FFTheme.of(context).primary,
                                          width: 1.5,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Origen',
                                            style: FFTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Montserrat',
                                                  color: FFTheme.of(context)
                                                      .primary,
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                          Text(
                                            'Villanueva de la vera',
                                            textAlign: TextAlign.center,
                                            style: FFTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                        ].divide(SizedBox(height: 10.0)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 12.0, 0.0, 0.0),
                              child: Container(
                                width: MediaQuery.sizeOf(context).width * 1.0,
                                height: 100.0,
                                decoration: BoxDecoration(
                                  color:
                                      FFTheme.of(context).secondaryBackground,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.45,
                                      height: 100.0,
                                      decoration: BoxDecoration(
                                        color: FFTheme.of(context)
                                            .secondaryBackground,
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        border: Border.all(
                                          color: FFTheme.of(context).primary,
                                          width: 1.5,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Rifador',
                                            style: FFTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Montserrat',
                                                  color: FFTheme.of(context)
                                                      .primary,
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                          Text(
                                            getJsonField(
                                              productDetailGetSingleProductResponse
                                                  .jsonBody,
                                              r'''$.author.name''',
                                            ).toString(),
                                            textAlign: TextAlign.center,
                                            style: FFTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                        ].divide(SizedBox(height: 10.0)),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.45,
                                      height: 100.0,
                                      decoration: BoxDecoration(
                                        color: FFTheme.of(context)
                                            .secondaryBackground,
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        border: Border.all(
                                          color: FFTheme.of(context).primary,
                                          width: 1.5,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Categoria',
                                            style: FFTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Montserrat',
                                                  color: FFTheme.of(context)
                                                      .primary,
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                          Text(
                                            valueOrDefault<String>(
                                              getJsonField(
                                                productDetailGetSingleProductResponse
                                                    .jsonBody,
                                                r'''$.categories[0].name''',
                                              ).toString(),
                                              'N/A',
                                            ),
                                            textAlign: TextAlign.center,
                                            style: FFTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                        ].divide(SizedBox(height: 10.0)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 12.0, 0.0, 0.0),
                              child: Container(
                                width: MediaQuery.sizeOf(context).width * 1.0,
                                height: 100.0,
                                decoration: BoxDecoration(
                                  color:
                                      FFTheme.of(context).secondaryBackground,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.45,
                                      height: 100.0,
                                      decoration: BoxDecoration(
                                        color: FFTheme.of(context)
                                            .secondaryBackground,
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        border: Border.all(
                                          color: FFTheme.of(context).primary,
                                          width: 1.5,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Visto',
                                            style: FFTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Montserrat',
                                                  color: FFTheme.of(context)
                                                      .primary,
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                          Text(
                                            '${functions.totalViews(getJsonField(
                                              productDetailGetSingleProductResponse
                                                  .jsonBody,
                                              r'''$.meta_data''',
                                              true,
                                            )!)}  veces',
                                            textAlign: TextAlign.center,
                                            style: FFTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                        ].divide(SizedBox(height: 10.0)),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.45,
                                      height: 100.0,
                                      decoration: BoxDecoration(
                                        color: FFTheme.of(context)
                                            .secondaryBackground,
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        border: Border.all(
                                          color: FFTheme.of(context).primary,
                                          width: 1.5,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Marcado favorito',
                                            style: FFTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Montserrat',
                                                  color: FFTheme.of(context)
                                                      .primary,
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                          Text(
                                            '0 veces',
                                            textAlign: TextAlign.center,
                                            style: FFTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                        ].divide(SizedBox(height: 10.0)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(0.00, 0.00),
                              child: Builder(
                                builder: (context) => Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 10.0, 0.0, 10.0),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      await showAlignedDialog(
                                        barrierColor: Color(0x8A14181B),
                                        context: context,
                                        isGlobal: true,
                                        avoidOverflow: false,
                                        targetAnchor:
                                            AlignmentDirectional(0.0, 0.0)
                                                .resolve(
                                                    Directionality.of(context)),
                                        followerAnchor:
                                            AlignmentDirectional(0.0, 0.0)
                                                .resolve(
                                                    Directionality.of(context)),
                                        builder: (dialogContext) {
                                          return Material(
                                            color: Colors.transparent,
                                            child: WebViewAware(
                                                child: GestureDetector(
                                              onTap: () => _model.unfocusNode
                                                      .canRequestFocus
                                                  ? FocusScope.of(context)
                                                      .requestFocus(
                                                          _model.unfocusNode)
                                                  : FocusScope.of(context)
                                                      .unfocus(),
                                              child: Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.9,
                                                child:
                                                    LegalBaseComponentWidget(),
                                              ),
                                            )),
                                          );
                                        },
                                      ).then((value) => setState(() {}));
                                    },
                                    child: Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          1.0,
                                      decoration: BoxDecoration(
                                        color: FFTheme.of(context)
                                            .secondaryBackground,
                                      ),
                                      child: Align(
                                        alignment:
                                            AlignmentDirectional(0.00, 0.00),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 10.0, 0.0, 10.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.remove_red_eye,
                                                color:
                                                    FFTheme.of(context).primary,
                                                size: 24.0,
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        10.0, 0.0, 0.0, 0.0),
                                                child: Text(
                                                  'Ver bases legales de participacion',
                                                  style: FFTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Montserrat',
                                                        color:
                                                            FFTheme.of(context)
                                                                .primary,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 10.0, 0.0, 10.0),
                              child: Container(
                                width: MediaQuery.sizeOf(context).width * 1.0,
                                decoration: BoxDecoration(
                                  color:
                                      FFTheme.of(context).secondaryBackground,
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 10.0, 0.0, 10.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Descripcion del producto',
                                        textAlign: TextAlign.start,
                                        style: FFTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Montserrat',
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w800,
                                            ),
                                      ),
                                      Divider(
                                        thickness: 1.0,
                                        color: FFTheme.of(context).primaryText,
                                      ),
                                      Html(
                                        data: getJsonField(
                                          productDetailGetSingleProductResponse
                                              .jsonBody,
                                          r'''$.description''',
                                        ).toString(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 10.0, 0.0, 10.0),
                              child: Container(
                                width: MediaQuery.sizeOf(context).width * 1.0,
                                decoration: BoxDecoration(
                                  color:
                                      FFTheme.of(context).secondaryBackground,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Papeletas compradas',
                                      textAlign: TextAlign.start,
                                      style: FFTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Montserrat',
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w800,
                                          ),
                                    ),
                                    Divider(
                                      thickness: 1.0,
                                      color: FFTheme.of(context).primaryText,
                                    ),
                                    Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          1.0,
                                      height: 200.0,
                                      decoration: BoxDecoration(
                                        color: FFTheme.of(context)
                                            .secondaryBackground,
                                      ),
                                      child: FutureBuilder<ApiCallResponse>(
                                        future: TicketsComprados.call(
                                            user_id: getJsonField(
                                              FFAppState().jwtuser,
                                              r'''$.ID''',
                                            ).toString(),
                                            product_id:
                                                widget.idProduct.toString()),
                                        builder: (context, snapshot) {
                                          final ticketsAlt = snapshot.data!;
                                          var tickets = getJsonField(
                                            ticketsAlt.jsonBody,
                                            r'''$''',
                                          );
                                          if (getJsonField(
                                                ticketsAlt.jsonBody,
                                                r'''$.status''',
                                              ) ==
                                              "success") {
                                            tickets = [];
                                          }
                                          /*
                                          final tickets = FFAppState()
                                              .ticketsSelected
                                              .toList();
                                              */
                                          return GridView.builder(
                                            padding: EdgeInsets.zero,
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 7,
                                              crossAxisSpacing: 10.0,
                                              mainAxisSpacing: 10.0,
                                              childAspectRatio: 1.0,
                                            ),
                                            scrollDirection: Axis.vertical,
                                            itemCount: tickets.length,
                                            itemBuilder:
                                                (context, ticketsIndex) {
                                              final ticketsItem =
                                                  tickets[ticketsIndex];
                                              return Container(
                                                width: 120.0,
                                                height: 50.0,
                                                decoration: BoxDecoration(
                                                  color: FFTheme.of(context)
                                                      .secondaryBackground,
                                                  image: DecorationImage(
                                                    fit: BoxFit.fitWidth,
                                                    image: Image.asset(
                                                      'assets/images/LOGO-RIFAMAS-papeleta-small.webp',
                                                    ).image,
                                                  ),
                                                ),
                                                child: Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.00, 0.00),
                                                  child: Text(
                                                    ticketsItem.toString(),
                                                    style: FFTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Montserrat',
                                                          color: FFTheme.of(
                                                                  context)
                                                              .secondaryBackground,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      ),
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
                  Container(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: FFTheme.of(context).secondaryBackground,
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          10.0, 10.0, 10.0, 10.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FFIconButton(
                            borderRadius: 20.0,
                            borderWidth: 1.0,
                            buttonSize: 40.0,
                            icon: FaIcon(
                              FontAwesomeIcons.arrowLeft,
                              color: FFTheme.of(context).primary,
                              size: 24.0,
                            ),
                            onPressed: () async {
                              context.safePop();
                            },
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Builder(
                                builder: (context) => Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5.0, 0.0, 5.0, 0.0),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      await Share.share(
                                        'https://staging.rifamas.es/producto/${getJsonField(
                                          productDetailGetSingleProductResponse
                                              .jsonBody,
                                          r'''$.slug''',
                                        ).toString()}',
                                        sharePositionOrigin:
                                            getWidgetBoundingBox(context),
                                      );
                                    },
                                    child: Icon(
                                      Icons.share_outlined,
                                      color: FFTheme.of(context).primary,
                                      size: 22.0,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    5.0, 0.0, 5.0, 0.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    var chatsRecordReference =
                                        ChatsRecord.collection.doc();
                                    await chatsRecordReference.set({
                                      ...createChatsRecordData(
                                        product: getJsonField(
                                          productDetailGetSingleProductResponse
                                              .jsonBody,
                                          r'''$.name''',
                                        ).toString(),
                                        seller: getJsonField(
                                          productDetailGetSingleProductResponse
                                              .jsonBody,
                                          r'''$.author.name''',
                                        ).toString(),
                                        image: getJsonField(
                                          productDetailGetSingleProductResponse
                                              .jsonBody,
                                          r'''$.images[0].src''',
                                        ),
                                      ),
                                      ...mapToFirestore(
                                        {
                                          'last_message_time':
                                              FieldValue.serverTimestamp(),
                                        },
                                      ),
                                    });
                                    _model.chatResponse =
                                        ChatsRecord.getDocumentFromData({
                                      ...createChatsRecordData(
                                        product: getJsonField(
                                          productDetailGetSingleProductResponse
                                              .jsonBody,
                                          r'''$.name''',
                                        ).toString(),
                                        seller: getJsonField(
                                          productDetailGetSingleProductResponse
                                              .jsonBody,
                                          r'''$.author.name''',
                                        ).toString(),
                                        image: getJsonField(
                                          productDetailGetSingleProductResponse
                                              .jsonBody,
                                          r'''$.images[0].src''',
                                        ),
                                      ),
                                      ...mapToFirestore(
                                        {
                                          'last_message_time': DateTime.now(),
                                        },
                                      ),
                                    }, chatsRecordReference);

                                    context.pushNamed(
                                      'chatSinglePage',
                                      queryParameters: {
                                        'chatReference': serializeParam(
                                          _model.chatResponse?.reference,
                                          ParamType.DocumentReference,
                                        ),
                                        'chat': serializeParam(
                                          _model.chatResponse,
                                          ParamType.Document,
                                        ),
                                      }.withoutNulls,
                                      extra: <String, dynamic>{
                                        'chat': _model.chatResponse,
                                      },
                                    );

                                    setState(() {});
                                  },
                                  child: FaIcon(
                                    FontAwesomeIcons.comment,
                                    color: FFTheme.of(context).primary,
                                    size: 22.0,
                                  ),
                                ),
                              ),
                              if (FFAppState()
                                      .favorites
                                      .toList()
                                      .contains(widget.idProduct) ==
                                  false)
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5.0, 0.0, 5.0, 0.0),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      setState(() {
                                        FFAppState()
                                            .addToFavorites(widget.idProduct);
                                      });
                                    },
                                    child: FaIcon(
                                      FontAwesomeIcons.heart,
                                      color: FFTheme.of(context).primary,
                                      size: 22.0,
                                    ),
                                  ),
                                ),
                              if (FFAppState()
                                  .favorites
                                  .toList()
                                  .contains(widget.idProduct))
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5.0, 0.0, 5.0, 0.0),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      setState(() {
                                        FFAppState().removeFromFavorites(
                                            widget.idProduct);
                                      });
                                    },
                                    child: Icon(
                                      Icons.favorite_sharp,
                                      color: FFTheme.of(context).primary,
                                      size: 22.0,
                                    ),
                                  ),
                                ),
                            ].divide(SizedBox(width: 5.0)),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                '${FFAppState().currentBalance} ',
                                style: FFTheme.of(context).titleLarge.override(
                                      fontFamily: 'Readex Pro',
                                      color: FFTheme.of(context).primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              Text(
                                '€',
                                style: FFTheme.of(context).titleLarge.override(
                                      fontFamily: 'Readex Pro',
                                      color: FFTheme.of(context).primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(0.00, 1.00),
                    child: wrapWithModel(
                      model: _model.bottomNavigationWidgetProductModel,
                      updateCallback: () => setState(() {}),
                      child: BottomNavigationWidgetProductWidget(
                        idProduct: widget.idProduct,
                        metadata: getJsonField(
                          productDetailGetSingleProductResponse.jsonBody,
                          r'''$.meta_data''',
                        ),
                        type: functions.productType(getJsonField(
                          productDetailGetSingleProductResponse.jsonBody,
                          r'''$.meta_data''',
                          true,
                        )!),
                        ticketsSelected: FFAppState().ticketsSelected.toList(),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: FFTheme.of(context).secondaryBackground,
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          10.0, 10.0, 10.0, 10.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FFIconButton(
                            borderColor: Colors.transparent,
                            borderRadius: 20.0,
                            borderWidth: 1.0,
                            buttonSize: 40.0,
                            icon: FaIcon(
                              FontAwesomeIcons.arrowLeft,
                              color: FFTheme.of(context).primary,
                              size: 24.0,
                            ),
                            onPressed: () async {
                              context.safePop();
                            },
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Builder(
                                builder: (context) => Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5.0, 0.0, 5.0, 0.0),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      await Share.share(
                                        'https://staging.rifamas.es/producto/${getJsonField(
                                          productDetailGetSingleProductResponse
                                              .jsonBody,
                                          r'''$.slug''',
                                        ).toString()}',
                                        sharePositionOrigin:
                                            getWidgetBoundingBox(context),
                                      );
                                    },
                                    child: Icon(
                                      Icons.share_outlined,
                                      color: FFTheme.of(context).primary,
                                      size: 22.0,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    5.0, 0.0, 5.0, 0.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    var chatsRecordReference =
                                        ChatsRecord.collection.doc();
                                    await chatsRecordReference.set({
                                      ...createChatsRecordData(
                                        product: getJsonField(
                                          productDetailGetSingleProductResponse
                                              .jsonBody,
                                          r'''$.name''',
                                        ).toString(),
                                        seller: getJsonField(
                                          productDetailGetSingleProductResponse
                                              .jsonBody,
                                          r'''$.author.name''',
                                        ).toString(),
                                        image: getJsonField(
                                          productDetailGetSingleProductResponse
                                              .jsonBody,
                                          r'''$.images[0].src''',
                                        ),
                                      ),
                                      ...mapToFirestore(
                                        {
                                          'last_message_time':
                                              FieldValue.serverTimestamp(),
                                          'users': (String user1, int user2) {
                                            return [int.parse(user1), user2];
                                          }(
                                              getJsonField(
                                                productDetailGetSingleProductResponse
                                                    .jsonBody,
                                                r'''$.author.id''',
                                              ).toString(),
                                              getJsonField(
                                                FFAppState().jwtuser,
                                                r'''$.ID''',
                                              )),
                                        },
                                      ),
                                    });
                                    _model.chatResponseProduct =
                                        ChatsRecord.getDocumentFromData({
                                      ...createChatsRecordData(
                                        product: getJsonField(
                                          productDetailGetSingleProductResponse
                                              .jsonBody,
                                          r'''$.name''',
                                        ).toString(),
                                        seller: getJsonField(
                                          productDetailGetSingleProductResponse
                                              .jsonBody,
                                          r'''$.author.name''',
                                        ).toString(),
                                        image: getJsonField(
                                          productDetailGetSingleProductResponse
                                              .jsonBody,
                                          r'''$.images[0].src''',
                                        ),
                                      ),
                                      ...mapToFirestore(
                                        {
                                          'last_message_time': DateTime.now(),
                                          'users': (String user1, int user2) {
                                            return [int.parse(user1), user2];
                                          }(
                                              getJsonField(
                                                productDetailGetSingleProductResponse
                                                    .jsonBody,
                                                r'''$.author.id''',
                                              ).toString(),
                                              getJsonField(
                                                FFAppState().jwtuser,
                                                r'''$.ID''',
                                              )),
                                        },
                                      ),
                                    }, chatsRecordReference);

                                    context.pushNamed(
                                      'chatSinglePage',
                                      queryParameters: {
                                        'chatReference': serializeParam(
                                          _model.chatResponseProduct?.reference,
                                          ParamType.DocumentReference,
                                        ),
                                        'chat': serializeParam(
                                          _model.chatResponseProduct,
                                          ParamType.Document,
                                        ),
                                      }.withoutNulls,
                                      extra: <String, dynamic>{
                                        'chat': _model.chatResponseProduct,
                                      },
                                    );

                                    setState(() {});
                                  },
                                  child: FaIcon(
                                    FontAwesomeIcons.comment,
                                    color: FFTheme.of(context).primary,
                                    size: 22.0,
                                  ),
                                ),
                              ),
                              if (FFAppState()
                                      .favorites
                                      .toList()
                                      .contains(widget.idProduct) ==
                                  false)
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5.0, 0.0, 5.0, 0.0),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      await markAsFavorite.call(
                                        userId: getJsonField(
                                          FFAppState().jwtuser,
                                          r'''$.ID''',
                                        ),
                                        productId: widget.idProduct,
                                      );
                                      setState(() {
                                        FFAppState()
                                            .addToFavorites(widget.idProduct);
                                      });

                                      await markAsFavorite.call(
                                        userId: getJsonField(
                                          FFAppState().jwtuser,
                                          r'''$.ID''',
                                        ),
                                        productId: widget.idProduct,
                                      );
                                    },
                                    child: FaIcon(
                                      FontAwesomeIcons.heart,
                                      color: FFTheme.of(context).primary,
                                      size: 22.0,
                                    ),
                                  ),
                                ),
                              if (FFAppState()
                                  .favorites
                                  .toList()
                                  .contains(widget.idProduct))
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5.0, 0.0, 5.0, 0.0),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      setState(() {
                                        FFAppState().removeFromFavorites(
                                            widget.idProduct);
                                      });
                                    },
                                    child: Icon(
                                      Icons.favorite_sharp,
                                      color: FFTheme.of(context).primary,
                                      size: 22.0,
                                    ),
                                  ),
                                ),
                            ].divide(SizedBox(width: 5.0)),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                (String balance) {
                                  return balance.replaceAll(".", ",");
                                }(FFAppState().currentBalance),
                                style: FFTheme.of(context).titleLarge.override(
                                      fontFamily: 'Readex Pro',
                                      color: FFTheme.of(context).primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              Text(
                                '€',
                                style: FFTheme.of(context).titleLarge.override(
                                      fontFamily: 'Readex Pro',
                                      color: FFTheme.of(context).primary,
                                      fontWeight: FontWeight.w600,
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
        );
      },
    );
  }
}
