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
import 'home_page_widget.dart' show HomePageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class HomePageModel extends FFModel<HomePageWidget> {
  ///  Local state fields for this page.

  int? categorySelected;

  List<dynamic> productss = [];
  void addToProductss(dynamic item) => productss.add(item);
  void removeFromProductss(dynamic item) => productss.remove(item);
  void removeAtIndexFromProductss(int index) => productss.removeAt(index);
  void insertAtIndexInProductss(int index, dynamic item) =>
      productss.insert(index, item);
  void updateProductssAtIndex(int index, Function(dynamic) updateFn) =>
      productss[index] = updateFn(productss[index]);

  List<dynamic> categoriess = [];
  void addToCategoriess(dynamic item) => categoriess.add(item);
  void removeFromCategoriess(dynamic item) => categoriess.remove(item);
  void removeAtIndexFromCategoriess(int index) => categoriess.removeAt(index);
  void insertAtIndexInCategoriess(int index, dynamic item) =>
      categoriess.insert(index, item);
  void updateCategoriessAtIndex(int index, Function(dynamic) updateFn) =>
      categoriess[index] = updateFn(categoriess[index]);

  bool loading = false;

  int? productsPage = 1;

  bool setCategory = false;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Backend Call - API (get balance)] action in HomePage widget.
  ApiCallResponse? apiResultln1;
  // Stores action output result for [Backend Call - API (get Home Products)] action in Button widget.
  ApiCallResponse? apiResulthk;
  // State field(s) for GridView widget.

  PagingController<ApiPagingParams, dynamic>? gridViewPagingController;
  Function(ApiPagingParams nextPageMarker)? gridViewApiCall;

  // Stores action output result for [Backend Call - API (get products)] action in GridView widget.
  ApiCallResponse? productsResponseCopy;
  // Models for productCardWidget dynamic component.
  late FFDynamicModels<ProductCardWidgetModel> productCardWidgetModels;
  // Model for bottomNavigationHomeComponent component.
  late BottomNavigationHomeComponentModel bottomNavigationHomeComponentModel;
  // Model for headerComponent component.
  late HeaderComponentModel headerComponentModel;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    productCardWidgetModels = FFDynamicModels(() => ProductCardWidgetModel());
    bottomNavigationHomeComponentModel =
        createModel(context, () => BottomNavigationHomeComponentModel());
    headerComponentModel = createModel(context, () => HeaderComponentModel());
  }

  void dispose() {
    unfocusNode.dispose();
    gridViewPagingController?.dispose();
    productCardWidgetModels.dispose();
    bottomNavigationHomeComponentModel.dispose();
    headerComponentModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.

  PagingController<ApiPagingParams, dynamic> setGridViewController(
    Function(ApiPagingParams) apiCall,
  ) {
    gridViewApiCall = apiCall;
    return gridViewPagingController ??= _createGridViewController(apiCall);
  }

  PagingController<ApiPagingParams, dynamic> _createGridViewController(
    Function(ApiPagingParams) query,
  ) {
    final controller = PagingController<ApiPagingParams, dynamic>(
      firstPageKey: ApiPagingParams(
        nextPageNumber: 0,
        numItems: 0,
        lastResponse: null,
      ),
    );
    return controller..addPageRequestListener(gridViewGetProductsPage);
  }

  void gridViewGetProductsPage(ApiPagingParams nextPageMarker) =>
      gridViewApiCall!(nextPageMarker).then((gridViewGetProductsResponse) {
        List<dynamic> pageItems = (getJsonField(
                  gridViewGetProductsResponse.jsonBody,
                  r'''$''',
                ) ??
                [])
            .toList() as List;
        //removing hidden
        final adders = [];
        for (var i = 0; i < pageItems.length; i++) {
          if (getJsonField(
                pageItems[i],
                r'''$.catalog_visibility''',
              ).toString() !=
              "hidden") {
            adders.add(pageItems[i]);
          }
        }
        pageItems = adders;
        final newNumItems = nextPageMarker.numItems + pageItems.length;
        gridViewPagingController?.appendPage(
          pageItems,
          (pageItems.length > 0)
              ? ApiPagingParams(
                  nextPageNumber: nextPageMarker.nextPageNumber + 1,
                  numItems: newNumItems,
                  lastResponse: gridViewGetProductsResponse,
                )
              : null,
        );
      });

  Future waitForOnePageForGridView({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete =
          (gridViewPagingController?.nextPageKey?.nextPageNumber ?? 0) > 0;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }
}
