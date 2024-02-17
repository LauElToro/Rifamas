import 'package:jwt_decoder/jwt_decoder.dart';

import '/backend/api_requests/api_calls.dart';
import '/components/header_component_widget.dart';
import '/components/product_card_widget_widget.dart';
import '/ff/ff_theme.dart';
import '/ff/ff_util.dart';
import '/ff/ff_widgets.dart';
import '/pages/bottomnavigations/bottom_navigation_home_component/bottom_navigation_home_component_widget.dart';
import '/ff/random_data_util.dart' as random_data;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'my_product_list_all_page_model.dart';
export 'my_product_list_all_page_model.dart';

// Map<String, dynamic> decodedToken = {};

class MyProductListAllPageWidget extends StatefulWidget {
  const MyProductListAllPageWidget({Key? key}) : super(key: key);

  @override
  _MyProductListAllPageWidgetState createState() =>
      _MyProductListAllPageWidgetState();
}

class _MyProductListAllPageWidgetState
    extends State<MyProductListAllPageWidget> {
  late MyProductListAllPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MyProductListAllPageModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final decodedToken = JwtDecoder.decode(FFAppState().jwtuser['token']);
    print(decodedToken);
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
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 80.0, 0.0, 0.0),
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 1.0,
                  height: MediaQuery.sizeOf(context).height * 1.0,
                  decoration: BoxDecoration(
                    color: FFTheme.of(context).secondaryBackground,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: MediaQuery.sizeOf(context).width * 0.45,
                              height: 50.0,
                              decoration: BoxDecoration(
                                color: FFTheme.of(context).primary,
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Align(
                                alignment: AlignmentDirectional(0.00, 0.00),
                                child: Text(
                                  'Rifas',
                                  style:
                                      FFTheme.of(context).titleMedium.override(
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.bold,
                                          ),
                                ),
                              ),
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                context.pushNamed('memberListPage');
                              },
                              child: Container(
                                width: MediaQuery.sizeOf(context).width * 0.45,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  color:
                                      FFTheme.of(context).secondaryBackground,
                                  borderRadius: BorderRadius.circular(15.0),
                                  border: Border.all(
                                    color: FFTheme.of(context).primary,
                                    width: 3.0,
                                  ),
                                ),
                                child: Align(
                                  alignment: AlignmentDirectional(0.00, 0.00),
                                  child: Text(
                                    'Membresias',
                                    style: FFTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Montserrat',
                                          color: FFTheme.of(context).primary,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          height: 350.0,
                          decoration: BoxDecoration(
                            color: FFTheme.of(context).accent4,
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                10.0, 10.0, 10.0, 10.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 15.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'CREADAS ACTIVAS',
                                        style: FFTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Montserrat',
                                              color:
                                                  FFTheme.of(context).primary,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                FutureBuilder<ApiCallResponse>(
                                  future: GetProductsCall.call(
                                    // perPage: 2,
                                    // author: getJsonField(
                                    //   FFAppState().jwtuser,
                                    //   r'''$.id''',
                                    // ),
                                    author: int.parse(
                                      getJsonField(
                                        decodedToken['data']['user'],
                                        r'''$.id''',
                                      ),
                                    ),
                                    type: 'lottery',
                                  ),
                                  builder: (context, snapshot) {
                                    // Customize what y looks like when it's loading.
                                    if (!snapshot.hasData) {
                                      return Center(
                                        child: SizedBox(
                                          width: 50.0,
                                          height: 50.0,
                                          child: CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              FFTheme.of(context).primary,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    final rowGetProductsResponse =
                                        snapshot.data!;
                                    return Builder(builder: (context) {
                                      final productx = getJsonField(
                                        rowGetProductsResponse.jsonBody,
                                        r'''$''',
                                      ).toList();
                                      return SizedBox(
                                        width: double.infinity,
                                        height: 270,
                                        child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: (getJsonField(
                                                    rowGetProductsResponse
                                                        .jsonBody,
                                                    r'''$'''))
                                                .length,
                                            itemBuilder:
                                                (context, productxIndex) {
                                              final productxItem =
                                                  productx[productxIndex];
                                              return Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 15.0, 0.0),
                                                child: Container(
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.45,
                                                    height: 270.0,
                                                    decoration: BoxDecoration(
                                                      color: FFTheme.of(context)
                                                          .secondaryBackground,
                                                    ),
                                                    child: InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        context.pushNamed(
                                                          'ProductDetail',
                                                          queryParameters: {
                                                            'idProduct':
                                                                serializeParam(
                                                              getJsonField(
                                                                productxItem,
                                                                r'''$.id''',
                                                              ),
                                                              ParamType.int,
                                                            ),
                                                          }.withoutNulls,
                                                        );
                                                      },
                                                      child:
                                                          ProductCardWidgetWidget(
                                                        key: Key(
                                                            'Keyohj_${productxIndex}_of_${productx.length}'),
                                                        color: FFTheme.of(
                                                                context)
                                                            .secondaryBackground,
                                                        title: getJsonField(
                                                          productxItem,
                                                          r'''$.name''',
                                                        ).toString(),
                                                        price: getJsonField(
                                                          productxItem,
                                                          r'''$.price''',
                                                        ).toString(),
                                                        image: valueOrDefault<
                                                            String>(
                                                          getJsonField(
                                                            productxItem,
                                                            r'''$.images[0].src''',
                                                          ),
                                                          'http://',
                                                        ),
                                                        participants:
                                                            getJsonField(
                                                          productxItem,
                                                          r'''$.participants''',
                                                        ),
                                                        metadata: getJsonField(
                                                          productxItem,
                                                          r'''$.meta_data''',
                                                        ),
                                                        percentbar:
                                                            getJsonField(
                                                                  productxItem,
                                                                  r'''$.porcent_products''',
                                                                ).toDouble() /
                                                                100,
                                                        type: getJsonField(
                                                          productxItem,
                                                          r'''$.type''',
                                                        ).toString(),
                                                      ),
                                                    )),
                                              );
                                            }),
                                      );
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          height: 450.0,
                          decoration: BoxDecoration(
                            color: Color(0xFFEDEDED),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                10.0, 10.0, 10.0, 10.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 15.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'PARTICIPADAS ACTIVAS',
                                        style: FFTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Montserrat',
                                              color:
                                                  FFTheme.of(context).primary,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ],
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
              Align(
                alignment: AlignmentDirectional(0.00, 1.00),
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 1.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    color: Color(0x00FFFFFF),
                  ),
                  child: wrapWithModel(
                    model: _model.bottomNavigationHomeComponentModel,
                    updateCallback: () => setState(() {}),
                    child: BottomNavigationHomeComponentWidget(
                      page: 'rifas',
                    ),
                  ),
                ),
              ),
              wrapWithModel(
                model: _model.headerComponentModel,
                updateCallback: () => setState(() {}),
                child: HeaderComponentWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
