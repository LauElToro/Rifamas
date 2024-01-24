import '/ff/ff_animations.dart';
import '/ff/ff_theme.dart';
import '/ff/ff_util.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'categories_loadiing_list_widget_model.dart';
export 'categories_loadiing_list_widget_model.dart';

class CategoriesLoadiingListWidgetWidget extends StatefulWidget {
  const CategoriesLoadiingListWidgetWidget({Key? key}) : super(key: key);

  @override
  _CategoriesLoadiingListWidgetWidgetState createState() =>
      _CategoriesLoadiingListWidgetWidgetState();
}

class _CategoriesLoadiingListWidgetWidgetState
    extends State<CategoriesLoadiingListWidgetWidget>
    with TickerProviderStateMixin {
  late CategoriesLoadiingListWidgetModel _model;

  final animationsMap = {
    'imageOnPageLoadAnimation1': AnimationInfo(
      loop: true,
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        MoveEffect(
          curve: Curves.easeIn,
          delay: 0.ms,
          duration: 600.ms,
          begin: Offset(-150.0, 0.0),
          end: Offset(150.0, 0.0),
        ),
      ],
    ),
    'imageOnPageLoadAnimation2': AnimationInfo(
      loop: true,
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        MoveEffect(
          curve: Curves.easeIn,
          delay: 0.ms,
          duration: 600.ms,
          begin: Offset(-150.0, 0.0),
          end: Offset(150.0, 0.0),
        ),
      ],
    ),
    'imageOnPageLoadAnimation3': AnimationInfo(
      loop: true,
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        MoveEffect(
          curve: Curves.easeIn,
          delay: 0.ms,
          duration: 600.ms,
          begin: Offset(-150.0, 0.0),
          end: Offset(150.0, 0.0),
        ),
      ],
    ),
  };

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CategoriesLoadiingListWidgetModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      width: MediaQuery.sizeOf(context).width * 1.0,
      height: 50.0,
      decoration: BoxDecoration(
        color: FFTheme.of(context).secondaryBackground,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Align(
                alignment: AlignmentDirectional(0.00, -1.00),
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 0.35,
                  height: 48.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFE5E5E5),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: ClipRect(
                    child: ImageFiltered(
                      imageFilter: ImageFilter.blur(
                        sigmaX: 6.0,
                        sigmaY: 6.0,
                      ),
                      child: Transform.rotate(
                        angle: 0.0,
                        child: Align(
                          alignment: AlignmentDirectional(0.00, -1.00),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(0.0),
                            child: Image.asset(
                              'assets/images/white-shimer.jpg',
                              width: 15.0,
                              height: 40.0,
                              fit: BoxFit.cover,
                              alignment: Alignment(1.00, 0.00),
                            ),
                          ).animateOnPageLoad(
                              animationsMap['imageOnPageLoadAnimation1']!),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              child: Align(
                alignment: AlignmentDirectional(0.00, -1.00),
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 0.35,
                  height: 48.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFE5E5E5),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: ClipRect(
                    child: ImageFiltered(
                      imageFilter: ImageFilter.blur(
                        sigmaX: 6.0,
                        sigmaY: 6.0,
                      ),
                      child: Transform.rotate(
                        angle: 0.0,
                        child: Align(
                          alignment: AlignmentDirectional(0.00, -1.00),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(0.0),
                            child: Image.asset(
                              'assets/images/white-shimer.jpg',
                              width: 15.0,
                              height: 40.0,
                              fit: BoxFit.cover,
                              alignment: Alignment(1.00, 0.00),
                            ),
                          ).animateOnPageLoad(
                              animationsMap['imageOnPageLoadAnimation2']!),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              child: Align(
                alignment: AlignmentDirectional(0.00, -1.00),
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 0.35,
                  height: 48.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFE5E5E5),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: ClipRect(
                    child: ImageFiltered(
                      imageFilter: ImageFilter.blur(
                        sigmaX: 6.0,
                        sigmaY: 6.0,
                      ),
                      child: Transform.rotate(
                        angle: 0.0,
                        child: Align(
                          alignment: AlignmentDirectional(0.00, -1.00),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(0.0),
                            child: Image.asset(
                              'assets/images/white-shimer.jpg',
                              width: 15.0,
                              height: 40.0,
                              fit: BoxFit.cover,
                              alignment: Alignment(1.00, 0.00),
                            ),
                          ).animateOnPageLoad(
                              animationsMap['imageOnPageLoadAnimation3']!),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ].divide(SizedBox(width: 15.0)),
        ),
      ),
    );
  }
}
