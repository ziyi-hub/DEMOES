import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';
import 'applicationModelPois.dart';
import 'package:flutter_wiki_2/models/poi.dart';

import 'sample.dart';

import 'package:path_provider/path_provider.dart';

import 'package:augmented_reality_plugin_wikitude/architect_widget.dart';
import 'package:augmented_reality_plugin_wikitude/wikitude_response.dart';
import 'package:flutter_wiki_2/components/wikitude/poiDetails.dart';

class ArViewState extends State<ArViewWidget> with WidgetsBindingObserver {
  late ArchitectWidget architectWidget;
  String wikitudeTrialLicenseKey =
      "1E5CtdUBvm0gs9CDtGIxkwNc6YULJKiXgdrgryYr5HdCor4o6BKewcBgSfwK8L9DB/PsBCX9EwaHpM6s+QuuundETzjlqN+RbLuU9H0rSssvMDeuMUBxCF99+w7yla2eiTV8y5p+zgDMTdLbVh3b4D7bRdCpmCVxGqauevMaIDtTYWx0ZWRfX6vl9/P8MivuVAgJVFy8WCa3kyHEiteelQHUY1A0wFv6/EytXFC+PMCZgdU37Qi7RdbQGk+zi5Vt7F+8z83t8aIJq9gu4kuwrAfJryUderSznT88DMNDEh+wo2AHbtR6c70KuePIg655m0wxHb8SMOFm8RlmgiDjsuRsAoLWi16YdxfUs68f32wlNDPQt79fb0B0IIVq5zu+eDh0xzzkjGv4YBasM+voIco06t9SPBoaWlIXLxKp0cnvAq+4sJ4T3a+2j9EtENmFb1IBhSl6ni9nOCVIAOjPQmTU8tETZsb96MHSVwEvKEiFpPKrD73xEjDSsB3RT4ZouECK9PYNY4bIVWVdtbIPbjoNsotvA82a8FD2r1xSfaWhOMRvm17WPDlcVCnInm8HJa7oFWaSmanEgBJfkc+fCNgPUJ0VzROAn8acjClgxk92n0kS51OrstDKTOFJE6mlVZ028goJuW71TTPF/bwvP3swkCv9CVjWnjMN5i3r2CzKdcdIAkdMPv7SOCxYd5C6fblLHSnJNg1g+B0HuM/hnvMnHwcKYjktXiQklJdPBksuRM+48pMrzEGxwhsP+l+ttml9oKpuQkvn8SdkR/h+Y5Fcm2pg+Nj7STx2VUV/4IdoJfhwWIn2B6+ueQQF3ZlU/Cz5Jte/XP9/kAGOlL4aObB+0Ou0lLNF6NowFXkDDoA=";
  Sample sample;
  String loadPath = "";
  bool loadFailed = false;

  ArViewState({required this.sample}) {
    if (this.sample.path.contains("http://") ||
        this.sample.path.contains("https://")) {
      loadPath = this.sample.path;
    } else {
      loadPath = "samples/" + this.sample.path;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);

    architectWidget = new ArchitectWidget(
      onArchitectWidgetCreated: onArchitectWidgetCreated,
      licenseKey: wikitudeTrialLicenseKey,
      startupConfiguration: sample.startupConfiguration,
      features: sample.requiredFeatures,
    );

    Wakelock.enable();
  }

  @override
  void dispose() {
    this.architectWidget.pause();
    this.architectWidget.destroy();
    WidgetsBinding.instance!.removeObserver(this);

    Wakelock.disable();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        this.architectWidget.pause();
        break;
      case AppLifecycleState.resumed:
        this.architectWidget.resume();
        break;

      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    /*return Scaffold(
      appBar: AppBar(title: Text(sample.name)),
      body: WillPopScope(
        onWillPop: () async {
          if (defaultTargetPlatform == TargetPlatform.android && !loadFailed) {
            bool? canWebViewGoBack =
                await this.architectWidget.canWebViewGoBack();
            if (canWebViewGoBack != null) {
              return !canWebViewGoBack;
            } else {
              return true;
            }
          } else {
            return true;
          }
        },
        child: Container(
            decoration: BoxDecoration(color: Colors.black),
            child: architectWidget),
      ),
    );*/
    return WillPopScope(
      onWillPop: () async {
        if (defaultTargetPlatform == TargetPlatform.android && !loadFailed) {
          bool? canWebViewGoBack =
              await this.architectWidget.canWebViewGoBack();
          if (canWebViewGoBack != null) {
            return !canWebViewGoBack;
          } else {
            return true;
          }
        } else {
          return true;
        }
      },
      child: Container(
          decoration: BoxDecoration(color: Colors.black),
          child: architectWidget),
    );
  }

