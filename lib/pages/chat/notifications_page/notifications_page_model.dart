import '/components/header_component_widget.dart';
import '/ff/ff_theme.dart';
import '/ff/ff_util.dart';
import '/ff/ff_widgets.dart';
import '/pages/bottomnavigations/bottom_navigation_home_component/bottom_navigation_home_component_widget.dart';
import 'notifications_page_widget.dart' show NotificationsPageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class NotificationsPageModel extends FFModel<NotificationsPageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for headerComponent component.
  late HeaderComponentModel headerComponentModel;
  // Model for bottomNavigationHomeComponent component.
  late BottomNavigationHomeComponentModel bottomNavigationHomeComponentModel;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    headerComponentModel = createModel(context, () => HeaderComponentModel());
    bottomNavigationHomeComponentModel =
        createModel(context, () => BottomNavigationHomeComponentModel());
  }

  void dispose() {
    unfocusNode.dispose();
    headerComponentModel.dispose();
    bottomNavigationHomeComponentModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
