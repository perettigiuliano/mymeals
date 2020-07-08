import 'package:flutter/material.dart';
import 'package:mymeals/widgets/category_item.dart';

import '../dummy_data.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, bool>;
    return GridView(
        children: DUMMY_CATEGORIES.map((data) {
          return CategoryItem(
            id: data.id,
            color: data.color,
            title: data.title,
          );
        }).toList(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 400,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10)); //,
  }
}
