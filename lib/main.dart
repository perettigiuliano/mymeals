import 'package:flutter/material.dart';
import 'package:mymeals/screens/favs_screen.dart';

import 'dummy_data.dart';
import 'models/recipe.dart';
import 'screens/filters_screen.dart';
import 'screens/tabs_screen.dart';
import 'screens/recipe_detail_screen.dart';
import 'screens/category_recipes_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    "gluten": false,
    "vegan": false,
    "vegetarian": false,
    "lactose": false,
  };
  List<Recipe> availableRecipes = DUMMY_RECIPES;

  void setFilters(Map<String, bool> userFilters) {
    setState(() {
      _filters = userFilters;
      availableRecipes = DUMMY_RECIPES.where((element) {
        if (_filters["gluten"] && !element.isGlutenFree) {
          return false;
        }
        if (_filters["vegan"] && !element.isVegan) {
          return false;
        }
        if (_filters["vegetarian"] && !element.isVegetarian) {
          return false;
        }
        if (_filters["lactose"] && !element.isLactoseFree) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: "Raleway",
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyText2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
            bodyText1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
            headline6: TextStyle(
                // color: Colors.white,
                fontSize: 22,
                fontFamily: "RobotoCondensed",
                fontWeight: FontWeight.bold)),
      ),
      routes: {
        "/": (_) => TabsScreen(),
        CategoryRecipesScreen.ROUTENAME: (_) =>
            CategoryRecipesScreen(availableRecipes),
        RecipeDetailScreen.ROUTENAME: (_) => RecipeDetailScreen(),
        FiltersScreen.ROUTENAME: (_) => FiltersScreen(setFilters, _filters),
        FavsScreen.ROUTENAME: (_) => FavsScreen(),
      },
    );
  }
}
