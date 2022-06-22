import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wiki_2/components/navBar/navBarHome.dart';
import 'package:flutter_wiki_2/components/wikitude/customUrl.dart';

import 'arview.dart';
import 'category.dart';
import 'custom_expansion_tile.dart';
import 'sample.dart';

import 'package:augmented_reality_plugin_wikitude/wikitude_plugin.dart';
import 'package:augmented_reality_plugin_wikitude/wikitude_sdk_build_information.dart';
import 'package:augmented_reality_plugin_wikitude/wikitude_response.dart';

Future<String> _loadSamplesJson() async {
  return await rootBundle.loadString('samples/samples.json');
}

Future<List<Category>> _loadSamples() async {
  String samplesJson = await _loadSamplesJson();
  List<dynamic> categoriesFromJson = json.decode(samplesJson);
  List<Category> categories = [];

  for (int i = 0; i < categoriesFromJson.length; i++) {
    categories.add(new Category.fromJson(categoriesFromJson[i]));
  }
  return categories;
}

class MainMenu extends StatefulWidget {
  @override
  MyAppState createState() => new MyAppState();
}

class MyAppState extends State<MainMenu> {
  var index = 3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Radar'),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: popupMenuSelectedItem,
            itemBuilder: (BuildContext context) {
              return PopupMenuItems.items.map((String item) {
                return PopupMenuItem<String>(value: item, child: Text(item));
              }).toList();
            },
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(color: Color(0xffdddddd)),
        child: Padding(
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          child: FutureBuilder(
            future: _loadSamples(),
            builder: (context, AsyncSnapshot<List<Category>> snapshot) {
              if (snapshot.hasData) {
                return Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: CategoryExpansionTile(
                    categories: snapshot.data!,
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation
          .centerDocked, //specify the location of the FAB
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            Navigator.pushNamed(
                context, "/camera"); //to update the animated container
          });
        },
        tooltip: "Réalité augmentée",
        child: Container(
          margin: EdgeInsets.all(15.0),
          child: Icon(Icons.threed_rotation),
        ),
        elevation: 5.0,
      ),
      bottomNavigationBar: HomeNavBar(
        index: 4,
      ),
    );
  }

  void popupMenuSelectedItem(String item) {
    switch (item) {
      case PopupMenuItems.customUrlLauncher:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CustomUrl()),
        );
        break;
      case PopupMenuItems.sdkBuildInformation:
        _getSDKInfo();
        break;
    }
  }

  Future<void> _getSDKInfo() async {
    String sdkVersion = await WikitudePlugin.getSDKVersion();
    WikitudeSDKBuildInformation sdkBuildInformation =
        await WikitudePlugin.getSDKBuildInformation();
    String flutterVersion = "2.8.1";

    String message =
        "Build configuration: ${sdkBuildInformation.buildConfiguration}\nBuild date: ${sdkBuildInformation.buildDate}\nBuild number: ${sdkBuildInformation.buildNumber}\nBuild version: $sdkVersion\nFlutter version: $flutterVersion";
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("SDK information"),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}

class CategoryExpansionTile extends StatefulWidget {
  final List<Category> categories;
  CategoryExpansionTile({
    Key? key,
    required this.categories,
  }) : super(key: key);

  @override
  CategoryExpansionTileState createState() => new CategoryExpansionTileState();
}

class CategoryExpansionTileState extends State<CategoryExpansionTile> {
  List<String> features = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _isDeviceSupporting(features),
      builder: (context, AsyncSnapshot<WikitudeResponse> snapshot) {
        if (snapshot.hasData) {
          /*return Container(
            decoration: BoxDecoration(
                color: snapshot.data!.success ? Colors.white : Colors.grey),
            child: ListTile(
              title: Text(widget.categories[0].samples[0].name),
              onTap: () => snapshot.data!.success
                  ? _pushArView(widget.categories[0].samples[0])
                  : _showDialog(
                      "Device missing features", snapshot.data!.message),
            ),
          );*/
          return ArViewWidget(sample: widget.categories[0].samples[0]);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  List<Widget> createSamplesTileList(List<Sample> samples) {
    List<Widget> tileList = [];

    for (int i = 0; i < samples.length; i++) {
      Sample sample = samples[i];
      List<String> features = [];
      for (int j = 0; j < sample.requiredFeatures.length; j++) {
        features.add(sample.requiredFeatures[j]);
      }

      tileList.add(
        FutureBuilder(
          future: _isDeviceSupporting(features),
          builder: (context, AsyncSnapshot<WikitudeResponse> snapshot) {
            if (snapshot.hasData) {
              return Container(
                  decoration: BoxDecoration(
                      color:
                          snapshot.data!.success ? Colors.white : Colors.grey),
                  child: ListTile(
                    title: Text(sample.name),
                    onTap: () => snapshot.data!.success
                        ? _pushArView(sample)
                        : _showDialog(
                            "Device missing features", snapshot.data!.message),
                  ));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      );
    }

    return tileList;
  }

  Future<WikitudeResponse> _isDeviceSupporting(List<String> features) async {
    return await WikitudePlugin.isDeviceSupporting(features);
  }

  Future<WikitudeResponse> _requestARPermissions(List<String> features) async {
    return await WikitudePlugin.requestARPermissions(features);
  }

  Future<void> _pushArView(Sample sample) async {
    WikitudeResponse permissionsResponse =
        await _requestARPermissions(sample.requiredFeatures);
    if (permissionsResponse.success) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ArViewWidget(sample: sample)),
      );
    } else {
      _showPermissionError(permissionsResponse.message);
    }
  }

  void _showDialog(String title, String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void _showPermissionError(String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Permissions required"),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Open settings'),
                onPressed: () {
                  Navigator.of(context).pop();
                  WikitudePlugin.openAppSettings();
                },
              )
            ],
          );
        });
  }
}

class PopupMenuItems {
  static const String customUrlLauncher = "Custom URL Launcher";
  static const String sdkBuildInformation = "SDK Build Information";

  static const List<String> items = <String>[
    customUrlLauncher,
    sdkBuildInformation
  ];
}
