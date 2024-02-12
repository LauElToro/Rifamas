import 'dart:developer';
import 'dart:ui';

import '/ff/ff_theme.dart';
import '/ff/ff_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'product_card_widget_model.dart';
export 'product_card_widget_model.dart';

class ProductCardWidgetWidget extends StatefulWidget {
  const ProductCardWidgetWidget({
    Key? key,
    Color? color,
    this.title,
    this.price,
    required this.image,
    int? participants,
    required this.metadata,
    double? percentbar,
    String? type,
    String? status,
    String? maxTickets,
    this.regularPrice,
  })  : this.color = color ?? const Color(0xFFDEDEDE),
        this.participants = participants ?? 0,
        this.percentbar = percentbar ?? 0.0,
        this.type = type ?? 'lottery',
        this.status = status ?? '0',
        this.maxTickets = maxTickets ?? "0",
        super(key: key);

  final Color color;
  final String? title;
  final String? price;
  final String? image;
  final int participants;
  final dynamic metadata;
  final double percentbar;
  final String type;
  final String? regularPrice;
  final String status;
  final String maxTickets;

  @override
  _ProductCardWidgetWidgetState createState() =>
      _ProductCardWidgetWidgetState();
}

class _ProductCardWidgetWidgetState extends State<ProductCardWidgetWidget> {
  late ProductCardWidgetModel _model;

  bool dateValidation(String data) {
    final format = DateFormat("yyyy-MM-dd HH:mm");

    final date = format.parse(data);
    DateTime currentTime = DateTime.now();
    try {
      if (date.isAfter(format.parse(currentTime.toString()))) {
        return true;
      } else {
        return false;
      }
    } on FormatException catch (error) {
      // Manejar formato invalido aqui
      print("TITULO ${widget.title}");
      print("DATE: ${date}");
      print("CURRENTTIME: ${format.parse(currentTime.toString())}");
      print("Formato de fecha invalido: $error");
      return false;
    }
  }

  String banerString() {
    if (widget.participants == int.parse(widget.maxTickets)) {
      return "Rifa Finalizada";
    } else if (widget.participants < int.parse(widget.maxTickets)) {
      return "Rifa Fallida";
    } else {
      return "Exceso";
    }
  }

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProductCardWidgetModel());
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
      height: 350.0,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(15.0),
        shape: BoxShape.rectangle,
        border: Border.all(
          color: Color(0x00FFFFFF),
          width: 0.0,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: 100.0,
            height: widget.image == null ? 250.0 : 200.0,
            decoration: BoxDecoration(
              color: FFTheme.of(context).secondaryBackground,
              borderRadius: BorderRadius.circular(15.0),
            ),
            // child: BackdropFilter(
            //   filter: !dateValidation(widget.status)
            //       ? ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0)
            //       : ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
            //   child: Container(
            //     decoration: BoxDecoration(color: Colors.white.withOpacity(0.1)),
            //   ),
            // ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: ImageFiltered(
                    imageFilter: !dateValidation(widget.status)
                        ? ImageFilter.blur(sigmaX: 10, sigmaY: 10)
                        : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                    child: Image.network(
                      valueOrDefault<String>(
                        widget.image,
                        'https://t3.ftcdn.net/jpg/02/48/42/64/360_F_248426448_NVKLywWqArG2ADUxDq6QprtIzsF82dMF.jpg',
                      ),
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      height: 200.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                !dateValidation(widget.status)
                    ? Center(
                        child: Text(
                          banerString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    widget.title!.maybeHandleOverflow(
                      maxChars: 20,
                      replacement: '…',
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: FFTheme.of(context).bodyMedium.override(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if ((widget.type == 'lottery') ||
                          (widget.type == 'rifa/venta'))
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 10.0, 0.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(0.0),
                                child: Image.asset(
                                  'assets/images/rifa-color.png',
                                  width: 20.0,
                                  height: 20.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Text(
                              '${double.parse(widget.price!).toStringAsFixed(2).replaceAll(".", ",")}€',
                              style: FFTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Montserrat',
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                      if ((widget.type == 'simple') ||
                          (widget.type == 'rifa/venta'))
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 10.0, 0.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(0.0),
                                child: Image.asset(
                                  'assets/images/monedas.png',
                                  width: 20.0,
                                  height: 20.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Text(
                              '${widget.regularPrice}€ ',
                              style: FFTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Montserrat',
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0.00, 1.10),
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: 20.0,
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.sizeOf(context).width * 1.0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      border: Border.all(
                        color: Color(0x78A0ABB0),
                        width: 1.0,
                      ),
                    ),
                    child: Align(
                      alignment: AlignmentDirectional(0.00, 0.00),
                      child: Stack(
                        children: [
                          Container(
                            width: widget.percentbar *
                                100 *
                                2, //*2 is a visual fix
                            height: 100.0,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFF6FBF6B),
                                  FFTheme.of(context).secondaryBackground
                                ],
                                stops: [0.0, 1.0],
                                begin: AlignmentDirectional(1.0, 0.0),
                                end: AlignmentDirectional(-1.0, 0),
                              ),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0.00, 0.00),
                            child: Text(
                              formatNumber(
                                widget.percentbar,
                                formatType: FormatType.percent,
                              ),
                              style: FFTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ].divide(SizedBox(height: 0.0)),
            ),
          ),
        ],
      ),
    );
  }
}
