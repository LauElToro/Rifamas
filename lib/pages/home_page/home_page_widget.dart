import 'dart:math';

import '/backend/api_requests/api_calls.dart';
import '/components/header_component_widget.dart';
import '/components/product_card_widget_widget.dart';
import '/ff/ff_theme.dart';
import '/ff/ff_util.dart';
import '/ff/ff_widgets.dart';
import '/loaders/categories_loadiing_list_widget/categories_loadiing_list_widget_widget.dart';
import '/loaders/membership_loading_list_widget/membership_loading_list_widget_widget.dart';
import '/loaders/products_loading_list_widget/products_loading_list_widget_widget.dart';
import '/pages/bottomnavigations/bottom_navigation_home_component/bottom_navigation_home_component_widget.dart';
import '/ff/custom_functions.dart' as functions;
import '/ff/random_data_util.dart' as random_data;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'home_page_model.dart';
export 'home_page_model.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.apiResultln1 = await WalletGroup.getBalanceCall.call(
        idUser: getJsonField(
          FFAppState().jwtuser,
          r'''$.ID''',
        ).toString().toString(),
      );
      if ((_model.apiResultln1?.succeeded ?? true)) {
        setState(() {
          FFAppState().currentBalance = valueOrDefault<String>(
            (_model.apiResultln1?.jsonBody ?? '').toString(),
            '\$',
          );
        });
      }
    });

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
        backgroundColor: FFTheme.of(context).secondaryBackground,
        body: SafeArea(
          top: true,
          child: Stack(
            alignment: AlignmentDirectional(0.0, 1.0),
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10.0, 80.0, 10.0, 70.0),
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 1.0,
                  height: MediaQuery.sizeOf(context).height * 1.0,
                  decoration: BoxDecoration(),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 15.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Membresias de sorteos',
                                  style:
                                      FFTheme.of(context).titleMedium.override(
                                            fontFamily: 'Montserrat',
                                            color: FFTheme.of(context).primary,
                                            fontWeight: FontWeight.w600,
                                          ),
                                ),
                                InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    context.pushNamed('membershipListPage');
                                  },
                                  child: Text(
                                    'Ver Todo >',
                                    style:
                                        FFTheme.of(context).bodyMedium.override(
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.bold,
                                            ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (_model.loading == false)

                            //! MEMBERSHIP API CALL
                            FutureBuilder<ApiCallResponse>(
                              future: FFAppState().membershipCache(
                                requestFn: () => GetSubscriptionsCall.call(),
                              ),
                              builder: (context, snapshot) {
                                // Customize what your widget looks like when it's loading.
                                if (!snapshot.hasData) {
                                  return MembershipLoadingListWidgetWidget();
                                }
                                final rowGetSubscriptionsResponse =
                                    snapshot.data!;
                                return Builder(
                                  builder: (context) {
                                    final subscriptions = getJsonField(
                                      rowGetSubscriptionsResponse.jsonBody,
                                      r'''$''',
                                    ).toList();
                                    return SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children:
                                            List.generate(subscriptions.length,
                                                (subscriptionsIndex) {
                                          final subscriptionsItem =
                                              subscriptions[subscriptionsIndex];
                                          return Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.27,
                                                height:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.27,
                                                decoration: BoxDecoration(
                                                  color: FFTheme.of(context)
                                                      .secondaryBackground,
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color: FFTheme.of(context)
                                                        .primary,
                                                    width: 3.0,
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          3.0, 3.0, 3.0, 3.0),
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
                                                        'memberPageDetail',
                                                        queryParameters: {
                                                          'idMembresy':
                                                              serializeParam(
                                                            getJsonField(
                                                              subscriptionsItem,
                                                              r'''$.id''',
                                                            ),
                                                            ParamType.int,
                                                          ),
                                                        }.withoutNulls,
                                                      );
                                                    },
                                                    child: Container(
                                                      width: 20.0,
                                                      height: 20.0,
                                                      clipBehavior:
                                                          Clip.antiAlias,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Image.network(
                                                        getJsonField(
                                                          subscriptionsItem,
                                                          r'''$.image''',
                                                        ),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),

                                              //! MemberShip Names
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 10.0, 0.0, 0.0),
                                                child: Text(
                                                  getJsonField(
                                                            subscriptionsItem,
                                                            r'''$.name''',
                                                          ).toString().length <
                                                          15
                                                      ? getJsonField(
                                                          subscriptionsItem,
                                                          r'''$.name''',
                                                        ).toString().substring(
                                                          0,
                                                          min(
                                                              getJsonField(
                                                                subscriptionsItem,
                                                                r'''$.name''',
                                                              )
                                                                  .toString()
                                                                  .length,
                                                              13))
                                                      : getJsonField(
                                                            subscriptionsItem,
                                                            r'''$.name''',
                                                          ).toString().substring(
                                                              0,
                                                              min(
                                                                  getJsonField(
                                                                    subscriptionsItem,
                                                                    r'''$.name''',
                                                                  ).toString().length,
                                                                  13)) +
                                                          "...",
                                                  style: FFTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Montserrat',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          );
                                        }).divide(SizedBox(width: 5.0)),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0.0, 15.0, 0.0, 15.0),
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          decoration: BoxDecoration(
                            color: Color(0x00FFFFFF),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 15.0, 0.0, 0.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 15.0),
                                  child: Text(
                                    'Lo mas VIP para ti',
                                    style: FFTheme.of(context)
                                        .titleMedium
                                        .override(
                                          fontFamily: 'Montserrat',
                                          color: FFTheme.of(context).primary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ),

                                //! CATEGORIES ROW WIDGET
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    if (_model.loading == false)
                                      Expanded(
                                        //! CATEGORIES API CALL
                                        child: FutureBuilder<ApiCallResponse>(
                                          future: FFAppState().categoriesCache(
                                            requestFn: () =>
                                                CategoriesCall.call(),
                                          ),
                                          builder: (context, snapshot) {
                                            // Customize what your widget looks like when it's loading.
                                            if (!snapshot.hasData) {
                                              return CategoriesLoadiingListWidgetWidget();
                                            }
                                            final rowCategoriesResponse =
                                                snapshot.data!;
                                            return Builder(
                                              builder: (context) {
                                                final categories = getJsonField(
                                                  rowCategoriesResponse
                                                      .jsonBody,
                                                  r'''$''',
                                                ).toList();
                                                return SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: List.generate(
                                                        categories.length,
                                                        (categoriesIndex) {
                                                      final categoriesItem =
                                                          categories[
                                                              categoriesIndex];
                                                      return FFButtonWidget(
                                                        onPressed:
                                                            _model.setCategory ==
                                                                    true
                                                                ? null
                                                                : () async {
                                                                    setState(
                                                                        () {
                                                                      _model.categorySelected =
                                                                          getJsonField(
                                                                        categoriesItem,
                                                                        r'''$.id''',
                                                                      );
                                                                    });
                                                                    setState(
                                                                        () {
                                                                      _model.setCategory =
                                                                          true;
                                                                    });
                                                                    await Future.delayed(const Duration(
                                                                        milliseconds:
                                                                            1000));
                                                                    _model.apiResulthk =
                                                                        await GetHomeProductsCall
                                                                            .call(
                                                                      perPage:
                                                                          20,
                                                                      category: _model
                                                                          .categorySelected
                                                                          ?.toString(),
                                                                      page: 1,
                                                                    );
                                                                    setState(
                                                                        () {
                                                                      _model
                                                                          .productss = (_model.apiResulthk?.jsonBody ??
                                                                              '')
                                                                          .toList()
                                                                          .cast<
                                                                              dynamic>();
                                                                    });
                                                                    setState(
                                                                        () {
                                                                      _model.setCategory =
                                                                          false;
                                                                    });

                                                                    setState(
                                                                        () {});
                                                                  },
                                                        text: getJsonField(
                                                          categoriesItem,
                                                          r'''$.name''',
                                                        ).toString(),
                                                        options:
                                                            FFButtonOptions(
                                                          height: 48.0,
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      24.0,
                                                                      0.0,
                                                                      24.0,
                                                                      0.0),
                                                          iconPadding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          color: _model
                                                                      .categorySelected ==
                                                                  getJsonField(
                                                                    categoriesItem,
                                                                    r'''$.id''',
                                                                  )
                                                              ? FFTheme.of(
                                                                      context)
                                                                  .primary
                                                              : FFTheme.of(
                                                                      context)
                                                                  .secondaryBackground,
                                                          textStyle:
                                                              FFTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .override(
                                                                    fontFamily:
                                                                        'Montserrat',
                                                                    color: _model
                                                                                .categorySelected ==
                                                                            getJsonField(
                                                                              categoriesItem,
                                                                              r'''$.id''',
                                                                            )
                                                                        ? FFTheme.of(context)
                                                                            .secondaryBackground
                                                                        : FFTheme.of(context)
                                                                            .primaryText,
                                                                    fontSize:
                                                                        13.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                          elevation: 0.0,
                                                          borderSide:
                                                              BorderSide(
                                                            color: FFTheme.of(
                                                                    context)
                                                                .primary,
                                                            width: 2.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      40.0),
                                                        ),
                                                      );
                                                    }).divide(
                                                        SizedBox(width: 4.0)),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      if (_model.loading == false)
                        Align(
                          alignment: AlignmentDirectional(0.00, 0.00),
                          child: RefreshIndicator(
                            onRefresh: () async {
                              setState(() {
                                _model.productsPage = _model.productsPage! + 1;
                              });
                              await Future.delayed(
                                  const Duration(milliseconds: 1000));
                              _model.productsResponseCopy =
                                  await GetProductsCall.call(
                                perPage: 10,
                                page: _model.productsPage,
                                type: 'lottery',
                              );
                              setState(() {
                                _model.addToProductss(
                                    (_model.productsResponseCopy?.jsonBody ??
                                        ''));
                              });
                              setState(() =>
                                  _model.gridViewPagingController?.refresh());
                              await _model.waitForOnePageForGridView();
                            },

                            //! PRODUCTS API CALL
                            child: PagedGridView<ApiPagingParams, dynamic>(
                              pagingController: (_model.setGridViewController(
                                (nextPageMarker) => GetProductsCall.call(
                                  page: nextPageMarker.nextPageNumber + 1,
                                  type: 'lottery',
                                ),
                              )),
                              padding: EdgeInsets.zero,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 20.0,
                                mainAxisSpacing: 20.0,
                                childAspectRatio: 0.6,
                              ),
                              primary: false,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              builderDelegate:
                                  PagedChildBuilderDelegate<dynamic>(
                                // Customize what your widget looks like when it's loading the first page.
                                firstPageProgressIndicatorBuilder: (_) =>
                                    ProductsLoadingListWidgetWidget(),
                                // Customize what your widget looks like when it's loading another page.
                                newPageProgressIndicatorBuilder: (_) =>
                                    ProductsLoadingListWidgetWidget(),

                                itemBuilder: (context, _, productsIndex) {
                                  final productsItem = _model
                                      .gridViewPagingController!
                                      .itemList![productsIndex];

                                  // final productsItem =
                                  //     filteredItems[productsIndex];
                                  return InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      context.pushNamed(
                                        'ProductDetail',
                                        queryParameters: {
                                          'idProduct': serializeParam(
                                            getJsonField(
                                              productsItem,
                                              r'''$.id''',
                                            ),
                                            ParamType.int,
                                          ),
                                        }.withoutNulls,
                                      );
                                    },
                                    child: wrapWithModel(
                                      model: _model.productCardWidgetModels
                                          .getModel(
                                        productsIndex.toString(),
                                        productsIndex,
                                      ),
                                      updateCallback: () => setState(() {}),
                                      child: ProductCardWidgetWidget(
                                        showStatus: true,
                                        key: Key(
                                          'Keyg11_${productsIndex.toString()}',
                                        ),
                                        color: FFTheme.of(context)
                                            .secondaryBackground,
                                        title: getJsonField(
                                          productsItem,
                                          r'''$.name''',
                                        ).toString(),
                                        // title: productsIndex.toString(),
                                        price: getJsonField(
                                                  productsItem,
                                                  r'''$.price''',
                                                ).toString() ==
                                                ""
                                            ? "0.00"
                                            : getJsonField(
                                                productsItem,
                                                r'''$.price''',
                                              ).toString(),
                                        image: valueOrDefault<String>(
                                          getJsonField(
                                            productsItem,
                                            r'''$.images[0].src''',
                                          ),
                                          'http://',
                                        ),
                                        participants: getJsonField(
                                          productsItem,
                                          r'''$.participants''',
                                        ),
                                        metadata: getJsonField(
                                          productsItem,
                                          r'''$.meta_data''',
                                        ),
                                        percentbar: getJsonField(
                                              productsItem,
                                              r'''$.porcent_products''',
                                            ) /
                                            100,
                                        // type:
                                        //     functions.productType(getJsonField(
                                        //   productsItem,
                                        //   r'''$.meta_data''',
                                        //   true,
                                        // )),
                                        type: getJsonField(
                                            productsItem, r'''$.type'''),
                                        // status: functions.loteryDatesTo(
                                        //     getJsonField(productsItem,
                                        //         r'''$.meta_data''')),

                                        status: getJsonField(
                                            productsItem, r'''$.status'''),
                                        // maxTickets: functions.maxParticipants(
                                        //     getJsonField(productsItem,
                                        //         r'''$.meta_data''')),
                                        maxTickets: getJsonField(productsItem,
                                                r'''$.total_products''')
                                            .toString(),
                                        regularPrice: getJsonField(
                                          productsItem,
                                          r'''$.regular_price''',
                                        ).toString(),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.00, 1.00),
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 1.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                  ),
                  child: wrapWithModel(
                    model: _model.bottomNavigationHomeComponentModel,
                    updateCallback: () => setState(() {}),
                    child: BottomNavigationHomeComponentWidget(
                      page: 'home',
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.00, -1.00),
                child: wrapWithModel(
                  model: _model.headerComponentModel,
                  updateCallback: () => setState(() {}),
                  child: HeaderComponentWidget(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
