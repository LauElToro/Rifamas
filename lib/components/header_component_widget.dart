import '/components/filter_component_widget.dart';
import '/ff/ff_icon_button.dart';
import '/ff/ff_theme.dart';
import '/ff/ff_util.dart';
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'header_component_model.dart';
export 'header_component_model.dart';

class HeaderComponentWidget extends StatefulWidget {
  const HeaderComponentWidget({Key? key}) : super(key: key);

  @override
  _HeaderComponentWidgetState createState() => _HeaderComponentWidgetState();
}

class _HeaderComponentWidgetState extends State<HeaderComponentWidget> {
  late HeaderComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HeaderComponentModel());

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
      height: 80.0,
      decoration: BoxDecoration(
        color: FFTheme.of(context).secondaryBackground,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Builder(
            builder: (context) => FFIconButton(
              borderColor: FFTheme.of(context).transparent,
              borderRadius: 6.0,
              borderWidth: 1.0,
              buttonSize: 50.0,
              icon: Icon(
                Icons.search,
                color: FFTheme.of(context).primary,
                size: 32.0,
              ),
              onPressed: () async {
                await showAlignedDialog(
                  barrierColor: Color(0x5D14181B),
                  context: context,
                  isGlobal: false,
                  avoidOverflow: true,
                  targetAnchor: AlignmentDirectional(0.0, -1.0)
                      .resolve(Directionality.of(context)),
                  followerAnchor: AlignmentDirectional(0.0, 0.0)
                      .resolve(Directionality.of(context)),
                  builder: (dialogContext) {
                    return Material(
                      color: Colors.transparent,
                      child: FilterComponentWidget(),
                    );
                  },
                ).then((value) => setState(() {}));
              },
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              'assets/images/logo.png',
              width: 50.0,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 8.0, 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                FFAppState().loggedIn
                    ? Text(
                        (String balance) {
                          return balance.replaceAll(".", ",");
                        }(FFAppState().currentBalance),
                        style: FFTheme.of(context).titleLarge.override(
                              fontFamily: 'Readex Pro',
                              color: FFTheme.of(context).primary,
                              fontWeight: FontWeight.w600,
                            ),
                      )
                    : Text(
                        '',
                        style: FFTheme.of(context).titleLarge.override(
                              fontFamily: 'Readex Pro',
                              color: FFTheme.of(context).primary,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                FFAppState().loggedIn
                    ? Text(
                        '€',
                        style: FFTheme.of(context).titleLarge.override(
                              fontFamily: 'Readex Pro',
                              color: FFTheme.of(context).primary,
                              fontWeight: FontWeight.bold,
                            ),
                      )
                    : Text(
                        '',
                        style: FFTheme.of(context).titleLarge.override(
                              fontFamily: 'Readex Pro',
                              color: FFTheme.of(context).primary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
              ].divide(SizedBox(width: 5.0)),
            ),
          ),
        ],
      ),
    );
  }
}
