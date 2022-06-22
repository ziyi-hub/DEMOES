import 'package:flutter/material.dart';
import 'package:flutter_wiki_2/components/accueil/choiceCard.dart';
import 'package:flutter_wiki_2/datas/listeUL2.dart';

class RowScroll extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          padding: EdgeInsets.only(
            top: 10.0,
          ),
          child: ListTile(
            title: Text(
              "Précommande",
              style: TextStyle(
                fontSize: 25,
              ),
            ),
            trailing: InkWell(
              child: Text(
                "Voir plus",
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
              onTap: () => {
                Navigator.pushNamed(
                  context,
                  '/liste_ul',
                ),
              },
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          child: ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            padding: EdgeInsets.only(
              left: 20.0,
              right: 20.0,
            ),
            children: List.generate(
              //model.datas.length,
              3,
              (index) {
                return Center(
                  child: ChoiceCard(choice: datas[index], item: datas[index]),
                );
              },
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            top: 10.0,
          ),
          child: Text(
            "Université plus proche",
            style: TextStyle(
              fontSize: 25,
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          child: ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            padding: EdgeInsets.only(
              left: 20.0,
              right: 20.0,
            ),
            children: List.generate(
              datas.length,
              (index) {
                return Center(
                  child: ChoiceCard(choice: datas[index], item: datas[index]),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
