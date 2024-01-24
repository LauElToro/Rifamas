import '/ff/ff_theme.dart';
import '/ff/ff_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'selectedgift_page_model.dart';
export 'selectedgift_page_model.dart';

class SelectedgiftPageWidget extends StatefulWidget {
  const SelectedgiftPageWidget({
    Key? key,
    this.image,
  }) : super(key: key);

  final String? image;

  @override
  _SelectedgiftPageWidgetState createState() => _SelectedgiftPageWidgetState();
}

class _SelectedgiftPageWidgetState extends State<SelectedgiftPageWidget> {
  late SelectedgiftPageModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SelectedgiftPageModel());

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
      height: MediaQuery.sizeOf(context).height * 3.0,
      decoration: BoxDecoration(
        color: FFTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25.0),
        child: Image.network(
          widget.image!,
          width: MediaQuery.sizeOf(context).width * 1.0,
          height: 200.0,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
