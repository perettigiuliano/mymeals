import 'package:flutter/material.dart';
import 'package:mymeals/models/recipe.dart';
import 'package:mymeals/widgets/recipe_item.dart';

class CategoryRecipesScreen extends StatefulWidget {
  static const ROUTENAME = "/category-recipes-screen";
  final List<Recipe> availableRecipes;

  CategoryRecipesScreen(this.availableRecipes);

  @override
  _CategoryRecipesScreenState createState() => _CategoryRecipesScreenState();
}

class _CategoryRecipesScreenState extends State<CategoryRecipesScreen> {
  List<Recipe> categoryRecipes;
  Map<String, String> routeArgs;
  bool doneInitData = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!doneInitData) {
      routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      categoryRecipes = widget.availableRecipes.where((element) {
        return element.categories.contains(routeArgs["id"]);
      }).toList();
    }
    doneInitData = true;
    super.didChangeDependencies();
  }

  void _deleteRecipe(String id) {
    final recipe = categoryRecipes.firstWhere((element) {
      return element.id.contains(id);
    });
    setState(() {
      categoryRecipes.remove(recipe);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            routeArgs["title"] + " recipes",
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return RecipeItem(
              id: categoryRecipes[index].id,
              title: categoryRecipes[index].title,
              imageUrl: categoryRecipes[index].imageUrl,
              duration: categoryRecipes[index].duration,
              complexity: categoryRecipes[index].complexity,
              affordability: categoryRecipes[index].affordability,
              deleteRecipeHandler: _deleteRecipe,
            );
          },
          itemCount: categoryRecipes.length,
        ));
  }
}
