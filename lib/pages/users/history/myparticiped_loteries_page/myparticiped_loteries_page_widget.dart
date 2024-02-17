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
import 'myparticiped_loteries_page_model.dart';
export 'myparticiped_loteries_page_model.dart';

class MyparticipedLoteriesPageWidget extends StatefulWidget {
  const MyparticipedLoteriesPageWidget({Key? key}) : super(key: key);

  @override
  _MyparticipedLoteriesPageWidgetState createState() =>
      _MyparticipedLoteriesPageWidgetState();
}

class _MyparticipedLoteriesPageWidgetState
    extends State<MyparticipedLoteriesPageWidget> {
  late MyparticipedLoteriesPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MyparticipedLoteriesPageModel());

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
                  title: 'Rifas activas',
                ),
              ),
              Expanded(
                child: FutureBuilder<ApiCallResponse>(
                  future: GetProductsCall.call(
                    perPage: 2,
                    author: getJsonField(
                      FFAppState().jwtuser,
                      r'''$.ID''',
                    ),
                    type: 'lottery',
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
                    final gridViewMyOrderedProductsResponse = snapshot.data!;
                    return Builder(
                      builder: (context) {
                        final products = getJsonField(
                          gridViewMyOrderedProductsResponse.jsonBody,
                          r'''$''',
                        );
                        print(products[0]);
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
                            print(productsItem);
                            return ProductCardWidgetWidget(
                              key: Key(
                                  'Keysvi_${productsIndex}_of_${products.length}'),
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
