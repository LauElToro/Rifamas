import '/backend/api_requests/api_calls.dart';
import '/components/header_component_widget.dart';
import '/components/membership_component_widget_widget.dart';
import '/ff/ff_theme.dart';
import '/ff/ff_util.dart';
import '/ff/ff_widgets.dart';
import '/pages/bottomnavigations/bottom_navigation_home_component/bottom_navigation_home_component_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'member_list_page_model.dart';
export 'member_list_page_model.dart';

class MemberListPageWidget extends StatefulWidget {
  const MemberListPageWidget({Key? key}) : super(key: key);

  @override
  _MemberListPageWidgetState createState() => _MemberListPageWidgetState();
}

class _MemberListPageWidgetState extends State<MemberListPageWidget> {
  late MemberListPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MemberListPageModel());

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
        body: Align(
          alignment: AlignmentDirectional(0.00, 1.00),
          child: Stack(
            alignment: AlignmentDirectional(0.0, 1.0),
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width * 1.0,
                height: MediaQuery.sizeOf(context).height * 1.0 - 25,
                decoration: BoxDecoration(
                  color: FFTheme.of(context).secondaryBackground,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      wrapWithModel(
                        model: _model.headerComponentModel,
                        updateCallback: () => setState(() {}),
                        child: HeaderComponentWidget(),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context.pushNamed('myProductListAllPage');
                            },
                            child: Container(
                              width: MediaQuery.sizeOf(context).width * 0.45,
                              height: 50.0,
                              decoration: BoxDecoration(
                                color: FFTheme.of(context).accent4,
                                borderRadius: BorderRadius.circular(15.0),
                                border: Border.all(
                                  color: FFTheme.of(context).primary,
                                  width: 2.0,
                                ),
                              ),
                              child: Align(
                                alignment: AlignmentDirectional(0.00, 0.00),
                                child: Text(
                                  'Rifas',
                                  style:
                                      FFTheme.of(context).titleMedium.override(
                                            fontFamily: 'Montserrat',
                                            color: FFTheme.of(context).primary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.sizeOf(context).width * 0.45,
                            height: 50.0,
                            decoration: BoxDecoration(
                              color: FFTheme.of(context).primary,
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
                                style: FFTheme.of(context).bodyMedium.override(
                                      fontFamily: 'Montserrat',
                                      color: FFTheme.of(context)
                                          .secondaryBackground,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
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
                                      'CREADAS VIGENTES',
                                      style: FFTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Montserrat',
                                            color: FFTheme.of(context).primary,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              FutureBuilder<ApiCallResponse>(
                                future: GetSubscriptionsCall.call(
                                    author: getJsonField(
                                            FFAppState().jwtuser, r'''$.ID''')
                                        .toString()),
                                builder: (context, snapshot) {
                                  // Customize what your widget looks like when it's loading.
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
                                  final columnGetSubscriptionsResponse =
                                      snapshot.data!;
                                  return Builder(
                                    builder: (context) {
                                      final subscriptions = getJsonField(
                                        columnGetSubscriptionsResponse.jsonBody,
                                        r'''$''',
                                      ).toList().take(2).toList();
                                      return Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children:
                                            List.generate(subscriptions.length,
                                                (subscriptionsIndex) {
                                          final subscriptionsItem =
                                              subscriptions[subscriptionsIndex];
                                          return MembershipComponentWidgetWidget(
                                            key: Key(
                                                'Keydnm_${subscriptionsIndex}_of_${subscriptions.length}'),
                                            price: getJsonField(
                                              subscriptionsItem,
                                              r'''$.prices''',
                                            ).toString(),
                                            cantSorteos: getJsonField(
                                              subscriptionsItem,
                                              r'''$.sorteos''',
                                            ).toString(),
                                            title: getJsonField(
                                              subscriptionsItem,
                                              r'''$.name''',
                                            ).toString(),
                                            image: getJsonField(
                                              subscriptionsItem,
                                              r'''$.image''',
                                            ),
                                            idMembership: getJsonField(
                                              subscriptionsItem,
                                              r'''$.id''',
                                            ),
                                          );
                                        }),
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.sizeOf(context).width * 1.0,
                        height: 350.0,
                        decoration: BoxDecoration(
                          color: Color(0xFFEDEDED),
                          border: Border.all(
                            color: FFTheme.of(context).alternate,
                          ),
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
                                      'SUSCRITAS',
                                      style: FFTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Montserrat',
                                            color: FFTheme.of(context).primary,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              FutureBuilder<ApiCallResponse>(
                                future: GetSubscriptionsCall.call(
                                    author: getJsonField(
                                            FFAppState().jwtuser, r'''$.ID''')
                                        .toString()),
                                builder: (context, snapshot) {
                                  // Customize what your widget looks like when it's loading.
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
                                  final columnGetSubscriptionsResponse =
                                      snapshot.data!;
                                  print(columnGetSubscriptionsResponse.jsonBody);
                                  return Builder(
                                    builder: (context) {
                                      final subscriptions = getJsonField(
                                        columnGetSubscriptionsResponse.jsonBody,
                                        r'''$''',
                                      ).toList().take(2).toList();
                                      return Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children:
                                            List.generate(subscriptions.length,
                                                (subscriptionsIndex) {
                                          final subscriptionsItem =
                                              subscriptions[subscriptionsIndex];
                                          return MembershipComponentWidgetWidget(
                                            key: Key(
                                                'Keydnm_${subscriptionsIndex}_of_${subscriptions.length}'),
                                            price: getJsonField(
                                              subscriptionsItem,
                                              r'''$.prices''',
                                            ).toString(),
                                            cantSorteos: getJsonField(
                                              subscriptionsItem,
                                              r'''$.sorteos''',
                                            ).toString(),
                                            title: getJsonField(
                                              subscriptionsItem,
                                              r'''$.name''',
                                            ).toString(),
                                            image: getJsonField(
                                              subscriptionsItem,
                                              r'''$.image''',
                                            ),
                                            idMembership: getJsonField(
                                              subscriptionsItem,
                                              r'''$.id''',
                                            ),
                                          );
                                        }),
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
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
            ],
          ),
        ),
      ),
    );
  }
}
