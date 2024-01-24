import '/ff/ff_theme.dart';
import '/ff/ff_util.dart';
import 'product_card_widget_widget.dart' show ProductCardWidgetWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProductCardWidgetModel extends FFModel<ProductCardWidgetWidget> {
  ///  Local state fields for this component.

  String title = '';

  double? price;

  dynamic metadata;

  int? participants;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {}

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
