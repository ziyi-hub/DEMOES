import 'package:flutter/material.dart';

class IntroductionPrt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Image.asset(
                'assets/image/intro2.jpg',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.cover,
                colorBlendMode: BlendMode.modulate,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.5,
                  decoration: new BoxDecoration(
                    color: Color.fromRGBO(0, 0, 0, 0.7),
                    borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(40.0),
                      topRight: const Radius.circular(40.0),
                    ),
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
                              'Contexte du projet',
                              style:
                                  TextStyle(fontSize: 40, color: Colors.white),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 20.0,
                              ),
                            ),
                            Text(
                              "Lancement du projet PLEIADES porté par l'Université de Lorraine, avec la participation du Crem. L'objectif est d'enrichissement des apprentissages par l’usage d’environnement immersif et de réalité virtuelle et un renforcement de la plateforme de cours.",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: 40.0,
                              ),
                            ),
                            ButtonBar(
                              alignment: MainAxisAlignment.center,
                              children: <Widget>[
                                /* Bouton de NEXT */
                                new SizedBox(
                                  width: 125.0,
                                  height: 50.0,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        '/accueil',
                                      );
                                    },
                                    child: Text(
                                      "Suivant",
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.1),
                                /* Bouton de SKIP */
                                new SizedBox(
                                  width: 125.0,
                                  height: 50.0,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.transparent),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            side:
                                                BorderSide(color: Colors.blue)),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        '/introduction',
                                      );
                                    },
                                    child: Text(
                                      "Précédent",
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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
        ),
      ),
    );
  }
}
