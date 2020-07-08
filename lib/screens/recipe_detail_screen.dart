import 'package:flutter/material.dart';
import 'package:mymeals/models/recipe.dart';

import '../dummy_data.dart';

enum SectionBodyType { Ingredients, Steps }

class RecipeDetailScreen extends StatelessWidget {
  static const ROUTENAME = "/recipe-detail-screen";
  Recipe _recipe;

  Widget sectionBodyIngredients(int index) {
    return Card(
      // color: Theme.of(context).accentColor,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Text(_recipe.ingredients[index]),
      ),
    );
  }

  Widget sectionBodySteps(int index) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: CircleAvatar(
            child: Text("#" + (index + 1).toString()),
          ),
          title: Text(_recipe.steps[index]),
        ),
        Divider()
      ],
    );
  }

  Widget sectionTitle(BuildContext context, String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget sectionBody(SectionBodyType type) {
    int itemCount = type == SectionBodyType.Ingredients
        ? _recipe.ingredients.length
        : _recipe.steps.length;
    // List<String> data = type == sectionBodyType.Ingredients
    //     ? _recipe.ingredients
    //     : _recipe.steps;
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      height: 300,
      width: double.infinity,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      child: ListView.builder(
        itemBuilder: (context, index) {
          switch (type) {
            case SectionBodyType.Ingredients:
              return sectionBodyIngredients(index);
            case SectionBodyType.Steps:
              return sectionBodySteps(index);
            default:
          }
        },
        itemCount: itemCount,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    _recipe = DUMMY_RECIPES.firstWhere((element) {
      return element.id.contains(routeArgs["id"]);
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _recipe.title,
          // style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 300,
              child: Image.network(
                _recipe.imageUrl,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            sectionTitle(context, "Ingredients"),
            sectionBody(SectionBodyType.Ingredients),
            sectionTitle(context, "Steps"),
            sectionBody(SectionBodyType.Steps),
            SizedBox(
              height: 15,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context, _recipe.id);
        },
        child: Icon(Icons.delete),
      ),
    );
  }
}
