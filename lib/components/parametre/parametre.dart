import 'package:flutter/material.dart';
import 'package:flutter_wiki_2/components/navBar/navBarHome.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter/cupertino.dart';

import 'package:flutter_wiki_2/components/parametre/DarkThemeProvider.dart';
import 'package:provider/provider.dart';

class Parametre extends StatefulWidget {
  @override
  State<Parametre> createState() => _ParametreState();
}

class _ParametreState extends State<Parametre> {
  var index = 3;

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètre'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text("Style"),
            trailing: Icon(themeChange.darkTheme == true
                ? CupertinoIcons.moon_stars
                : CupertinoIcons.sun_max),
            onTap: () {
              setState(() {
                themeChange.darkTheme = !themeChange.darkTheme;
              });
            },
          ),
          ListTile(
            title: Text("Logiciel tiers"),
            trailing: Icon(Icons.chevron_right_rounded),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/logiciel_tiers',
              );
            },
          ),
          ListTile(
            title: Text("Condition d'utilisation"),
            trailing: Icon(Icons.chevron_right_rounded),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/conditions',
              );
            },
          ),
          ListTile(
            title: Text("Politique de confidentialité"),
            trailing: Icon(Icons.chevron_right_rounded),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/politique',
              );
            },
          ),
          ListTile(
            title: Text("Afficher le règlement de la plateform"),
            trailing: Icon(Icons.chevron_right_rounded),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/reglement',
              );
            },
          ),
        ],
      ),
      /*ListTile(
        title: Text("Sombre"),
        trailing: Checkbox(
          value: themeChange.darkTheme,
          onChanged: (bool? value) {
            setState(() {
              themeChange.darkTheme = value!;
            });
          },
        ),
      ),*/
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
