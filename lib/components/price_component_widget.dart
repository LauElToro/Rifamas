import '/ff/ff_theme.dart';
import '/ff/ff_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'price_component_model.dart';
export 'price_component_model.dart';

class PriceComponentWidget extends StatefulWidget {
  const PriceComponentWidget({
    Key? key,
    String? price,
    String? regularPrice,
    String? type,
  })  : this.price = price ?? '0',
        this.regularPrice = regularPrice ?? '0',
        this.type = type ?? '0',
        super(key: key);

  final String price;
  final String regularPrice;
  final String type;

  @override
  _PriceComponentWidgetState createState() => _PriceComponentWidgetState();
}

class _PriceComponentWidgetState extends State<PriceComponentWidget> {
  late PriceComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PriceComponentModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.type);
    context.watch<FFAppState>();

    return Container(
      width: MediaQuery.sizeOf(context).width * 1.0,
      height: 100.0,
      decoration: BoxDecoration(
        color: FFTheme.of(context).secondaryBackground,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if ((widget.type == 'lottery') || (widget.type == 'rifa/venta'))
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(0.0),
                    child: Image.asset(
                      'assets/images/rifa-color.png',
                      width: 30.0,
                      height: 30.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Text(
                  '${double.parse(widget.price.replaceAll(",", ".")).toStringAsFixed(2).toString().replaceAll(".", ",")}€ ',
                  //TODO: ARREGLAR PRECION CUANDO VENGA EN EL BACKEND
                  //"SIN PRECIO",
                  style: FFTheme.of(context).bodyMedium.override(
                        fontFamily: 'Montserrat',
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                ),
              ],
            ),
          if ((widget.type == 'simple') || (widget.type == 'rifa/venta'))
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(0.0),
                    child: Image.asset(
                      'assets/images/monedas.png',
                      width: 30.0,
                      height: 30.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Text(
                  '${widget.regularPrice}€ ',
                  style: FFTheme.of(context).bodyMedium.override(
                        fontFamily: 'Montserrat',
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
        ].divide(SizedBox(width: 10.0)),
      ),
    );
  }
}
