import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Politique extends StatefulWidget {
  @override
  State<Politique> createState() => _PolitiqueState();
}

class _PolitiqueState extends State<Politique> {
  final title = "Politique de confidentialité";
  late WebViewController controller;

  void loadLocalHtml() async {
    final html =
        await rootBundle.loadString('samples/BrowsingPois/html/politique.html');
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
