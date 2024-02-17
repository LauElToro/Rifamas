import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/ff/ff_icon_button.dart';
import '/ff/ff_theme.dart';
import '/ff/ff_util.dart';
import '/ff/ff_widgets.dart';
import '/pages/memeberships/selectedgift_page/selectedgift_page_widget.dart';
import '/ff/custom_functions.dart' as functions;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'member_page_detail_model.dart';
export 'member_page_detail_model.dart';

class MemberPageDetailWidget extends StatefulWidget {
  const MemberPageDetailWidget({
    Key? key,
    required this.idMembresy,
  }) : super(key: key);

  final int? idMembresy;

  @override
  _MemberPageDetailWidgetState createState() => _MemberPageDetailWidgetState();
}

class _MemberPageDetailWidgetState extends State<MemberPageDetailWidget> {
  late MemberPageDetailModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MemberPageDetailModel());

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

    return FutureBuilder<ApiCallResponse>(
      future: GetSingleProductCall.call(
        idProduct: widget.idMembresy,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        print(widget.idMembresy);
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
        final memberPageDetailGetSingleProductResponse = snapshot.data!;
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
                        EdgeInsetsDirectional.fromSTEB(0.0, 100.0, 0.0, 0.0),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      height: MediaQuery.sizeOf(context).height * 1.0,
                      decoration: BoxDecoration(
                        color: FFTheme.of(context).secondaryBackground,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  10.0, 0.0, 10.0, 0.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    getJsonField(
                                      memberPageDetailGetSingleProductResponse
                                          .jsonBody,
                                      r'''$.name''',
                                    ).toString(),
                                    style: FFTheme.of(context)
                                        .headlineSmall
                                        .override(
                                          fontFamily: 'Montserrat',
                                          color: FFTheme.of(context).primary,
                                          fontWeight: FontWeight.w900,
                                        ),
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      valueOrDefault<String>(
                                        getJsonField(
                                          memberPageDetailGetSingleProductResponse
                                              .jsonBody,
                                          r'''$.images[0].src''',
                                        ),
                                        'http://',
                                      ),
                                      width: MediaQuery.sizeOf(context).width *
                                          1.0,
                                      height: 200.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Html(
                                    data: getJsonField(
                                      memberPageDetailGetSingleProductResponse
                                          .jsonBody,
                                      r'''$.description''',
                                    ).toString(),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.sizeOf(context).width * 1.0,
                                    height: 200.0,
                                    decoration: BoxDecoration(
                                      color: FFTheme.of(context)
                                          .secondaryBackground,
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: FutureBuilder<ApiCallResponse>(
                                      future: GetRelatedProductsCall.call(
                                        idMembershipData:
                                            widget.idMembresy?.toString(),
                                      ),
                                      builder: (context, snapshot) {
                                        // Customize what your widget looks like when it's loading.
                                        if (!snapshot.hasData) {
                                          return Center(
                                            child: SizedBox(
                                              width: 50.0,
                                              height: 50.0,
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(
                                                  FFTheme.of(context).primary,
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                        final rowGetRelatedProductsResponse =
                                            snapshot.data!;
                                        return Builder(
                                          builder: (context) {
                                            final relatedLit = getJsonField(
                                              rowGetRelatedProductsResponse
                                                  .jsonBody,
                                              r'''$''',
                                            ).toList();
                                            // if (relatedLit[0]['images'].length == 0) {
                                            //   return Text("No hay imagenes");
                                            // }
                                            return Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: List.generate(
                                                  relatedLit.length,
                                                  (relatedLitIndex) {
                                                final relatedLitItem =
                                                    relatedLit[relatedLitIndex];
                                                return Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Builder(
                                                      builder: (context) =>
                                                          InkWell(
                                                        splashColor:
                                                            Colors.transparent,
                                                        focusColor:
                                                            Colors.transparent,
                                                        hoverColor:
                                                            Colors.transparent,
                                                        highlightColor:
                                                            Colors.transparent,
                                                        onTap: () async {
                                                          setState(() {
                                                            _model.imageSelected =
                                                                getJsonField(
                                                              relatedLitItem,
                                                              r'''$.image''',
                                                            );
                                                          });
                                                          await Future.delayed(
                                                              const Duration(
                                                                  milliseconds:
                                                                      1000));
                                                          await showAlignedDialog(
                                                            barrierColor: Color(
                                                                0xAD000000),
                                                            context: context,
                                                            isGlobal: true,
                                                            avoidOverflow:
                                                                false,
                                                            targetAnchor:
                                                                AlignmentDirectional(
                                                                        0.0,
                                                                        0.0)
                                                                    .resolve(
                                                                        Directionality.of(
                                                                            context)),
                                                            followerAnchor:
                                                                AlignmentDirectional(
                                                                        0.0,
                                                                        0.0)
                                                                    .resolve(
                                                                        Directionality.of(
                                                                            context)),
                                                            builder:
                                                                (dialogContext) {
                                                              return Material(
                                                                color: Colors
                                                                    .transparent,
                                                                child:
                                                                    GestureDetector(
                                                                  onTap: () => _model
                                                                          .unfocusNode
                                                                          .canRequestFocus
                                                                      ? FocusScope.of(
                                                                              context)
                                                                          .requestFocus(_model
                                                                              .unfocusNode)
                                                                      : FocusScope.of(
                                                                              context)
                                                                          .unfocus(),
                                                                  child:
                                                                      Container(
                                                                    height:
                                                                        300.0,
                                                                    width: MediaQuery.sizeOf(context)
                                                                            .width *
                                                                        0.8,
                                                                    child:
                                                                        SelectedgiftPageWidget(
                                                                      image:
                                                                          getJsonField(
                                                                        relatedLitItem,
                                                                        r'''$.images[0].src''',
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          ).then((value) =>
                                                              setState(() {}));
                                                        },
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                          child: Image.network(
                                                            getJsonField(
                                                              relatedLitItem,
                                                              r'''$.images[0].src''',
                                                            ),
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                0.3,
                                                            height: 120.0,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    if (getJsonField(
                                                          relatedLitItem,
                                                          r'''$.name''',
                                                        ).toString().length <
                                                        15)
                                                      Text(
                                                        getJsonField(
                                                          relatedLitItem,
                                                          r'''$.name''',
                                                        ).toString(),
                                                        style:
                                                            FFTheme.of(context)
                                                                .bodyMedium,
                                                      )
                                                    else
                                                      Text(getJsonField(
                                                            relatedLitItem,
                                                            r'''$.name''',
                                                          )
                                                              .toString()
                                                              .substring(
                                                                  0, 15) +
                                                          "..."),
                                                    Text(
                                                      'SORTEO ',
                                                      style: FFTheme.of(context)
                                                          .bodyMedium,
                                                    ),
                                                  ],
                                                );
                                              }).divide(SizedBox(width: 5.0)),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 15.0, 0.0, 0.0),
                                    child: Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          1.0,
                                      height: 130.0,
                                      decoration: BoxDecoration(
                                        color: FFTheme.of(context)
                                            .secondaryBackground,
                                      ),
                                      child: Builder(
                                        builder: (context) {
                                          final cuotasLit = getJsonField(
                                            memberPageDetailGetSingleProductResponse
                                                .jsonBody,
                                            r'''$.variation_id''',
                                          ).toList().take(3).toList();

                                          return Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children:
                                                List.generate(cuotasLit.length,
                                                    (cuotasLitIndex) {
                                              final cuotasLitItem =
                                                  cuotasLit[cuotasLitIndex];
                                              return InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  setState(() {
                                                    _model.suscription =
                                                        getJsonField(
                                                      cuotasLitItem,
                                                      r'''$.variation_id''',
                                                    );
                                                  });
                                                },
                                                child: Container(
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.27,
                                                  height: 130.0,
                                                  decoration: BoxDecoration(
                                                    color: _model.suscription ==
                                                            getJsonField(
                                                              cuotasLitItem,
                                                              r'''$.variation_id''',
                                                            )
                                                        ? FFTheme.of(context)
                                                            .primary
                                                        : Color(0x00000000),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                    border: Border.all(
                                                      color: FFTheme.of(context)
                                                          .primary,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 10.0,
                                                                0.0, 10.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          'SUSCRIPCION',
                                                          style:
                                                              FFTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Montserrat',
                                                                    color: _model
                                                                                .suscription ==
                                                                            getJsonField(
                                                                              cuotasLitItem,
                                                                              r'''$.variation_id''',
                                                                            )
                                                                        ? FFTheme.of(context)
                                                                            .secondaryBackground
                                                                        : FFTheme.of(context)
                                                                            .primary,
                                                                    fontSize:
                                                                        12.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                        ),
                                                        Text(
                                                          '${getJsonField(
                                                            cuotasLitItem,
                                                            r'''$.display_price''',
                                                          ).toString()} €',
                                                          style:
                                                              FFTheme.of(
                                                                      context)
                                                                  .displayMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Montserrat',
                                                                    color: _model
                                                                                .suscription ==
                                                                            getJsonField(
                                                                              cuotasLitItem,
                                                                              r'''$.variation_id''',
                                                                            )
                                                                        ? FFTheme.of(context)
                                                                            .secondaryBackground
                                                                        : FFTheme.of(context)
                                                                            .primaryText,
                                                                    fontSize:
                                                                        24.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800,
                                                                  ),
                                                        ),
                                                        Text(
                                                          'Sorteos/mes: ${getJsonField(
                                                            memberPageDetailGetSingleProductResponse
                                                                .jsonBody,
                                                            r'''$.meta_data[0].value''',
                                                          ).toString()}',
                                                          style:
                                                              FFTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Montserrat',
                                                                    color: _model
                                                                                .suscription ==
                                                                            getJsonField(
                                                                              cuotasLitItem,
                                                                              r'''$.variation_id''',
                                                                            )
                                                                        ? FFTheme.of(context)
                                                                            .secondaryBackground
                                                                        : FFTheme.of(context)
                                                                            .primary,
                                                                    fontSize:
                                                                        10.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                        ),
                                                        Text(
                                                          'Papeletas:${functions.filterPapeletas(getJsonField(
                                                                memberPageDetailGetSingleProductResponse
                                                                    .jsonBody,
                                                                r'''$.meta_data''',
                                                              ), cuotasLitIndex + 1)}',
                                                          style:
                                                              FFTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Montserrat',
                                                                    color: _model
                                                                                .suscription ==
                                                                            getJsonField(
                                                                              cuotasLitItem,
                                                                              r'''$.variation_id''',
                                                                            )
                                                                        ? FFTheme.of(context)
                                                                            .secondaryBackground
                                                                        : FFTheme.of(context)
                                                                            .primary,
                                                                    fontSize:
                                                                        10.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 100.0,
                              height: 130.0,
                              decoration: BoxDecoration(
                                color: FFTheme.of(context).secondaryBackground,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(1.00, 1.00),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4.0,
                            color: Color(0x33000000),
                            offset: Offset(1.0, 2.0),
                            spreadRadius: 3.0,
                          )
                        ],
                      ),
                      child: Align(
                        alignment: AlignmentDirectional(0.00, 0.00),
                        child: FFButtonWidget(
                          onPressed: () async {
                            _model.apiResultywtCopy = await AddToCartCall.call(
                              productId: widget.idMembresy,
                              userId: getJsonField(
                                FFAppState().jwtuser,
                                r'''$.ID''',
                              ),
                              variationId: _model.suscription,
                            );

                            context.pushNamed(
                              'webViewPage',
                              queryParameters: {
                                'route': serializeParam(
                                  'subscription',
                                  ParamType.String,
                                ),
                              }.withoutNulls,
                            );

                            setState(() {});
                          },
                          text: 'SUSCRIBIRME',
                          options: FFButtonOptions(
                            width: MediaQuery.sizeOf(context).width * 0.8,
                            height: 50.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                24.0, 0.0, 24.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FFTheme.of(context).primary,
                            textStyle: FFTheme.of(context).titleSmall.override(
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                  fontSize: 20.0,
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
                  Container(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: 100.0,
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
                                          memberPageDetailGetSingleProductResponse
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
                                          memberPageDetailGetSingleProductResponse
                                              .jsonBody,
                                          r'''$.name''',
                                        ).toString(),
                                        seller: getJsonField(
                                          memberPageDetailGetSingleProductResponse
                                              .jsonBody,
                                          r'''$.author.name''',
                                        ).toString(),
                                        image: getJsonField(
                                          memberPageDetailGetSingleProductResponse
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
                                    _model.chatResponseMembership =
                                        ChatsRecord.getDocumentFromData({
                                      ...createChatsRecordData(
                                        product: getJsonField(
                                          memberPageDetailGetSingleProductResponse
                                              .jsonBody,
                                          r'''$.name''',
                                        ).toString(),
                                        seller: getJsonField(
                                          memberPageDetailGetSingleProductResponse
                                              .jsonBody,
                                          r'''$.author.name''',
                                        ).toString(),
                                        image: getJsonField(
                                          memberPageDetailGetSingleProductResponse
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
                                          _model.chatResponseMembership
                                              ?.reference,
                                          ParamType.DocumentReference,
                                        ),
                                        'chat': serializeParam(
                                          _model.chatResponseMembership,
                                          ParamType.Document,
                                        ),
                                      }.withoutNulls,
                                      extra: <String, dynamic>{
                                        'chat': _model.chatResponseMembership,
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
                                      .contains(widget.idMembresy!) ==
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
                                            .addToFavorites(widget.idMembresy!);
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
                                  .contains(widget.idMembresy!))
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
                                            widget.idMembresy!);
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
