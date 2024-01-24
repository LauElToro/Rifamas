import '/backend/api_requests/api_calls.dart';
import '/components/membership_component_widget_widget.dart';
import '/components/secondaary_header_component_widget.dart';
import '/ff/ff_theme.dart';
import '/ff/ff_util.dart';
import '/ff/ff_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'membership_list_page_model.dart';
export 'membership_list_page_model.dart';

class MembershipListPageWidget extends StatefulWidget {
  const MembershipListPageWidget({Key? key}) : super(key: key);

  @override
  _MembershipListPageWidgetState createState() =>
      _MembershipListPageWidgetState();
}

class _MembershipListPageWidgetState extends State<MembershipListPageWidget> {
  late MembershipListPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MembershipListPageModel());

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
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 80.0, 0.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                    child: Text(
                      'Membresias de sorteos',
                      style: FFTheme.of(context).titleMedium.override(
                            fontFamily: 'Montserrat',
                            color: FFTheme.of(context).primary,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: MediaQuery.sizeOf(context).height * 0.8,
                    decoration: BoxDecoration(
                      color: FFTheme.of(context).secondaryBackground,
                    ),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                      child: PagedListView<ApiPagingParams, dynamic>(
                        pagingController: _model.setListViewController(
                          (nextPageMarker) => GetSubscriptionsCall.call(),
                        ),
                        padding: EdgeInsets.zero,
                        reverse: false,
                        scrollDirection: Axis.vertical,
                        builderDelegate: PagedChildBuilderDelegate<dynamic>(
                          // Customize what your widget looks like when it's loading the first page.
                          firstPageProgressIndicatorBuilder: (_) => Center(
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
                          // Customize what your widget looks like when it's loading another page.
                          newPageProgressIndicatorBuilder: (_) => Center(
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

                          itemBuilder: (context, _, productsIndex) {
                            final productsItem = _model
                                .listViewPagingController!
                                .itemList![productsIndex];
                            return MembershipComponentWidgetWidget(
                              key: Key(
                                  'Keyfsg_${productsIndex}_of_${_model.listViewPagingController!.itemList!.length}'),
                              price: getJsonField(
                                productsItem,
                                r'''$.prices''',
                              ).toString(),
                              cantSorteos: getJsonField(
                                productsItem,
                                r'''$.sorteos''',
                              ).toString(),
                              title: getJsonField(
                                productsItem,
                                r'''$.name''',
                              ).toString(),
                              image: getJsonField(
                                productsItem,
                                r'''$.image''',
                              ),
                              idMembership: getJsonField(
                                productsItem,
                                r'''$.id''',
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
            wrapWithModel(
              model: _model.secondaaryHeaderComponentModel,
              updateCallback: () => setState(() {}),
              child: SecondaaryHeaderComponentWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
