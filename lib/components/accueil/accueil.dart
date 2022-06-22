import 'package:flutter/material.dart';
import 'package:flutter_wiki_2/components/navBar/navBarHome.dart';
import 'package:flutter_wiki_2/components/accueil/rowScroll.dart';

class Accueil extends StatefulWidget {
  @override
  createState() => AccueilState();
}

class AccueilState extends State<Accueil> {
  int index = 0;
  final title = "Accueil";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: RowScroll(),
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
        index: index,
      ),
    );
  }
}
