import 'package:flutter/material.dart';
import 'package:ff_navigation_bar_lts/ff_navigation_bar_lts.dart';
import 'package:flip_box_bar_plus/flip_box_bar_plus.dart';
import 'package:flutter_wiki_2/components/wikitude/poiDetails.dart';

class FlipBoxBar extends StatelessWidget {
  final int selectedIndex;
  final int id;
  final String title;
  final String description;
  final String adresse;
  final double latitude;
  final double longitude;
  final String site;
  final List<dynamic> carousel;

  FlipBoxBar({
    required this.selectedIndex,
    required this.id,
    required this.title,
    required this.description,
    required this.adresse,
    required this.latitude,
    required this.longitude,
    required this.site,
    required this.carousel,
  });

  @override
  Widget build(BuildContext context) {
    return FlipBoxBarPlus(
      selectedIndex: selectedIndex,
      onIndexChanged: (newIndex) {
        switch (newIndex) {
          case 0:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PoiDetailsWidget(
                  id: id,
                  title: title,
                  description: description,
                  adresse: adresse,
                  latitude: (latitude as num).toDouble(),
                  longitude: (longitude as num).toDouble(),
                  site: site,
                  carousel: carousel,
                ),
              ),
            );
            break;
          case 1:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PoiDetailsWidget_Info(
                  id: id,
                  title: title,
                  description: description,
                  adresse: adresse,
                  latitude: (latitude as num).toDouble(),
                  longitude: (longitude as num).toDouble(),
                  site: site,
                  carousel: carousel,
                ),
              ),
            );
            break;
        }
      },
      items: [
        FlipBarItem(
            icon: Icon(Icons.map),
            text: Text("Carte"),
            frontColor: Colors.blue,
            backColor: Colors.blueAccent),
        FlipBarItem(
            icon: Icon(Icons.info),
            text: Text("Info détaillé"),
            frontColor: Colors.cyan,
            backColor: Colors.cyanAccent),
      ],
    );
  }
}
