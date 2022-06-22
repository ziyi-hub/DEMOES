import 'package:flutter/material.dart';

class IntroductionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              /*Image.network(
                "https://drive.google.com/uc?export=view&id=16F4obgtPFgjDUAjN6IQDYBliUdCCo7KL",
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.fitHeight,
                colorBlendMode: BlendMode.modulate,
              ),*/
              Image.asset(
                'assets/image/introBack.jpg',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.cover,
                colorBlendMode: BlendMode.modulate,
              ),
              /*Image.network(
                'https://drive.google.com/uc?export=view&id=17qSNjLNw9iPFsu3ISI4ZUnqanSPTChVC',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.fitHeight,
                color: const Color.fromRGBO(255, 255, 255, 0.4),
                colorBlendMode: BlendMode.modulate,
              ),*/
              Image.asset(
                'assets/image/intro.jpg',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.cover,
                color: const Color.fromRGBO(255, 255, 255, 0.4),
                colorBlendMode: BlendMode.modulate,
              ),
              Container(
                //color: Color.fromRGBO(0, 0, 0, 0.5),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                alignment: Alignment.bottomLeft,
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
                              'Visites virtuels de campus',
                              style:
                                  TextStyle(fontSize: 40, color: Colors.white),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 20.0,
                              ),
                            ),
                            Text(
                              "L’application sera sous la forme d’une carte de la université où l’on devra se placer physiquement à divers endroits à la manière en utilisant la réalité augmentée avec Flutter pour une 'visite virtuelle' des campus de l'université de Lorraine à Nancy.",
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
                                  width: 120.0,
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
                                        '/intro_projet',
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
                                  width: 120.0,
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
                                        '/accueil',
                                      );
                                    },
                                    child: Text(
                                      "Sauter",
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
