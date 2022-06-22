import 'package:flutter/material.dart';
import 'package:ff_navigation_bar_lts/ff_navigation_bar_lts.dart';

class HomeNavBar extends StatelessWidget {
  HomeNavBar({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        margin: EdgeInsets.only(left: 12.0, right: 12.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              //update the bottom app bar view each time an item is clicked
              onPressed: () {
                Navigator.pushNamed(context, "/accueil");
              },
              iconSize: 27.0,
              icon: Icon(
                Icons.home,
                //darken the icon if it is selected or else give it a different color
                color: index == 0 ? Colors.black : Colors.grey.shade400,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, "/liste_ul");
              },
              iconSize: 27.0,
              icon: Icon(
                Icons.search,
                color: index == 1 ? Colors.black : Colors.grey.shade400,
              ),
            ),
            //to leave space in between the bottom app bar items and below the FAB
            SizedBox(
              width: 50.0,
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, "/propos");
              },
              iconSize: 27.0,
              icon: Icon(
                Icons.groups,
                color: index == 2 ? Colors.black : Colors.grey.shade400,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, "/param");
              },
              iconSize: 27.0,
              icon: Icon(
                Icons.settings,
                color: index == 3 ? Colors.black : Colors.grey.shade400,
              ),
            ),
          ],
        ),
      ),
      //to add a space between the FAB and BottomAppBar
      shape: CircularNotchedRectangle(),
      //color of the BottomAppBar
      color: Colors.white,
    );
  }
}
