import '/backend/api_requests/api_calls.dart';
import '/components/header_component_widget.dart';
import '/components/product_card_widget_widget.dart';
import '/ff/ff_theme.dart';
import '/ff/ff_util.dart';
import '/ff/ff_widgets.dart';
import '/pages/bottomnavigations/bottom_navigation_home_component/bottom_navigation_home_component_widget.dart';
import '/ff/random_data_util.dart' as random_data;
import 'my_product_list_all_page_widget.dart' show MyProductListAllPageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MyProductListAllPageModel
    extends FFModel<MyProductListAllPageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for bottomNavigationHomeComponent component.
  late BottomNavigationHomeComponentModel bottomNavigationHomeComponentModel;
  // Model for headerComponent component.
  late HeaderComponentModel headerComponentModel;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    bottomNavigationHomeComponentModel =
        createModel(context, () => BottomNavigationHomeComponentModel());
    headerComponentModel = createModel(context, () => HeaderComponentModel());
  }

  void dispose() {
    unfocusNode.dispose();
    bottomNavigationHomeComponentModel.dispose();
    headerComponentModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
