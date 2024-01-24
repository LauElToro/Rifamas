import '/backend/api_requests/api_calls.dart';
import '/ff/ff_theme.dart';
import '/ff/ff_util.dart';
import '/ff/ff_widgets.dart';
import '/ff/custom_functions.dart' as functions;
import 'mid_select_component_widget.dart' show MidSelectComponentWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MidSelectComponentModel extends FFModel<MidSelectComponentWidget> {
  ///  Local state fields for this component.

  int lotteryNumber = 0;

  List<int> lotteryNumbers = [];
  void addToLotteryNumbers(int item) => lotteryNumbers.add(item);
  void removeFromLotteryNumbers(int item) => lotteryNumbers.remove(item);
  void removeAtIndexFromLotteryNumbers(int index) =>
      lotteryNumbers.removeAt(index);
  void insertAtIndexInLotteryNumbers(int index, int item) =>
      lotteryNumbers.insert(index, item);
  void updateLotteryNumbersAtIndex(int index, Function(int) updateFn) =>
      lotteryNumbers[index] = updateFn(lotteryNumbers[index]);

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - API (add to cart)] action in Button widget.
  ApiCallResponse? apiResultywtCopy;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {}

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
