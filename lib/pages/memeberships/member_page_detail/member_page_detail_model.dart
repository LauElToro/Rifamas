import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/ff/ff_icon_button.dart';
import '/ff/ff_theme.dart';
import '/ff/ff_util.dart';
import '/ff/ff_widgets.dart';
import '/pages/memeberships/selectedgift_page/selectedgift_page_widget.dart';
import '/ff/custom_functions.dart' as functions;
import 'member_page_detail_widget.dart' show MemberPageDetailWidget;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class MemberPageDetailModel extends FFModel<MemberPageDetailWidget> {
  ///  Local state fields for this page.

  int suscription = 0;

  String imageSelected = 'false';

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Backend Call - API (add to cart)] action in Button widget.
  ApiCallResponse? apiResultywtCopy;
  // Stores action output result for [Backend Call - Create Document] action in Icon widget.
  ChatsRecord? chatResponseMembership;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
