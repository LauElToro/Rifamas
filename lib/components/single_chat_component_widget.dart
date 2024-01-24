import '/backend/backend.dart';
import '/ff/ff_theme.dart';
import '/ff/ff_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'single_chat_component_model.dart';
export 'single_chat_component_model.dart';

class SingleChatComponentWidget extends StatefulWidget {
  const SingleChatComponentWidget({
    Key? key,
    required this.chat,
  }) : super(key: key);

  final ChatsRecord? chat;

  @override
  _SingleChatComponentWidgetState createState() =>
      _SingleChatComponentWidgetState();
}

class _SingleChatComponentWidgetState extends State<SingleChatComponentWidget> {
  late SingleChatComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SingleChatComponentModel());

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
      width: double.infinity,
      height: 180.0,
      decoration: BoxDecoration(
        color: FFTheme.of(context).secondaryBackground,
      ),
      alignment: AlignmentDirectional(0.00, 0.00),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 80.0,
              height: 80.0,
              decoration: BoxDecoration(),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  widget.chat!.image,
                  width: 120.0,
                  height: 120.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      valueOrDefault<String>(
                        widget.chat?.seller,
                        'N/A',
                      ),
                      style: FFTheme.of(context).titleMedium.override(
                            fontFamily: 'Montserrat',
                            color: FFTheme.of(context).primary,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                    Text(
                      valueOrDefault<String>(
                        widget.chat?.product,
                        'N/A',
                      ),
                      style:
                          FFTheme.of(context).headlineMedium.override(
                                fontFamily: 'Montserrat',
                                fontSize: 20.0,
                                fontWeight: FontWeight.w900,
                              ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                      child: Text(
                        widget.chat!.lastMessage,
                        style:
                            FFTheme.of(context).labelMedium.override(
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFF8B8B8B),
                                ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0),
              child: Text(
                valueOrDefault<String>(
                  dateTimeFormat('d/M/y', widget.chat?.lastMessageTime),
                  'HH:mm',
                ),
                style: FFTheme.of(context).bodySmall.override(
                      fontFamily: 'Montserrat',
                      color: Color(0xFF777982),
                      fontSize: 14.0,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
