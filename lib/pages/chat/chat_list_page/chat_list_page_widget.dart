import 'package:jwt_decoder/jwt_decoder.dart';

import '/backend/backend.dart';
import '/components/header_component_widget.dart';
import '/components/single_chat_component_widget.dart';
import '/ff/ff_theme.dart';
import '/ff/ff_util.dart';
import '/ff/ff_widgets.dart';
import '/pages/bottomnavigations/bottom_navigation_home_component/bottom_navigation_home_component_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'chat_list_page_model.dart';
export 'chat_list_page_model.dart';

class ChatListPageWidget extends StatefulWidget {
  const ChatListPageWidget({Key? key}) : super(key: key);

  @override
  _ChatListPageWidgetState createState() => _ChatListPageWidgetState();
}

class _ChatListPageWidgetState extends State<ChatListPageWidget> {
  late ChatListPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChatListPageModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final decodedJWT = JwtDecoder.decode(FFAppState().jwtuser['_jwtuser']);
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FFTheme.of(context).secondaryBackground,
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10.0, 80.0, 10.0, 60.0),
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 1.0,
                  height: MediaQuery.sizeOf(context).height * 1.0,
                  decoration: BoxDecoration(
                    color: FFTheme.of(context).secondaryBackground,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 8.0, 0.0, 8.0),
                              child: FFButtonWidget(
                                onPressed: () {
                                  print('Button pressed ...');
                                },
                                text: 'Mensajes',
                                options: FFButtonOptions(
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.45,
                                  height: 48.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: FFTheme.of(context).primary,
                                  textStyle:
                                      FFTheme.of(context).labelMedium.override(
                                            fontFamily: 'Montserrat',
                                            color: FFTheme.of(context).info,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                  elevation: 0.0,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 8.0, 0.0, 8.0),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  context.pushNamed(
                                    'notificationsPage',
                                    extra: <String, dynamic>{
                                      kTransitionInfoKey: TransitionInfo(
                                        hasTransition: true,
                                        transitionType:
                                            PageTransitionType.bottomToTop,
                                      ),
                                    },
                                  );
                                },
                                text: 'Notificaciones',
                                options: FFButtonOptions(
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.45,
                                  height: 48.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color:
                                      FFTheme.of(context).secondaryBackground,
                                  textStyle:
                                      FFTheme.of(context).labelMedium.override(
                                            fontFamily: 'Montserrat',
                                            color: FFTheme.of(context).primary,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                  elevation: 0.0,
                                  borderSide: BorderSide(
                                    color: FFTheme.of(context).primary,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 80.0),
                          child: StreamBuilder<List<ChatsRecord>>(
                            stream: queryChatsRecord(
                              queryBuilder: (chatsRecord) => chatsRecord
                                  .where(
                                    'users',
                                  )
                                  .orderBy(
                                    'last_message_time',
                                    descending: true,
                                  ),
                            ),
                            builder: (context, snapshot) {
                              // Customize what your widget looks like when it's loading.

                              if (!snapshot.hasData) {
                                return Center(
                                  child: SizedBox(
                                    width: 50.0,
                                    height: 50.0,
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        FFTheme.of(context).primary,
                                      ),
                                    ),
                                  ),
                                );
                              }
                              List<ChatsRecord> columnChatsRecordList =
                                  snapshot.data!;
                              print(getJsonField(
                                decodedJWT['data']['user'],
                                r'''$.id''',
                              ));
                              
                              return SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: List.generate(
                                      columnChatsRecordList.length,
                                      (columnIndex) {
                                    // print(snapshot.data)
                                    final columnChatsRecord =
                                        columnChatsRecordList[columnIndex];

                                    return InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        context.pushNamed(
                                          'chatSinglePage',
                                          queryParameters: {
                                            'chat': serializeParam(
                                              columnChatsRecord,
                                              ParamType.Document,
                                            ),
                                            'chatReference': serializeParam(
                                              columnChatsRecord.reference,
                                              ParamType.DocumentReference,
                                            ),
                                          }.withoutNulls,
                                          extra: <String, dynamic>{
                                            'chat': columnChatsRecord,
                                          },
                                        );
                                      },
                                      child: SingleChatComponentWidget(
                                        key: Key(
                                            'Keypim_${columnIndex}_of_${columnChatsRecordList.length}'),
                                        chat: columnChatsRecord,
                                      ),
                                    );
                                  }),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              wrapWithModel(
                model: _model.bottomNavigationHomeComponentModel,
                updateCallback: () => setState(() {}),
                child: BottomNavigationHomeComponentWidget(
                  page: 'chat',
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.00, -1.00),
                child: wrapWithModel(
                  model: _model.headerComponentModel,
                  updateCallback: () => setState(() {}),
                  child: HeaderComponentWidget(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
