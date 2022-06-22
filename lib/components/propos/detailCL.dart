import 'package:flutter/material.dart';
import 'package:flutter_wiki_2/components/navBar/navBarHome.dart';

class DetailCL extends StatefulWidget {
  @override
  State<DetailCL> createState() => _DetailCLState();
}

class _DetailCLState extends State<DetailCL> {
  var index = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détail CharlyLab'),
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
                        'LE CHARLYLAB',
                        style: TextStyle(fontSize: 40, color: Colors.black),
                      ),
                    ),
                    /* padding */
                    Padding(
                      padding: EdgeInsets.all(25),
                      child: Text(
                        "Le Charly Lab est un espace de créativité et de travail collaboratif orienté vers les nouvelles interfaces numériques. Il rassemble les passionnés de nouvelles technologies ainsi que les curieux autour de la création 3D, pour la réalité virtuelle ou augmentée ou l’impression 3D, mais également la conception et la création d’objets connectés. Plongez-vous dans l’univers des objets connectés grâce aux casques de réalité virtuelle, Oculus Rift et HTC Vive, et au casque de réalité mixte, Hololens !",
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
                          'assets/image/propos_detail_cl.jpeg',
                          fit: BoxFit.cover,
                          colorBlendMode: BlendMode.modulate,
                        ),
                      ],
                    ),
                    /* padding */
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "Au Charly Lab, il est possible de créer des robots et des objets connectés, de piloter des drones, de réaliser des impressions d’objet en 3D ainsi que de conceptualiser des produits et de développer des programmes en réalité virtuelle et mixte. Les réalités virtuelles et mixtes offrent la possibilité de designer de futurs produits et les tester dans un environnement virtuel ou réel choisi.",
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
                          'assets/image/propos_detail_cl_2.jpeg',
                          fit: BoxFit.cover,
                          colorBlendMode: BlendMode.modulate,
                        ),
                        /*Container(
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
                                        "LE CHARLYLAB",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),*/
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
