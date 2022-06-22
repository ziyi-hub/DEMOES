import 'package:flutter/material.dart';
import 'package:flutter_wiki_2/components/navBar/navBarHome.dart';

class DetailDEMOES extends StatefulWidget {
  @override
  State<DetailDEMOES> createState() => _DetailDEMOESState();
}

class _DetailDEMOESState extends State<DetailDEMOES> {
  var index = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détail DEMOES'),
      ),
      body: Container(
        child: Center(
          child: Container(
            child: Padding(
              padding: EdgeInsets.all(0),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    /* Titre */
                    Padding(
                      padding: EdgeInsets.all(25),
                      child: Text(
                        'Projet PLEIADES',
                        style: TextStyle(fontSize: 40, color: Colors.black),
                      ),
                    ),
                    /* padding */
                    Padding(
                      padding: EdgeInsets.all(25),
                      child: Text(
                        "L’Université de Lorraine, avec son projet PLEIADES - Projet Lorrain d’Environnement numérIque pour des Apprentissages DurablES, fait partie des lauréats de l’appel à manifestation d’intérêt (AMI) Demoes (Démonstrateurs numériques dans l’enseignement supérieur). Les lauréats vont bénéficier d’une enveloppe de 100 M€ (dont 5,25 M€ pour PLEIADES) pour déployer des outils de transformation numérique au service de l’enseignement. Au total, se sont 17 projets retenus qui concernent 400 000 étudiants.",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromRGBO(102, 78, 77, 1),
                        ),
                      ),
                    ),
                    Stack(
                      children: <Widget>[
                        Image.asset(
                          'assets/image/propos_detail_demoes.jpg',
                          fit: BoxFit.cover,
                          colorBlendMode: BlendMode.modulate,
                        ),
                      ],
                    ),

                    /* padding */
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "Afin de soutenir leur transformation numérique, l’Etat a décidé d’accompagner un ensemble d’établissements représentatifs de la diversité de l’enseignement supérieur français, dans toutes ses dimensions. Il s’agit d’y expérimenter en vraie grandeur et dans une nouvelle approche globale, toutes les dimensions de la transformation numérique.",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromRGBO(102, 78, 77, 1),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      /*bottomNavigationBar: HomeNavBar(
        index: index,
        callback: (newIndex) => setState(
          () => {
            this.index = newIndex,
          },
        ),
      ),*/
    );
  }
}
