import '/backend/api_requests/api_calls.dart';
import '/components/secondaary_header_component_widget.dart';
import '/components/simple_product_card_widget_widget.dart';
import '/ff/ff_icon_button.dart';
import '/ff/ff_theme.dart';
import '/ff/ff_util.dart';
import '/ff/ff_widgets.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'favorites_product_list_page_model.dart';
export 'favorites_product_list_page_model.dart';

class FavoritesProductListPageWidget extends StatefulWidget {
  const FavoritesProductListPageWidget({Key? key}) : super(key: key);

  @override
  _FavoritesProductListPageWidgetState createState() =>
      _FavoritesProductListPageWidgetState();
}

class _FavoritesProductListPageWidgetState
    extends State<FavoritesProductListPageWidget> {
  late FavoritesProductListPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FavoritesProductListPageModel());

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
                  title: 'Favoritos',
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                  child: FutureBuilder<ApiCallResponse>(
                    future: (_model.apiRequestCompleter ??=
                            Completer<ApiCallResponse>()
                              ..complete(FavoritesCall.call(
                                favoritesList: FFAppState().favorites,
                              )))
                        .future,
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
                      final gridViewFavoritesResponse = snapshot.data!;
                      return Builder(
                        builder: (context) {
                          final products = getJsonField(
                            gridViewFavoritesResponse.jsonBody,
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
                              return Stack(
                                children: [
                                  SimpleProductCardWidgetWidget(
                                    key: Key(
                                        'Keyywq_${productsIndex}_of_${products.length}'),
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
                                  ),
                                  Align(
                                    alignment:
                                        AlignmentDirectional(1.10, -1.10),
                                    child: FFIconButton(
                                      borderColor:
                                          FFTheme.of(context).primary,
                                      borderRadius: 20.0,
                                      borderWidth: 1.0,
                                      buttonSize: 30.0,
                                      fillColor:
                                          FFTheme.of(context).error,
                                      icon: FaIcon(
                                        FontAwesomeIcons.trashAlt,
                                        color:
                                            FFTheme.of(context).info,
                                        size: 14.0,
                                      ),
                                      onPressed: () async {
                                        setState(() {
                                          FFAppState()
                                              .removeFromFavorites(getJsonField(
                                            productsItem,
                                            r'''$.id''',
                                          ));
                                        });
                                        setState(() =>
                                            _model.apiRequestCompleter = null);
                                        await _model.waitForApiRequestCompleted(
                                            minWait: 3);
                                      },
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      );
                    },
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
