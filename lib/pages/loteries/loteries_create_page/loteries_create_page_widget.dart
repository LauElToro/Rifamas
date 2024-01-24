import '/backend/api_requests/api_calls.dart';
import '/components/secondaary_header_component_widget.dart';
import '/ff/ff_drop_down.dart';
import '/ff/ff_theme.dart';
import '/ff/ff_util.dart';
import '/ff/ff_widgets.dart';
import '/ff/form_field_controller.dart';
import '/ff/upload_data.dart';
import '/ff/custom_functions.dart' as functions;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'loteries_create_page_model.dart';
export 'loteries_create_page_model.dart';

class LoteriesCreatePageWidget extends StatefulWidget {
  const LoteriesCreatePageWidget({Key? key}) : super(key: key);

  @override
  _LoteriesCreatePageWidgetState createState() =>
      _LoteriesCreatePageWidgetState();
}

class _LoteriesCreatePageWidgetState extends State<LoteriesCreatePageWidget> {
  late LoteriesCreatePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoteriesCreatePageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.apiResultdtu = await CategoriesCall.call();
      if ((_model.apiResultdtu?.succeeded ?? true)) {
        setState(() {
          _model.categories =
              (_model.apiResultdtu?.jsonBody ?? '').toList().cast<dynamic>();
        });
      }
    });

    _model.titleController ??= TextEditingController(text: _model.name);
    _model.titleFocusNode ??= FocusNode();
    _model.descriptionController ??= TextEditingController();
    _model.descriptionFocusNode ??= FocusNode();
    _model.passwordController ??= TextEditingController();
    _model.passwordFocusNode ??= FocusNode();
    _model.productPriceController ??= TextEditingController();
    _model.productPriceFocusNode ??= FocusNode();
    _model.maxTicketsController ??= TextEditingController();
    _model.maxTicketsFocusNode ??= FocusNode();
    _model.ticketsPerUserController ??= TextEditingController();
    _model.ticketsPerUserFocusNode ??= FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            alignment: AlignmentDirectional(0.0, 1.0),
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 80.0, 0.0, 0.0),
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 1.0,
                  height: MediaQuery.sizeOf(context).height * 1.0,
                  decoration: BoxDecoration(),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    children: [
                      Form(
                        key: _model.formKey,
                        autovalidateMode: AutovalidateMode.disabled,
                        child: Align(
                          alignment: AlignmentDirectional(0.00, 0.00),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10.0, 0.0, 10.0, 0.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 10.0, 0.0, 10.0),
                                      child: Text(
                                        'Informacion basica',
                                        style: FFTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Montserrat',
                                              color: FFTheme.of(context)
                                                  .primaryText,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ),
                                    FFDropDown<String>(
                                      controller: _model.typeValueController ??=
                                          FormFieldController<String>(
                                        _model.typeValue ??= 'lottery',
                                      ),
                                      options: List<String>.from(
                                          ['lottery', 'simple', 'rifa/venta']),
                                      optionLabels: [
                                        'Rifa',
                                        'Venta',
                                        'Rifa/Venta'
                                      ],
                                      onChanged: (val) async {
                                        setState(() => _model.typeValue = val);
                                        setState(() {
                                          _model.type = _model.typeValue!;
                                        });
                                      },
                                      width: MediaQuery.sizeOf(context).width *
                                          1.0,
                                      height: 50.0,
                                      textStyle: FFTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Montserrat',
                                            color: FFTheme.of(context)
                                                .secondaryText,
                                            fontWeight: FontWeight.bold,
                                          ),
                                      hintText: 'TIPO DE PUBLICACION',
                                      icon: Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        color: FFTheme.of(context).primary,
                                        size: 24.0,
                                      ),
                                      fillColor: FFTheme.of(context)
                                          .secondaryBackground,
                                      elevation: 2.0,
                                      borderColor: Color(0x56000000),
                                      borderWidth: 1.0,
                                      borderRadius: 8.0,
                                      margin: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 4.0, 16.0, 4.0),
                                      hidesUnderline: true,
                                      isSearchable: false,
                                      isMultiSelect: false,
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 10.0, 0.0, 10.0),
                                      child: TextFormField(
                                        controller: _model.titleController,
                                        focusNode: _model.titleFocusNode,
                                        onChanged: (_) => EasyDebounce.debounce(
                                          '_model.titleController',
                                          Duration(milliseconds: 2000),
                                          () async {
                                            setState(() {
                                              _model.name =
                                                  _model.titleController.text;
                                            });
                                          },
                                        ),
                                        autofocus: true,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelStyle:
                                              FFTheme.of(context).labelMedium,
                                          hintText: 'TITULO DEL PRODUCTO',
                                          hintStyle: FFTheme.of(context)
                                              .labelMedium
                                              .override(
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.bold,
                                              ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x56000000),
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FFTheme.of(context).primary,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: FFTheme.of(context).error,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: FFTheme.of(context).error,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                        style: FFTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Montserrat',
                                              color: FFTheme.of(context)
                                                  .secondaryText,
                                              fontWeight: FontWeight.bold,
                                            ),
                                        validator: _model
                                            .titleControllerValidator
                                            .asValidator(context),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 10.0, 0.0, 10.0),
                                      child: TextFormField(
                                        controller:
                                            _model.descriptionController,
                                        focusNode: _model.descriptionFocusNode,
                                        onChanged: (_) => EasyDebounce.debounce(
                                          '_model.descriptionController',
                                          Duration(milliseconds: 2000),
                                          () async {
                                            setState(() {
                                              _model.description = _model
                                                  .descriptionController.text;
                                            });
                                          },
                                        ),
                                        autofocus: true,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelStyle: FFTheme.of(context)
                                              .labelMedium
                                              .override(
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.bold,
                                              ),
                                          hintText: 'DESCRIPCION DEL PRODUCTO',
                                          hintStyle: FFTheme.of(context)
                                              .labelMedium
                                              .override(
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.bold,
                                              ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x56000000),
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FFTheme.of(context).primary,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: FFTheme.of(context).error,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: FFTheme.of(context).error,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                        style: FFTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Montserrat',
                                              color: FFTheme.of(context)
                                                  .secondaryText,
                                              fontWeight: FontWeight.bold,
                                            ),
                                        maxLines: 4,
                                        validator: _model
                                            .descriptionControllerValidator
                                            .asValidator(context),
                                      ),
                                    ),
                                    Align(
                                      alignment:
                                          AlignmentDirectional(0.00, 0.00),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 10.0, 0.0, 10.0),
                                        child: Container(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  1.0,
                                          height: 50.0,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25.0),
                                          ),
                                          child: Builder(
                                            builder: (context) {
                                              final fileList =
                                                  _model.files.toList();
                                              return Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: List.generate(
                                                    fileList.length,
                                                    (fileListIndex) {
                                                  final fileListItem =
                                                      fileList[fileListIndex];
                                                  return Container(
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.2,
                                                    height: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.2,
                                                    decoration: BoxDecoration(
                                                      color: FFTheme.of(context)
                                                          .secondaryBackground,
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                        color:
                                                            FFTheme.of(context)
                                                                .primary,
                                                        width: 3.0,
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  3.0,
                                                                  3.0,
                                                                  3.0,
                                                                  3.0),
                                                      child: Container(
                                                        width: 20.0,
                                                        height: 20.0,
                                                        clipBehavior:
                                                            Clip.antiAlias,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: Image.memory(
                                                          fileListItem.bytes ??
                                                              Uint8List
                                                                  .fromList([]),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment:
                                          AlignmentDirectional(0.00, 0.00),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 10.0, 0.0, 10.0),
                                        child: Container(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  0.8,
                                          height: 50.0,
                                          decoration: BoxDecoration(
                                            color: FFTheme.of(context).primary,
                                            borderRadius:
                                                BorderRadius.circular(25.0),
                                          ),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              final selectedMedia =
                                                  await selectMedia(
                                                mediaSource:
                                                    MediaSource.photoGallery,
                                                multiImage: true,
                                              );
                                              if (selectedMedia != null &&
                                                  selectedMedia.every((m) =>
                                                      validateFileFormat(
                                                          m.storagePath,
                                                          context))) {
                                                setState(() => _model
                                                    .isDataUploading = true);
                                                var selectedUploadedFiles =
                                                    <FFUploadedFile>[];

                                                try {
                                                  selectedUploadedFiles =
                                                      selectedMedia
                                                          .map((m) =>
                                                              FFUploadedFile(
                                                                name: m
                                                                    .storagePath
                                                                    .split('/')
                                                                    .last,
                                                                bytes: m.bytes,
                                                                height: m
                                                                    .dimensions
                                                                    ?.height,
                                                                width: m
                                                                    .dimensions
                                                                    ?.width,
                                                                blurHash:
                                                                    m.blurHash,
                                                              ))
                                                          .toList();
                                                } finally {
                                                  _model.isDataUploading =
                                                      false;
                                                }
                                                if (selectedUploadedFiles
                                                        .length ==
                                                    selectedMedia.length) {
                                                  setState(() {
                                                    _model.uploadedLocalFiles =
                                                        selectedUploadedFiles;
                                                  });
                                                } else {
                                                  setState(() {});
                                                  return;
                                                }
                                              }

                                              setState(() {
                                                _model.files = _model
                                                    .uploadedLocalFiles
                                                    .toList()
                                                    .cast<FFUploadedFile>();
                                              });
                                            },
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.file_upload_outlined,
                                                  color: FFTheme.of(context)
                                                      .secondaryBackground,
                                                  size: 24.0,
                                                ),
                                                Text(
                                                  'CARGAR IMAGENES',
                                                  style: FFTheme.of(context)
                                                      .bodyLarge
                                                      .override(
                                                        fontFamily:
                                                            'Montserrat',
                                                        color: FFTheme.of(
                                                                context)
                                                            .secondaryBackground,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 1.0,
                                color: Color(0x8A2183D6),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10.0, 0.0, 10.0, 0.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 10.0, 0.0, 10.0),
                                      child: Text(
                                        'Categorización',
                                        style: FFTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Montserrat',
                                              color: FFTheme.of(context)
                                                  .primaryText,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w800,
                                            ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 10.0, 0.0, 10.0),
                                      child: FFDropDown<String>(
                                        controller:
                                            _model.categoryValueController ??=
                                                FormFieldController<String>(
                                          _model.categoryValue ??= '',
                                        ),
                                        options:
                                            List<String>.from(_model.categories
                                                .map((e) => getJsonField(
                                                      e,
                                                      r'''$.id''',
                                                    ))
                                                .toList()
                                                .map((e) => e.toString())
                                                .toList()),
                                        optionLabels: _model.categories
                                            .map((e) => getJsonField(
                                                  e,
                                                  r'''$.name''',
                                                ))
                                            .toList()
                                            .map((e) => e.toString())
                                            .toList(),
                                        onChanged: (val) async {
                                          setState(
                                              () => _model.categoryValue = val);
                                          setState(() {
                                            _model.category =
                                                _model.categoryValue!;
                                          });
                                        },
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                1.0,
                                        height: 50.0,
                                        textStyle: FFTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Montserrat',
                                              color: FFTheme.of(context)
                                                  .secondaryText,
                                              fontWeight: FontWeight.bold,
                                            ),
                                        hintText: 'CATEGORIA',
                                        icon: Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          color:
                                              FFTheme.of(context).secondaryText,
                                          size: 24.0,
                                        ),
                                        fillColor: FFTheme.of(context)
                                            .secondaryBackground,
                                        elevation: 2.0,
                                        borderColor: Color(0x56000000),
                                        borderWidth: 1.0,
                                        borderRadius: 8.0,
                                        margin: EdgeInsetsDirectional.fromSTEB(
                                            16.0, 4.0, 16.0, 4.0),
                                        hidesUnderline: true,
                                        isSearchable: false,
                                        isMultiSelect: false,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 10.0, 0.0, 10.0),
                                      child: FFDropDown<String>(
                                        controller:
                                            _model.rifaTypeValueController ??=
                                                FormFieldController<String>(
                                          _model.rifaTypeValue ??= 'Random',
                                        ),
                                        options: ['Random', 'Triple x'],
                                        onChanged: (val) async {
                                          setState(
                                              () => _model.rifaTypeValue = val);
                                          setState(() {
                                            _model.rifaType =
                                                _model.rifaTypeValue!;
                                          });
                                        },
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                1.0,
                                        height: 50.0,
                                        textStyle: FFTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Montserrat',
                                              color: FFTheme.of(context)
                                                  .secondaryText,
                                              fontWeight: FontWeight.bold,
                                            ),
                                        hintText: 'TIPO DE SORTEO',
                                        icon: Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          color:
                                              FFTheme.of(context).secondaryText,
                                          size: 24.0,
                                        ),
                                        fillColor: FFTheme.of(context)
                                            .secondaryBackground,
                                        elevation: 2.0,
                                        borderColor: Color(0x56000000),
                                        borderWidth: 1.0,
                                        borderRadius: 8.0,
                                        margin: EdgeInsetsDirectional.fromSTEB(
                                            16.0, 4.0, 16.0, 4.0),
                                        hidesUnderline: true,
                                        isSearchable: false,
                                        isMultiSelect: false,
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            setState(() {
                                              _model.rifaType2 = 'Publica';
                                            });
                                          },
                                          child: Container(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.45,
                                            height: 50.0,
                                            decoration: BoxDecoration(
                                              color: _model.rifaType2 ==
                                                      'Publica'
                                                  ? FFTheme.of(context).primary
                                                  : FFTheme.of(context)
                                                      .secondaryBackground,
                                              borderRadius: BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(10.0),
                                                bottomRight:
                                                    Radius.circular(0.0),
                                                topLeft: Radius.circular(10.0),
                                                topRight: Radius.circular(0.0),
                                              ),
                                              border: Border.all(
                                                color: FFTheme.of(context)
                                                    .secondaryText,
                                              ),
                                            ),
                                            child: Align(
                                              alignment: AlignmentDirectional(
                                                  0.00, 0.00),
                                              child: Text(
                                                'Pública',
                                                style: FFTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Montserrat',
                                                      color: _model.rifaType2 ==
                                                              'Publica'
                                                          ? FFTheme.of(context)
                                                              .secondaryBackground
                                                          : FFTheme.of(context)
                                                              .secondaryText,
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            setState(() {
                                              _model.rifaType2 = 'Privada';
                                            });
                                          },
                                          child: Container(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.45,
                                            height: 50.0,
                                            decoration: BoxDecoration(
                                              color: _model.rifaType2 ==
                                                      'Privada'
                                                  ? FFTheme.of(context).primary
                                                  : FFTheme.of(context)
                                                      .secondaryBackground,
                                              borderRadius: BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(0.0),
                                                bottomRight:
                                                    Radius.circular(10.0),
                                                topLeft: Radius.circular(0.0),
                                                topRight: Radius.circular(10.0),
                                              ),
                                              border: Border.all(
                                                color: FFTheme.of(context)
                                                    .secondaryText,
                                              ),
                                            ),
                                            child: Align(
                                              alignment: AlignmentDirectional(
                                                  0.00, 0.00),
                                              child: Text(
                                                'Privada',
                                                style: FFTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Montserrat',
                                                      color: _model.rifaType2 ==
                                                              'Privada'
                                                          ? FFTheme.of(context)
                                                              .secondaryBackground
                                                          : FFTheme.of(context)
                                                              .secondaryText,
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (_model.rifaType2 == 'Privada')
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 10.0, 0.0, 19.0),
                                        child: TextFormField(
                                          controller: _model.passwordController,
                                          focusNode: _model.passwordFocusNode,
                                          onChanged: (_) =>
                                              EasyDebounce.debounce(
                                            '_model.passwordController',
                                            Duration(milliseconds: 2000),
                                            () async {
                                              setState(() {
                                                _model.password = _model
                                                    .passwordController.text;
                                              });
                                            },
                                          ),
                                          autofocus: true,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelStyle: FFTheme.of(context)
                                                .labelMedium
                                                .override(
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.bold,
                                                ),
                                            hintText: 'CONTRASENA',
                                            hintStyle: FFTheme.of(context)
                                                .labelMedium
                                                .override(
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.bold,
                                                ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x56000000),
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FFTheme.of(context).primary,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FFTheme.of(context).error,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FFTheme.of(context).error,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                          ),
                                          style: FFTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Montserrat',
                                                color: FFTheme.of(context)
                                                    .secondaryText,
                                                fontWeight: FontWeight.bold,
                                              ),
                                          validator: _model
                                              .passwordControllerValidator
                                              .asValidator(context),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 1.0,
                                color: Color(0x8A2183D6),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10.0, 0.0, 10.0, 0.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 10.0, 0.0, 10.0),
                                      child: Text(
                                        'Detalles adicionales',
                                        style: FFTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Montserrat',
                                              color: FFTheme.of(context)
                                                  .primaryText,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w800,
                                            ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 10.0, 0.0, 19.0),
                                      child: FFDropDown<String>(
                                        controller: _model
                                                .productStateValueController ??=
                                            FormFieldController<String>(null),
                                        options: [
                                          'Sin abrir con etiquetas',
                                          'Nuevo sin usar',
                                          'En perfecto estado',
                                          'En buen estado',
                                          'Usado y en condiciones aceptables',
                                          'El último respiro'
                                        ],
                                        onChanged: (val) async {
                                          setState(() =>
                                              _model.productStateValue = val);
                                          setState(() {
                                            _model.productState =
                                                _model.productStateValue!;
                                          });
                                        },
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                1.0,
                                        height: 50.0,
                                        textStyle: FFTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Montserrat',
                                              color: FFTheme.of(context)
                                                  .secondaryText,
                                              fontWeight: FontWeight.bold,
                                            ),
                                        hintText: 'ESTADO DEL PRODUCTO',
                                        icon: Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          color:
                                              FFTheme.of(context).secondaryText,
                                          size: 24.0,
                                        ),
                                        fillColor: FFTheme.of(context)
                                            .secondaryBackground,
                                        elevation: 2.0,
                                        borderColor: Color(0x56000000),
                                        borderWidth: 1.0,
                                        borderRadius: 8.0,
                                        margin: EdgeInsetsDirectional.fromSTEB(
                                            16.0, 4.0, 16.0, 4.0),
                                        hidesUnderline: true,
                                        isSearchable: false,
                                        isMultiSelect: false,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 10.0, 0.0, 19.0),
                                      child: TextFormField(
                                        controller:
                                            _model.productPriceController,
                                        focusNode: _model.productPriceFocusNode,
                                        onChanged: (_) => EasyDebounce.debounce(
                                          '_model.productPriceController',
                                          Duration(milliseconds: 2000),
                                          () async {
                                            setState(() {
                                              _model.productPrice = int.parse(
                                                  _model.productPriceController
                                                      .text);
                                            });
                                          },
                                        ),
                                        autofocus: true,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelStyle: FFTheme.of(context)
                                              .labelMedium
                                              .override(
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.bold,
                                              ),
                                          hintText: 'PRECIO DEL PRODUCTO',
                                          hintStyle: FFTheme.of(context)
                                              .labelMedium
                                              .override(
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.bold,
                                              ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x56000000),
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FFTheme.of(context).primary,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: FFTheme.of(context).error,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: FFTheme.of(context).error,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                        style: FFTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Montserrat',
                                              color: FFTheme.of(context)
                                                  .secondaryText,
                                              fontWeight: FontWeight.bold,
                                            ),
                                        keyboardType: TextInputType.number,
                                        validator: _model
                                            .productPriceControllerValidator
                                            .asValidator(context),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 10.0, 0.0, 10.0),
                                      child: FFDropDown<int>(
                                        controller:
                                            _model.weightValueController ??=
                                                FormFieldController<int>(
                                          _model.weightValue ??= 2,
                                        ),
                                        options:
                                            List<int>.from([2, 5, 10, 20, 30]),
                                        optionLabels: [
                                          'HASTA 2 KG ( +9 €)',
                                          'HASTA 5 KG (+12 €)',
                                          'HASTA 10 KG (+16 €)',
                                          'HASTA 20 KG (+29 €)',
                                          'HASTA 30 KG (+44 €)'
                                        ],
                                        onChanged: (val) async {
                                          setState(
                                              () => _model.weightValue = val);
                                          setState(() {
                                            _model.pesoProducto =
                                                _model.weightValue;
                                          });
                                        },
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                1.0,
                                        height: 50.0,
                                        textStyle: FFTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Montserrat',
                                              color: FFTheme.of(context)
                                                  .secondaryText,
                                              fontWeight: FontWeight.bold,
                                            ),
                                        hintText: 'PESO DEL PRODUCTO',
                                        icon: Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          color:
                                              FFTheme.of(context).secondaryText,
                                          size: 24.0,
                                        ),
                                        fillColor: FFTheme.of(context)
                                            .secondaryBackground,
                                        elevation: 2.0,
                                        borderColor: Color(0x56000000),
                                        borderWidth: 1.0,
                                        borderRadius: 8.0,
                                        margin: EdgeInsetsDirectional.fromSTEB(
                                            16.0, 4.0, 16.0, 4.0),
                                        hidesUnderline: true,
                                        isSearchable: false,
                                        isMultiSelect: false,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 1.0,
                                color: Color(0x8A2183D6),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10.0, 0.0, 10.0, 0.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 10.0, 0.0, 10.0),
                                      child: Text(
                                        'Papeletas',
                                        style: FFTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Montserrat',
                                              color: FFTheme.of(context)
                                                  .primaryText,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w800,
                                            ),
                                      ),
                                    ),
                                    if (_model.rifaTypeValue == 'Random')
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 10.0, 0.0, 10.0),
                                        child: TextFormField(
                                          controller:
                                              _model.maxTicketsController,
                                          focusNode: _model.maxTicketsFocusNode,
                                          onChanged: (_) =>
                                              EasyDebounce.debounce(
                                            '_model.maxTicketsController',
                                            Duration(milliseconds: 2000),
                                            () async {
                                              setState(() {
                                                _model.maxTickets = _model
                                                    .maxTicketsController.text;
                                              });
                                            },
                                          ),
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelStyle:
                                                FFTheme.of(context).labelMedium,
                                            hintText: 'CANTIDAD DE PAPELETAS',
                                            hintStyle: FFTheme.of(context)
                                                .labelMedium
                                                .override(
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.bold,
                                                ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: FFTheme.of(context)
                                                    .alternate,
                                                width: 2.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FFTheme.of(context).primary,
                                                width: 2.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FFTheme.of(context).error,
                                                width: 2.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FFTheme.of(context).error,
                                                width: 2.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                          ),
                                          style: FFTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Montserrat',
                                                color: FFTheme.of(context)
                                                    .secondaryText,
                                                fontWeight: FontWeight.bold,
                                              ),
                                          keyboardType: TextInputType.number,
                                          validator: _model
                                              .maxTicketsControllerValidator
                                              .asValidator(context),
                                        ),
                                      ),
                                    if (_model.rifaTypeValue == 'Triple x')
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 10.0, 0.0, 10.0),
                                        child: FFDropDown<String>(
                                          controller: _model
                                                  .dropdownTicketsValueController ??=
                                              FormFieldController<String>(null),
                                          options: ['10', '100', '1000'],
                                          onChanged: (val) async {
                                            setState(() => _model
                                                .dropdownTicketsValue = val);
                                            setState(() {
                                              _model.maxTickets =
                                                  _model.dropdownTicketsValue!;
                                            });
                                          },
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  1.0,
                                          height: 50.0,
                                          textStyle: FFTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Montserrat',
                                                color: FFTheme.of(context)
                                                    .secondaryText,
                                                fontWeight: FontWeight.bold,
                                              ),
                                          hintText: 'SELECCIONE UNA OPCION',
                                          icon: Icon(
                                            Icons.keyboard_arrow_down_rounded,
                                            color: FFTheme.of(context)
                                                .secondaryText,
                                            size: 24.0,
                                          ),
                                          fillColor: FFTheme.of(context)
                                              .secondaryBackground,
                                          elevation: 2.0,
                                          borderColor:
                                              FFTheme.of(context).alternate,
                                          borderWidth: 2.0,
                                          borderRadius: 8.0,
                                          margin:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16.0, 4.0, 16.0, 4.0),
                                          hidesUnderline: true,
                                          isSearchable: false,
                                          isMultiSelect: false,
                                        ),
                                      ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 10.0, 0.0, 10.0),
                                      child: Text(
                                        'PRECIO POR TICKET',
                                        style: FFTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Montserrat',
                                              color: FFTheme.of(context)
                                                  .secondaryText,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ),
                                    Align(
                                      alignment:
                                          AlignmentDirectional(0.00, 0.00),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 10.0, 0.0, 10.0),
                                        child: Container(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  1.0,
                                          height: 48.0,
                                          decoration: BoxDecoration(
                                            color: FFTheme.of(context)
                                                .secondaryBackground,
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            border: Border.all(
                                              color:
                                                  FFTheme.of(context).alternate,
                                              width: 2.0,
                                            ),
                                          ),
                                          child: Align(
                                            alignment: AlignmentDirectional(
                                                -1.00, 0.00),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(5.0, 5.0, 5.0, 5.0),
                                              child: Text(
                                                valueOrDefault<String>(
                                                  functions
                                                      .pricePerTicket(
                                                          valueOrDefault<int>(
                                                            _model.productPrice,
                                                            0,
                                                          ),
                                                          valueOrDefault<
                                                              String>(
                                                            _model.maxTickets,
                                                            '0',
                                                          ))
                                                      .toStringAsFixed(2)
                                                      .replaceAll(".", ","),
                                                  '0',
                                                ),
                                                style: FFTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Montserrat',
                                                      color: FFTheme.of(context)
                                                          .secondaryText,
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (_model.limitTicketsPerUser == true)
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 10.0, 0.0, 10.0),
                                        child: TextFormField(
                                          controller:
                                              _model.ticketsPerUserController,
                                          focusNode:
                                              _model.ticketsPerUserFocusNode,
                                          onChanged: (_) =>
                                              EasyDebounce.debounce(
                                            '_model.ticketsPerUserController',
                                            Duration(milliseconds: 2000),
                                            () async {
                                              setState(() {
                                                _model.maxTicketsPerUser =
                                                    int.parse(_model
                                                        .ticketsPerUserController
                                                        .text);
                                              });
                                            },
                                          ),
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelStyle:
                                                FFTheme.of(context).labelMedium,
                                            hintText: 'TICKETS POR USUARIO',
                                            hintStyle: FFTheme.of(context)
                                                .labelMedium
                                                .override(
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.bold,
                                                ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: FFTheme.of(context)
                                                    .alternate,
                                                width: 2.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FFTheme.of(context).primary,
                                                width: 2.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FFTheme.of(context).error,
                                                width: 2.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FFTheme.of(context).error,
                                                width: 2.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                          ),
                                          style: FFTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Montserrat',
                                                color: FFTheme.of(context)
                                                    .secondaryText,
                                                fontWeight: FontWeight.bold,
                                              ),
                                          keyboardType: TextInputType.number,
                                          validator: _model
                                              .ticketsPerUserControllerValidator
                                              .asValidator(context),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.sizeOf(context).width * 1.0,
                                height: 220.0,
                                decoration: BoxDecoration(
                                  color: Color(0xFFEDEDED),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 15.0, 0.0, 0.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Theme(
                                            data: ThemeData(
                                              checkboxTheme: CheckboxThemeData(
                                                visualDensity:
                                                    VisualDensity.compact,
                                                materialTapTargetSize:
                                                    MaterialTapTargetSize
                                                        .shrinkWrap,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                              ),
                                              unselectedWidgetColor:
                                                  FFTheme.of(context)
                                                      .secondaryText,
                                            ),
                                            child: Checkbox(
                                              value: _model.checkboxValue1 ??=
                                                  false,
                                              onChanged: (newValue) async {
                                                setState(() =>
                                                    _model.checkboxValue1 =
                                                        newValue!);
                                              },
                                              activeColor:
                                                  FFTheme.of(context).primary,
                                              checkColor:
                                                  FFTheme.of(context).info,
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Deseo que participen personas que viven en las Islas canarias.',
                                                  style: FFTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Montserrat',
                                                        fontSize: 14.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 0.0, 0.0, 10.0),
                                                  child: Text(
                                                    'Nota: todos los envios origen o destino a islas Canarias llevan un sobrecoste asumidos por el vendedor/rifador',
                                                    style: FFTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Montserrat',
                                                          color: FFTheme.of(
                                                                  context)
                                                              .secondaryText,
                                                          fontSize: 14.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Theme(
                                            data: ThemeData(
                                              checkboxTheme: CheckboxThemeData(
                                                visualDensity:
                                                    VisualDensity.compact,
                                                materialTapTargetSize:
                                                    MaterialTapTargetSize
                                                        .shrinkWrap,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                              ),
                                              unselectedWidgetColor:
                                                  FFTheme.of(context)
                                                      .secondaryText,
                                            ),
                                            child: Checkbox(
                                              value: _model.checkboxValue2 ??=
                                                  _model.limitTicketsPerUser,
                                              onChanged: (newValue) async {
                                                setState(() =>
                                                    _model.checkboxValue2 =
                                                        newValue!);
                                                if (newValue!) {
                                                  setState(() {
                                                    _model.limitTicketsPerUser =
                                                        true;
                                                  });
                                                } else {
                                                  setState(() {
                                                    _model.limitTicketsPerUser =
                                                        false;
                                                  });
                                                }
                                              },
                                              activeColor:
                                                  FFTheme.of(context).primary,
                                              checkColor:
                                                  FFTheme.of(context).info,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 10.0, 0.0, 10.0),
                                            child: Text(
                                              'Deseo limitar las papeletas por usuario',
                                              style: FFTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Montserrat',
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Theme(
                                            data: ThemeData(
                                              checkboxTheme: CheckboxThemeData(
                                                visualDensity:
                                                    VisualDensity.compact,
                                                materialTapTargetSize:
                                                    MaterialTapTargetSize
                                                        .shrinkWrap,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                              ),
                                              unselectedWidgetColor:
                                                  FFTheme.of(context)
                                                      .secondaryText,
                                            ),
                                            child: Checkbox(
                                              value: _model.checkboxValue3 ??=
                                                  false,
                                              onChanged: (newValue) async {
                                                setState(() =>
                                                    _model.checkboxValue3 =
                                                        newValue!);
                                              },
                                              activeColor:
                                                  FFTheme.of(context).primary,
                                              checkColor:
                                                  FFTheme.of(context).info,
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 10.0, 0.0, 10.0),
                                              child: Text(
                                                'Acepto los terminos y condiciones y la politica de privacidad',
                                                style: FFTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Montserrat',
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Material(
                                color: Colors.transparent,
                                elevation: 3.0,
                                child: Container(
                                  width: MediaQuery.sizeOf(context).width * 1.0,
                                  height: 100.0,
                                  decoration: BoxDecoration(
                                    color:
                                        FFTheme.of(context).secondaryBackground,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 4.0,
                                        color: Color(0x33000000),
                                        offset: Offset(0.0, 2.0),
                                      )
                                    ],
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10.0, 0.0, 10.0, 0.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        FFButtonWidget(
                                          onPressed: () async {
                                            if (_model.formKey.currentState ==
                                                    null ||
                                                !_model.formKey.currentState!
                                                    .validate()) {
                                              return;
                                            }
                                            if (_model.categoryValue == null) {
                                              return;
                                            }
                                            await Future.delayed(const Duration(
                                                milliseconds: 1000));
                                            _model.apiResultjey =
                                                await CreateProductCall.call(
                                              name: _model.name,
                                              description: _model.description,
                                              price: _model.productPrice
                                                  .toString(),
                                              category: _model.category,
                                              type: _model.type,
                                              rifaType: _model.rifaType,
                                              author: getJsonField(
                                                FFAppState().jwtuser,
                                                r'''$.ID''',
                                              ),
                                              imagesList: _model.files,
                                              maxTickets: _model.maxTickets,
                                              pesoProducto: _model.pesoProducto
                                                  ?.toString(),
                                              lotteryPrice: functions
                                                  .pricePerTicket(
                                                      _model.productPrice,
                                                      _model.maxTickets)
                                                  .toString(),
                                              productState: _model.productState,
                                            );
                                            if ((_model
                                                    .apiResultjey?.succeeded ??
                                                true)) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'Producto creado con exito',
                                                    style: TextStyle(
                                                      color: FFTheme.of(context)
                                                          .primaryText,
                                                    ),
                                                  ),
                                                  duration: Duration(
                                                      milliseconds: 4000),
                                                  backgroundColor:
                                                      FFTheme.of(context)
                                                          .secondary,
                                                ),
                                              );

                                              context.pushNamed(
                                                  'LoteryCreatedPage');
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'Hubo un error, revisa los campos nuevamente',
                                                    style: TextStyle(
                                                      color: FFTheme.of(context)
                                                          .primaryText,
                                                    ),
                                                  ),
                                                  duration: Duration(
                                                      milliseconds: 4000),
                                                  backgroundColor:
                                                      FFTheme.of(context).error,
                                                ),
                                              );
                                            }

                                            setState(() {});
                                          },
                                          text: 'AGREGAR RIFA',
                                          options: FFButtonOptions(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.8,
                                            height: 60.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    24.0, 0.0, 24.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: FFTheme.of(context).primary,
                                            textStyle: FFTheme.of(context)
                                                .titleSmall
                                                .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                            elevation: 0.0,
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.00, -1.00),
                child: wrapWithModel(
                  model: _model.secondaaryHeaderComponentModel,
                  updateCallback: () => setState(() {}),
                  child: SecondaaryHeaderComponentWidget(
                    title: 'Subir producto',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