  Future<void> onArchitectWidgetCreated() async {
    this.architectWidget.load(loadPath, onLoadSuccess, onLoadFailed);
    this.architectWidget.resume();

    if (sample.requiredExtensions.contains("application_model_pois")) {
      List<Poi> pois = await ApplicationModelPois.prepareApplicationDataModel();
      this.architectWidget.callJavascript(
          "World.loadPoisFromJsonData(" + jsonEncode(pois) + ");");
    }

    if ((sample.requiredExtensions.contains("screenshot") ||
        sample.requiredExtensions.contains("save_load_instant_target") ||
        sample.requiredExtensions.contains("native_detail"))) {
      this.architectWidget.setJSONObjectReceivedCallback(onJSONObjectReceived);
    }
  }

  Future<void> onJSONObjectReceived(Map<String, dynamic> jsonObject) async {
    if (jsonObject["action"] != null) {
      switch (jsonObject["action"]) {
        case "capture_screen":
          captureScreen();
          break;
        case "present_poi_details":
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PoiDetailsWidget(
                id: jsonObject["id"],
                title: jsonObject["title"],
                description: jsonObject["description"],
                adresse: jsonObject["adresse"],
                latitude: jsonObject["latitude"],
                longitude: jsonObject["longitude"],
                site: jsonObject["site"],
                carousel: jsonObject["carousel"],
              ),
            ),
          );
          break;
        case "save_current_instant_target":
          final fileDirectory = await getApplicationDocumentsDirectory();
          final filePath = fileDirectory.path;
          final file = File('$filePath/SavedAugmentations.json');
          file.writeAsString(jsonObject["augmentations"]);
          this.architectWidget.callJavascript(
              "World.saveCurrentInstantTargetToUrl(\"" +
                  filePath +
                  "/SavedInstantTarget.wto" +
                  "\");");
          break;
        case "load_existing_instant_target":
          final fileDirectory = await getApplicationDocumentsDirectory();
          final filePath = fileDirectory.path;
          final file = File('$filePath/SavedAugmentations.json');
          String augmentations;
          try {
            augmentations = await file.readAsString();
          } catch (e) {
            augmentations = "null";
          }
          this.architectWidget.callJavascript(
              "World.loadExistingInstantTargetFromUrl(\"" +
                  filePath +
                  "/SavedInstantTarget.wto" +
                  "\"," +
                  augmentations +
                  ");");
          break;
      }
    }
  }

  Future<void> captureScreen() async {
    WikitudeResponse captureScreenResponse =
        await this.architectWidget.captureScreen(true, "");
    if (captureScreenResponse.success) {
      this.architectWidget.showAlert(
          "Success", "Image saved in: " + captureScreenResponse.message);
    } else {
      if (captureScreenResponse.message.contains("permission")) {
        this
            .architectWidget
            .showAlert("Error", captureScreenResponse.message, true);
      } else {
        this.architectWidget.showAlert("Error", captureScreenResponse.message);
      }
    }
  }

  Future<void> onLoadSuccess() async {
    loadFailed = false;
  }

  Future<void> onLoadFailed(String error) async {
    loadFailed = true;
    this.architectWidget.showAlert("Failed to load Architect World", error);
  }
}

class ArViewWidget extends StatefulWidget {
  final Sample sample;

  ArViewWidget({
    Key? key,
    required this.sample,
  });

  @override
  ArViewState createState() => new ArViewState(sample: sample);
}
