import '/ff/ff_theme.dart';
import '/ff/ff_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'membership_component_widget_model.dart';
export 'membership_component_widget_model.dart';

class MembershipComponentWidgetWidget extends StatefulWidget {
  const MembershipComponentWidgetWidget({
    Key? key,
    String? price,
    required this.cantSorteos,
    required this.title,
    required this.image,
    int? idMembership,
  })  : this.price = price ?? '\$',
        this.idMembership = idMembership ?? 0,
        super(key: key);

  final String price;
  final String? cantSorteos;
  final String? title;
  final String? image;
  final int idMembership;

  @override
  _MembershipComponentWidgetWidgetState createState() =>
      _MembershipComponentWidgetWidgetState();
}

class _MembershipComponentWidgetWidgetState
    extends State<MembershipComponentWidgetWidget> {
  late MembershipComponentWidgetModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MembershipComponentWidgetModel());

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
      padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 12.0),
      child: Container(
        width: MediaQuery.sizeOf(context).width * 1.0,
        height: 120.0,
        decoration: BoxDecoration(
          //color: FFTheme.of(context).alternate,
          // color: Colors.transparent,
          borderRadius: BorderRadius.circular(15.0),
          shape: BoxShape.rectangle,
          border: Border.all(color: Color.fromARGB(148, 68, 68, 68), width: 2),
        ),
        child: InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () async {
            context.pushNamed(
              'memberPageDetail',
              queryParameters: {
                'idMembresy': serializeParam(
                  widget.idMembership,
                  ParamType.int,
                ),
              }.withoutNulls,
            );
          },
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
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
                      widget.image!,
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title!,
                    textAlign: TextAlign.center,
                    style: FFTheme.of(context).bodyMedium.override(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                  Text(
                    '${widget.cantSorteos} sorteos / mes',
                    textAlign: TextAlign.center,
                    style: FFTheme.of(context).bodyMedium.override(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
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
                        widget.price,
                        style: FFTheme.of(context).bodyMedium.override(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
