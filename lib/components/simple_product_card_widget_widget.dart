import '/ff/ff_theme.dart';
import '/ff/ff_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'simple_product_card_widget_model.dart';
export 'simple_product_card_widget_model.dart';

class SimpleProductCardWidgetWidget extends StatefulWidget {
  const SimpleProductCardWidgetWidget({
    Key? key,
    Color? color,
    this.title,
    this.price,
    required this.image,
  })  : this.color = color ?? const Color(0xFFDEDEDE),
        super(key: key);

  final Color color;
  final String? title;
  final String? price;
  final String? image;

  @override
  _SimpleProductCardWidgetWidgetState createState() =>
      _SimpleProductCardWidgetWidgetState();
}

class _SimpleProductCardWidgetWidgetState
    extends State<SimpleProductCardWidgetWidget> {
  late SimpleProductCardWidgetModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SimpleProductCardWidgetModel());

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
      height: 240.0,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(15.0),
        shape: BoxShape.rectangle,
        border: Border.all(
          color: FFTheme.of(context).alternate,
          width: 2.0,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
            child: Container(
              width: 100.0,
              height: 100.0,
              decoration: BoxDecoration(
                color: FFTheme.of(context).secondaryBackground,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  valueOrDefault<String>(
                    widget.image,
                    'https://t3.ftcdn.net/jpg/02/48/42/64/360_F_248426448_NVKLywWqArG2ADUxDq6QprtIzsF82dMF.jpg',
                  ),
                  width: MediaQuery.sizeOf(context).width * 1.0,
                  height: 250.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            child: Text(
              widget.title!,
              textAlign: TextAlign.center,
              style: FFTheme.of(context).bodyMedium.override(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.price != "" ? '€ ${widget.price}' : 'Sin Precio',
                style: FFTheme.of(context).bodyMedium.override(
                      fontFamily: 'Montserrat',
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          Flexible(
            child: Align(
              alignment: AlignmentDirectional(0.00, 1.00),
              child: Container(
                width: MediaQuery.sizeOf(context).width * 1.0,
                height: 20.0,
                decoration: BoxDecoration(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
