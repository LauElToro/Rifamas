import '/backend/api_requests/api_calls.dart';
import '/components/product_card_widget_widget.dart';
import '/components/secondaary_header_component_widget.dart';
import '/ff/ff_theme.dart';
import '/ff/ff_util.dart';
import '/ff/ff_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'my_lotteries_list_page_model.dart';
export 'my_lotteries_list_page_model.dart';

class MyLotteriesListPageWidget extends StatefulWidget {
  const MyLotteriesListPageWidget({Key? key}) : super(key: key);

  @override
  _MyLotteriesListPageWidgetState createState() =>
      _MyLotteriesListPageWidgetState();
}

class _MyLotteriesListPageWidgetState extends State<MyLotteriesListPageWidget> {
  late MyLotteriesListPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MyLotteriesListPageModel());

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
            children: [
              wrapWithModel(
                model: _model.secondaaryHeaderComponentModel,
                updateCallback: () => setState(() {}),
                child: SecondaaryHeaderComponentWidget(
                  title: 'Mis rifas',
                ),
              ),
              Expanded(
                child: FutureBuilder<ApiCallResponse>(
                  future: GetProductsCall.call(
                    author: getJsonField(
                      FFAppState().jwtuser,
                      r'''$.ID''',
                    ),
                    type: 'lottery',
                    perPage: 40,
                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              FFTheme.of(context).primary,
                            ),
                          ),
                        ),
                      );
                    }
                    final gridViewGetProductsResponse = snapshot.data!;
                    return Builder(
                      builder: (context) {
                        final products = getJsonField(
                          gridViewGetProductsResponse.jsonBody,
                          r'''$''',
                        ).toList();
                        return GridView.builder(
                          padding: EdgeInsets.zero,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                            childAspectRatio: 1.0,
                          ),
                          scrollDirection: Axis.vertical,
                          itemCount: products.length,
                          itemBuilder: (context, productsIndex) {
                            final productsItem = products[productsIndex];
                            return ProductCardWidgetWidget(
                              key: Key(
                                  'Key2bc_${productsIndex}_of_${products.length}'),
                              title: getJsonField(
                                productsItem,
                                r'''$.name''',
                              ).toString(),
                              price: getJsonField(
                                productsItem,
                                r'''$.price''',
                              ).toString(),
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
                            );
                          },
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
    );
  }
}
