import '/backend/api_requests/api_calls.dart';
import '/components/secondaary_header_component_widget.dart';
import '/ff/ff_theme.dart';
import '/ff/ff_util.dart';
import '/ff/ff_widgets.dart';
import 'loteries_create_page_copy_widget.dart'
    show LoteriesCreatePageCopyWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoteriesCreatePageCopyModel
    extends FFModel<LoteriesCreatePageCopyWidget> {
  ///  Local state fields for this page.

  String name = '';

  String description = '';

  String shortDescription = '';

  String category = '1';

  String rifaType = 'lottery';

  String productState = 'Nuevo sin usar';

  int? productPrice = 0;

  int? maxTickets = 0;

  int? lotteryPrice;

  List<dynamic> categories = [];
  void addToCategories(dynamic item) => categories.add(item);
  void removeFromCategories(dynamic item) => categories.remove(item);
  void removeAtIndexFromCategories(int index) => categories.removeAt(index);
  void insertAtIndexInCategories(int index, dynamic item) =>
      categories.insert(index, item);
  void updateCategoriesAtIndex(int index, Function(dynamic) updateFn) =>
      categories[index] = updateFn(categories[index]);

  String type = '';

  String file = '';

  String rifaType2 = 'Publica';

  int? pesoProducto = 0;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  // Stores action output result for [Backend Call - API (categories)] action in loteriesCreatePageCopy widget.
  ApiCallResponse? apiResultmdc;
  // Model for secondaaryHeaderComponent component.
  late SecondaaryHeaderComponentModel secondaaryHeaderComponentModel;
  // State field(s) for title widget.
  FocusNode? titleFocusNode;
  TextEditingController? titleController;
  String? Function(BuildContext, String?)? titleControllerValidator;
  // State field(s) for description widget.
  FocusNode? descriptionFocusNode;
  TextEditingController? descriptionController;
  String? Function(BuildContext, String?)? descriptionControllerValidator;
  // State field(s) for max_tickets widget.
  FocusNode? maxTicketsFocusNode;
  TextEditingController? maxTicketsController;
  String? Function(BuildContext, String?)? maxTicketsControllerValidator;
  // State field(s) for lottery_price widget.
  FocusNode? lotteryPriceFocusNode;
  TextEditingController? lotteryPriceController;
  String? Function(BuildContext, String?)? lotteryPriceControllerValidator;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    secondaaryHeaderComponentModel =
        createModel(context, () => SecondaaryHeaderComponentModel());
  }

  void dispose() {
    unfocusNode.dispose();
    secondaaryHeaderComponentModel.dispose();
    titleFocusNode?.dispose();
    titleController?.dispose();

    descriptionFocusNode?.dispose();
    descriptionController?.dispose();

    maxTicketsFocusNode?.dispose();
    maxTicketsController?.dispose();

    lotteryPriceFocusNode?.dispose();
    lotteryPriceController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
