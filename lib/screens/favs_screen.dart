import 'package:flutter/material.dart';
import 'package:mymeals/dummy_data.dart';
import "../widgets/recipe_item.dart";

class FavsScreen extends StatelessWidget {
  static const String ROUTENAME = "favs";
  static List<String> _favs = [];

  static Color addFav(String id) {
    if (_favs.contains(id)) {
      _favs.removeWhere((element) {
        return element == id;
      });
      return Colors.black38;
    }
    _favs.add(id);
    return Colors.yellow;
  }

  static Color checkFav(String id) {
    return _favs.contains(id) ? Colors.yellow : Colors.black38;
  }

  static List<String> getFavs() {
    return _favs;
  }

  static void deleteFav(String id) {
    _favs.removeWhere((element) {
      return element == id;
    });
  }

  @override
  Widget build(BuildContext context) {
    final recipes = DUMMY_RECIPES.where((element) {
      return _favs.contains(element.id);
    }).toList();
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text("Favs recipes"),
    //   ),
    //   drawer: MainDrawer(),
    //   body: ListView.builder(
    //     itemBuilder: (context, index) {
    //       return RecipeItem(
    //         id: recipes[index].id,
    //         title: recipes[index].title,
    //         imageUrl: recipes[index].imageUrl,
    //         duration: recipes[index].duration,
    //         complexity: recipes[index].complexity,
    //         affordability: recipes[index].affordability,
    //         deleteRecipeHandler: null,
    //       );
    //     },
    //     itemCount: recipes.length,
    //   ),
    // );
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          return RecipeItem(
            id: recipes[index].id,
            title: recipes[index].title,
            imageUrl: recipes[index].imageUrl,
            duration: recipes[index].duration,
            complexity: recipes[index].complexity,
            affordability: recipes[index].affordability,
            deleteRecipeHandler: null,
          );
        },
        itemCount: recipes.length,
      ),
    );
  }
}
