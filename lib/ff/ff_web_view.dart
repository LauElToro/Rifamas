import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'ff_util.dart';

class FFWebView extends StatefulWidget {
  const FFWebView({
    Key? key,
    required this.content,
    this.width,
    this.height,
    this.bypass = false,
    this.horizontalScroll = false,
    this.verticalScroll = false,
    this.redirectUrl = "",
    this.html = false,

  }) : super(key: key);

  final String content;
  final double? height;
  final double? width;
  final String redirectUrl;
  final bool bypass;
  final bool horizontalScroll;
  final bool verticalScroll;
  final bool html;

  @override
  _FFWebViewState createState() => _FFWebViewState();
}

class _FFWebViewState extends State<FFWebView> {
  @override
  Widget build(BuildContext context) => WebViewX(
        key: webviewKey,
        width: widget.width ?? MediaQuery.sizeOf(context).width,
        height: widget.height ?? MediaQuery.sizeOf(context).height,
        ignoreAllGestures: false,
        initialContent: widget.content,
        initialMediaPlaybackPolicy:
            AutoMediaPlaybackPolicy.requireUserActionForAllMediaTypes,
        initialSourceType: widget.html
            ? SourceType.html
            : widget.bypass
                ? SourceType.urlBypass
                : SourceType.url,
        javascriptMode: JavascriptMode.unrestricted,
        navigationDelegate: (request) async {
          if (isAndroid) {
          String url = request.content.source;
          if (url.contains('order-received')) {
          //context.pushNamed('loteryCreatedPage');
            if(widget.redirectUrl == 'membership'){
             context.pushNamed('firstCreatePage');
            }else if(widget.redirectUrl =='product') {
            context.pushNamed('loteryCreatedPage');
          } else {
            context.pushNamed('firstCreatePage');
          }
           // Aquí puedes poner el código que quieras ejecutar si la URL contiene 'order-received'
          }

          }
          return NavigationDecision.navigate;
        },
        webSpecificParams: const WebSpecificParams(
          webAllowFullscreenContent: true,
        ),
        mobileSpecificParams: MobileSpecificParams(
          debuggingEnabled: false,
          gestureNavigationEnabled: true,
          mobileGestureRecognizers: {
            if (widget.verticalScroll)
              Factory<VerticalDragGestureRecognizer>(
                () => VerticalDragGestureRecognizer(),
              ),
            if (widget.horizontalScroll)
              Factory<HorizontalDragGestureRecognizer>(
                () => HorizontalDragGestureRecognizer(),
              ),
          },
          androidEnableHybridComposition: true,
        ),
      );

  Key get webviewKey => Key(
        [
          widget.content,
          widget.width,
          widget.height,
          widget.bypass,
          widget.horizontalScroll,
          widget.verticalScroll,
          widget.html,
        ].map((s) => s?.toString() ?? '').join(),
      );
}
