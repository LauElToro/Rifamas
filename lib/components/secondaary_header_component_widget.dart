import '/ff/ff_icon_button.dart';
import '/ff/ff_theme.dart';
import '/ff/ff_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'secondaary_header_component_model.dart';
export 'secondaary_header_component_model.dart';

class SecondaaryHeaderComponentWidget extends StatefulWidget {
  const SecondaaryHeaderComponentWidget({
    Key? key,
    this.title,
  }) : super(key: key);

  final String? title;

  @override
  _SecondaaryHeaderComponentWidgetState createState() =>
      _SecondaaryHeaderComponentWidgetState();
}

class _SecondaaryHeaderComponentWidgetState
    extends State<SecondaaryHeaderComponentWidget> {
  late SecondaaryHeaderComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SecondaaryHeaderComponentModel());

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

    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(10.0, 25.0, 0.0, 0.0),
      child: Container(
        width: MediaQuery.sizeOf(context).width * 1.0,
        height: 65.0,
        decoration: BoxDecoration(
          color: FFTheme.of(context).secondaryBackground,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                FFIconButton(
                  borderColor: Colors.transparent,
                  borderRadius: 20.0,
                  borderWidth: 1.0,
                  buttonSize: 40.0,
                  icon: FaIcon(
                    FontAwesomeIcons.arrowLeft,
                    color: FFTheme.of(context).primary,
                    size: 24.0,
                  ),
                  onPressed: () async {
                    context.safePop();
                  },
                ),
                if (widget.title != null && widget.title != '')
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 0.0, 0.0),
                    child: Text(
                      widget.title!,
                      style: FFTheme.of(context).headlineMedium.override(
                            fontFamily: 'Readex Pro',
                            color: FFTheme.of(context).primary,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
              ],
            ),
            if (widget.title == null || widget.title == '')
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                  child: Text(
                    '${(String balance) {
                      return balance.replaceAll(".", ",");
                    }(FFAppState().currentBalance)}',
                    style: FFTheme.of(context).titleLarge.override(
                          fontFamily: 'Readex Pro',
                          color: FFTheme.of(context).primary,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                Text(
                  '€ ',
                  style: FFTheme.of(context).titleLarge.override(
                        fontFamily: 'Readex Pro',
                        color: FFTheme.of(context).primary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
