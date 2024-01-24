import '/backend/api_requests/api_calls.dart';
import '/components/secondaary_header_component_widget.dart';
import '/ff/ff_drop_down.dart';
import '/ff/ff_theme.dart';
import '/ff/ff_util.dart';
import '/ff/ff_widgets.dart';
import '/ff/form_field_controller.dart';
import '/ff/upload_data.dart';
import '/ff/custom_functions.dart' as functions;
import 'loteries_create_page_widget.dart' show LoteriesCreatePageWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoteriesCreatePageModel
    extends FFModel<LoteriesCreatePageWidget> {
  ///  Local state fields for this page.

  String name = '';

  String description = '';

  String shortDescription = '';

  String category = '1';

  String rifaType = 'lottery';

  String productState = 'Nuevo sin usar';

  int productPrice = 0;

  String maxTickets = '0';

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

  int maxTicketsPerUser = 0;

  bool limitTicketsPerUser = false;

  int? cantRandom = 0;

  int cantTripleX = 0;

  List<FFUploadedFile> files = [];
  void addToFiles(FFUploadedFile item) => files.add(item);
  void removeFromFiles(FFUploadedFile item) => files.remove(item);
  void removeAtIndexFromFiles(int index) => files.removeAt(index);
  void insertAtIndexInFiles(int index, FFUploadedFile item) =>
      files.insert(index, item);
  void updateFilesAtIndex(int index, Function(FFUploadedFile) updateFn) =>
      files[index] = updateFn(files[index]);

  String password = '';

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  // Stores action output result for [Backend Call - API (categories)] action in loteriesCreatePage widget.
  ApiCallResponse? apiResultdtu;
  // State field(s) for type widget.
  String? typeValue;
  FormFieldController<String>? typeValueController;
  // State field(s) for title widget.
  FocusNode? titleFocusNode;
  TextEditingController? titleController;
  String? Function(BuildContext, String?)? titleControllerValidator;
  String? _titleControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Requerido';
    }

    return null;
  }

  // State field(s) for description widget.
  FocusNode? descriptionFocusNode;
  TextEditingController? descriptionController;
  String? Function(BuildContext, String?)? descriptionControllerValidator;
  String? _descriptionControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Requerido';
    }

    return null;
  }

  bool isDataUploading = false;
  List<FFUploadedFile> uploadedLocalFiles = [];

  // State field(s) for category widget.
  String? categoryValue;
  FormFieldController<String>? categoryValueController;
  // State field(s) for rifa_type widget.
  String? rifaTypeValue;
  FormFieldController<String>? rifaTypeValueController;
  // State field(s) for password widget.
  FocusNode? passwordFocusNode;
  TextEditingController? passwordController;
  String? Function(BuildContext, String?)? passwordControllerValidator;
  // State field(s) for product_state widget.
  String? productStateValue;
  FormFieldController<String>? productStateValueController;
  // State field(s) for product_price widget.
  FocusNode? productPriceFocusNode;
  TextEditingController? productPriceController;
  String? Function(BuildContext, String?)? productPriceControllerValidator;
  String? _productPriceControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Requerido';
    }

    return null;
  }

  // State field(s) for weight widget.
  int? weightValue;
  FormFieldController<int>? weightValueController;
  // State field(s) for max_tickets widget.
  FocusNode? maxTicketsFocusNode;
  TextEditingController? maxTicketsController;
  String? Function(BuildContext, String?)? maxTicketsControllerValidator;
  String? _maxTicketsControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Requerido';
    }

    return null;
  }

  // State field(s) for dropdown_tickets widget.
  String? dropdownTicketsValue;
  FormFieldController<String>? dropdownTicketsValueController;
  // State field(s) for tickets_per_user widget.
  FocusNode? ticketsPerUserFocusNode;
  TextEditingController? ticketsPerUserController;
  String? Function(BuildContext, String?)? ticketsPerUserControllerValidator;
  // State field(s) for Checkbox widget.
  bool? checkboxValue1;
  // State field(s) for Checkbox widget.
  bool? checkboxValue2;
  // State field(s) for Checkbox widget.
  bool? checkboxValue3;
  // Stores action output result for [Backend Call - API (create product)] action in Button widget.
  ApiCallResponse? apiResultjey;
  // Model for secondaaryHeaderComponent component.
  late SecondaaryHeaderComponentModel secondaaryHeaderComponentModel;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    titleControllerValidator = _titleControllerValidator;
    descriptionControllerValidator = _descriptionControllerValidator;
    productPriceControllerValidator = _productPriceControllerValidator;
    maxTicketsControllerValidator = _maxTicketsControllerValidator;
    secondaaryHeaderComponentModel =
        createModel(context, () => SecondaaryHeaderComponentModel());
  }

  void dispose() {
    unfocusNode.dispose();
    titleFocusNode?.dispose();
    titleController?.dispose();

    descriptionFocusNode?.dispose();
    descriptionController?.dispose();

    passwordFocusNode?.dispose();
    passwordController?.dispose();

    productPriceFocusNode?.dispose();
    productPriceController?.dispose();

    maxTicketsFocusNode?.dispose();
    maxTicketsController?.dispose();

    ticketsPerUserFocusNode?.dispose();
    ticketsPerUserController?.dispose();

    secondaaryHeaderComponentModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
