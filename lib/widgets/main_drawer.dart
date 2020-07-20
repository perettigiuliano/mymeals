import 'package:flutter/material.dart';
import 'package:mymeals/screens/favs_screen.dart';
import 'package:mymeals/screens/filters_screen.dart';

class MainDrawer extends StatelessWidget {
  Widget drawerItem(
      BuildContext context, String title, IconData icon, String route) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
            fontFamily: "RobotoCondensed",
            fontSize: 24,
            fontWeight: FontWeight.bold),
      ),
      onTap: () {
        Navigator.pushReplacementNamed(context, route);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            color: Theme.of(context).accentColor,
            height: 100,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.center,
            child: Text(
              "Cooking up!",
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  color: Theme.of(context).primaryColor),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          drawerItem(context, "Recipes", Icons.restaurant, "/"),
          drawerItem(context, "Favs", Icons.star, FavsScreen.ROUTENAME),
          drawerItem(
              context, "Settings", Icons.settings, FiltersScreen.ROUTENAME),
        ],
      ),
    );
  }
}
