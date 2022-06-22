import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Reglement extends StatefulWidget {
  @override
  State<Reglement> createState() => _ReglementState();
}

class _ReglementState extends State<Reglement> {
  final title = "Règlement de la plateforme";
  late WebViewController controller;

  void loadLocalHtml() async {
    final html =
        await rootBundle.loadString('samples/BrowsingPois/html/reglement.html');
    final url = Uri.dataFromString(
      html,
      mimeType: "text/html",
      encoding: Encoding.getByName('utf-8'),
    ).toString();
    controller.loadUrl(url);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: WebView(
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (controller) {
            this.controller = controller;

            loadLocalHtml();
          },
        ),
      );
}
