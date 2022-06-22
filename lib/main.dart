// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_wiki_2/components/wikitude/main_menu.dart';
import 'package:flutter_wiki_2/components/introduction/introduction_app.dart';
import 'package:flutter_wiki_2/components/accueil/accueil.dart';
import 'package:flutter_wiki_2/components/introduction/introduction_prt.dart';
import 'package:flutter_wiki_2/components/propos/propos.dart';
import 'package:flutter_wiki_2/components/listeUL/listeUL.dart';
import 'package:flutter_wiki_2/components/propos/detailUL.dart';
import 'package:flutter_wiki_2/components/propos/detailCL.dart';
import 'package:flutter_wiki_2/components/propos/detailDEMOES.dart';
import 'package:flutter_wiki_2/components/parametre/parametre.dart';
import 'package:flutter_wiki_2/components/parametre/DarkThemeProvider.dart';
import 'package:flutter_wiki_2/components/parametre/styles.dart';
import 'package:flutter_wiki_2/components/parametre/logicielTiers.dart';
import 'package:flutter_wiki_2/components/parametre/condition.dart';
import 'package:flutter_wiki_2/components/parametre/reglement.dart';
import 'package:flutter_wiki_2/components/parametre/politique.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = new DarkThemeProvider();

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        return themeChangeProvider;
      },
      child: Consumer<DarkThemeProvider>(
        builder: (BuildContext context, value, Widget child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'DEMOES',
            theme: Styles.themeData(themeChangeProvider.darkTheme, context),
            home: IntroductionApp(),
            // When navigating to the "/" route, build the mainmenu widget.
            initialRoute: '/',
            routes: {
              // When navigating to the "/camera" route, build the camera widget.
              '/camera': (context) => MainMenu(),
              // When navigating to the "/introduction" route, build the introduction widget.
              '/introduction': (context) => IntroductionApp(),
              // When navigating to the "/introduction" route, build the accueil widget.
              '/accueil': (context) => Accueil(),
              // When navigating to the "/intro_projet" route, build the introduction widget.
              '/intro_projet': (context) => IntroductionPrt(),
              // When navigating to the "/propos" route, build the à propos widget.
              '/propos': (context) => Propos(),
              // When navigating to the "/liste_ul" route, build the liste d'Université Lorraine widget.
              '/liste_ul': (context) => listeUL(),
              // When navigating to the "/intro_projet" route, build the détail d'Université Lorraine widget.
              '/propos_ul': (context) => DetailUL(),
              // When navigating to the "/propos_cl" route, build the détail de CharlyLab widget.
              '/propos_cl': (context) => DetailCL(),
              // When navigating to the "/propos_demoes" route, build the détail de projet widget.
              '/propos_demoes': (context) => DetailDEMOES(),
              // When navigating to the "/param" route, build the paramètre de projet widget.
              '/param': (context) => Parametre(),
              // When navigating to the "/logiciel_tiers" route, build the détail de projet widget.
              '/logiciel_tiers': (context) => LogicielTiers(),
              // When navigating to the "/conditions" route, build the détail de projet widget.
              '/conditions': (context) => Conditions(),
              // When navigating to the "/reglement" route, build the règlement de projet widget.
              '/reglement': (context) => Reglement(),
              // When navigating to the "/politique" route, build the politique de projet widget.
              '/politique': (context) => Politique(),
            },
          );
        },
      ),
    );
  }
}
