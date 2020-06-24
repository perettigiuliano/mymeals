import 'package:flutter/material.dart';

class CategoryRecipesScreen extends StatelessWidget {
  static const ROUTENAME = "/category-recipes-screen";
  // final String _id;
  // final String _title;

  // CategoryRecipesScreen(this._id, this._title);

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            routeArgs["title"] + " recipes",
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        body: Center(
          child: Text("Recipes list..."),
        ));
  }
}
