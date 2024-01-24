import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/components/legal_base_component_widget.dart';
import '/components/price_component_widget.dart';
import '/ff/ff_animations.dart';
import '/ff/ff_icon_button.dart';
import '/ff/ff_theme.dart';
import '/ff/ff_util.dart';
import '/ff/ff_widgets.dart';
import '/pages/loteries/components/bottom_navigation_widget_product/bottom_navigation_widget_product_widget.dart';
import '/ff/custom_functions.dart' as functions;
import 'product_detail_widget.dart' show ProductDetailWidget;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class ProductDetailModel extends FFModel<ProductDetailWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for priceComponent component.
  late PriceComponentModel priceComponentModel;
  // Stores action output result for [Backend Call - Create Document] action in Icon widget.
  ChatsRecord? chatResponse;
  // Model for bottomNavigationWidgetProduct component.
  late BottomNavigationWidgetProductModel bottomNavigationWidgetProductModel;
  // Stores action output result for [Backend Call - Create Document] action in Icon widget.
  ChatsRecord? chatResponseProduct;
  ApiCallResponse? apiCallser;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    priceComponentModel = createModel(context, () => PriceComponentModel());
    bottomNavigationWidgetProductModel =
        createModel(context, () => BottomNavigationWidgetProductModel());
  }

  void dispose() {
    unfocusNode.dispose();
    priceComponentModel.dispose();
    bottomNavigationWidgetProductModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
