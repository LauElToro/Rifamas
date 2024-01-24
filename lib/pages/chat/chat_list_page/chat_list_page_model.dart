import '/backend/backend.dart';
import '/components/header_component_widget.dart';
import '/components/single_chat_component_widget.dart';
import '/ff/ff_theme.dart';
import '/ff/ff_util.dart';
import '/ff/ff_widgets.dart';
import '/pages/bottomnavigations/bottom_navigation_home_component/bottom_navigation_home_component_widget.dart';
import 'chat_list_page_widget.dart' show ChatListPageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ChatListPageModel extends FFModel<ChatListPageWidget> {
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
