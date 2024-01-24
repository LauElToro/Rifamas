import '/ff/ff_theme.dart';
import '/ff/ff_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'no_result_component_model.dart';
export 'no_result_component_model.dart';

class NoResultComponentWidget extends StatefulWidget {
  const NoResultComponentWidget({Key? key}) : super(key: key);

  @override
  _NoResultComponentWidgetState createState() =>
      _NoResultComponentWidgetState();
}

class _NoResultComponentWidgetState extends State<NoResultComponentWidget> {
  late NoResultComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NoResultComponentModel());

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
      height: 100.0,
      decoration: BoxDecoration(
        color: FFTheme.of(context).secondaryBackground,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: AlignmentDirectional(0.00, 0.00),
            child: Text(
              'No se encontraron resultados',
              textAlign: TextAlign.center,
              style: FFTheme.of(context).headlineMedium.override(
                    fontFamily: 'Montserrat',
                    color: FFTheme.of(context).secondaryText,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
