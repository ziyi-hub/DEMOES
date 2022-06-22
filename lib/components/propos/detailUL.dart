import 'package:flutter/material.dart';
import 'package:flutter_wiki_2/components/navBar/navBarHome.dart';

class DetailUL extends StatefulWidget {
  @override
  State<DetailUL> createState() => _DetailULState();
}

class _DetailULState extends State<DetailUL> {
  var index = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détail UL'),
      ),
      body: Container(
        child: Center(
          child: Container(
            decoration: new BoxDecoration(
              color: Color.fromRGBO(255, 251, 250, 1),
            ),
            child: Padding(
              padding: EdgeInsets.all(0),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    /* Titre */
                    Padding(
                      padding: EdgeInsets.all(25),
                      child: Text(
                        'Université de Lorraine',
                        style: TextStyle(fontSize: 40, color: Colors.black),
                      ),
                    ),
                    /* padding */
                    Padding(
                      padding: EdgeInsets.all(25),
                      child: Text(
                        "L'université de Lorraine est une université française remontant à 1572, année de la fondation de l'université de Pont-à-Mousson, qui est transférée en 1769 à Nancy et rétablie en 1852. Juridiquement, elle a le statut de grand établissement.",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromRGBO(102, 78, 77, 1),
                        ),
                      ),
                    ),
                    /* premier page */
                    Stack(
                      children: <Widget>[
                        Image.asset(
                          'assets/image/propos_detail_ul.jpg',
                          fit: BoxFit.cover,
                          colorBlendMode: BlendMode.modulate,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Container(
                            decoration: new BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 0.8),
                            ),
                            child: Stack(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 20.0,
                                    right: 20.0,
                                    top: 40.0,
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        "Pont-à-Mousson ancienne université jésuite",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    /* padding */
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "Institution à l'histoire mouvementée, l'université de Lorraine est plusieurs fois supprimée et restaurée après la Révolution française, et scindée par la loi Faure après Mai 1968. À partir de 2005, les établissements d'enseignement supérieur de Lorraine (notamment les universités Nancy I et II, et l'université Paul-Verlaine de Metz) entament un processus de fusion, débouchant le 1er janvier 2012 sur l'actuelle université de Lorraine.",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromRGBO(102, 78, 77, 1),
                        ),
                      ),
                    ),
                    /* deuxieme image */
                    Stack(
                      children: <Widget>[
                        Image.asset(
                          'assets/image/propos_detail_ul_2.jpg',
                          fit: BoxFit.cover,
                          colorBlendMode: BlendMode.modulate,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Container(
                            decoration: new BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 0.8),
                            ),
                            child: Stack(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 20.0,
                                    right: 20.0,
                                    top: 40.0,
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        "L'IUT NANCY-CHARLEMAGNE",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
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
