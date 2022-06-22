import 'package:flutter/material.dart';
//import 'package:flutter_wiki_2/datas/accueil.dart';
import 'package:flutter_wiki_2/datas/listeUL.dart';
import 'package:flutter_wiki_2/components/wikitude/poiDetails.dart';

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({
    required this.choice,
    required this.item,
  });

  final Map<String, Object> choice;
  final dynamic item;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.network(
              choice["image"].toString(),
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width * 0.6,
              fit: BoxFit.cover,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (itemCount) => PoiDetailsWidget(
                      id: choice["id"] as int,
                      title: choice["name"].toString(),
                      description: choice["description"].toString(),
                      adresse: choice["adresse"].toString(),
                      latitude: (choice["latitude"] as num).toDouble(),
                      longitude: (choice["longitude"] as num).toDouble(),
                      site: choice["site"].toString(),
                      carousel: choice["carousel"] as List<dynamic>),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, 0.5),
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height * 0.25,
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                      ),
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Text(
                              choice["name"].toString(),
                              style:
                                  TextStyle(fontSize: 25, color: Colors.white),
                            ),
                            Text(
                              choice["adresse"].toString(),
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
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
          ),
        ],
      ),
    );
  }
}
