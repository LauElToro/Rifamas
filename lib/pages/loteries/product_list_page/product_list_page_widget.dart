import '/backend/api_requests/api_calls.dart';
import '/components/product_card_widget_widget.dart';
import '/components/secondaary_header_component_widget.dart';
import '/ff/ff_theme.dart';
import '/ff/ff_util.dart';
import '/ff/ff_widgets.dart';
import 'dart:async';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'product_list_page_model.dart';
export 'product_list_page_model.dart';

class ProductListPageWidget extends StatefulWidget {
  const ProductListPageWidget({Key? key}) : super(key: key);

  @override
  _ProductListPageWidgetState createState() => _ProductListPageWidgetState();
}

class _ProductListPageWidgetState extends State<ProductListPageWidget> {
  late ProductListPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProductListPageModel());

    _model.textController ??= TextEditingController(text: FFAppState().search);
    _model.textFieldFocusNode ??= FocusNode();
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
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              wrapWithModel(
                model: _model.secondaaryHeaderComponentModel,
                updateCallback: () => setState(() {}),
                child: SecondaaryHeaderComponentWidget(),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 0.0),
                child: Material(
                  color: Colors.transparent,
                  elevation: 3.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 60.0,
                    decoration: BoxDecoration(
                      color: FFTheme.of(context).secondaryBackground,
                      borderRadius: BorderRadius.circular(40.0),
                      border: Border.all(
                        color: FFTheme.of(context).alternate,
                      ),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 12.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  4.0, 0.0, 0.0, 0.0),
                              child: TextFormField(
                                controller: _model.textController,
                                focusNode: _model.textFieldFocusNode,
                                onChanged: (_) => EasyDebounce.debounce(
                                  '_model.textController',
                                  Duration(milliseconds: 2000),
                                  () async {
                                    setState(() {
                                      FFAppState().search =
                                          _model.textController.text;
                                    });
                                  },
                                ),
                                onFieldSubmitted: (_) async {
                                  setState(() => _model.listViewPagingController
                                      ?.refresh());
                                  await _model.waitForOnePageForListView();
                                },
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'Buscar rifas...',
                                  hintStyle: FFTheme.of(context).bodyLarge,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  focusedErrorBorder: InputBorder.none,
                                ),
                                style: FFTheme.of(context).bodyMedium,
                                validator: _model.textControllerValidator
                                    .asValidator(context),
                              ),
                            ),
                          ),
                          Icon(
                            Icons.search_rounded,
                            color: FFTheme.of(context).secondaryText,
                            size: 24.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 0.0, 4.0),
                child: Text(
                  'Listado de Rifas',
                  style: FFTheme.of(context).labelMedium,
                ),
              ),
              Container(
                width: MediaQuery.sizeOf(context).width * 1.0,
                height: MediaQuery.sizeOf(context).height * 1.0,
                decoration: BoxDecoration(
                  color: FFTheme.of(context).secondaryBackground,
                ),
                child: Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 44.0),
                  child: PagedListView<ApiPagingParams, dynamic>(
                    pagingController: _model.setListViewController(
                      (nextPageMarker) => GetProductsCall.call(
                        search: FFAppState().search,
                        page: valueOrDefault<int>(
                          valueOrDefault<int>(
                                nextPageMarker.nextPageNumber,
                                0,
                              ) +
                              1,
                          1,
                        ),
                        perPage: 12,
                      ),
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
                            .listViewPagingController!.itemList![productsIndex];
                        return Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 15.0),
                          child: wrapWithModel(
                            model: _model.productCardWidgetModels.getModel(
                              productsIndex.toString(),
                              productsIndex,
                            ),
                            updateCallback: () => setState(() {}),
                            child: ProductCardWidgetWidget(
                              key: Key(
                                'Keyala_${productsIndex.toString()}',
                              ),
                              title: getJsonField(
                                productsItem,
                                r'''$.name''',
                              ).toString(),
                              price: getJsonField(
                                productsItem,
                                r'''$.price''',
                              ).toString().replaceAll(".", ","),
                              image: getJsonField(
                                productsItem,
                                r'''$.images[0].src''',
                              ),
                              participants: getJsonField(
                                productsItem,
                                r'''$.participants''',
                              ),
                              metadata: getJsonField(
                                productsItem,
                                r'''$.meta_data''',
                              ),
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
    );
  }
}
