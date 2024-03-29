import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/category.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/category_grid_item.dart';

import '../models/meal.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key,required this.onToggleFavorite});
  final void Function(Meal meal) onToggleFavorite;
  void _selectedCategory(BuildContext context, Category category) {
    var meal = dummyMeals.where((meal) => meal.categories.contains(category.id)).toList();

    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => MealsScreen(title: category.title, meals: meal,onToggleFavorite: onToggleFavorite,)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Pick your category"),
        ),
        body: GridView(
          padding: const EdgeInsets.all(24),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          children: [
            for (final category in availableCategories)
              CategoryGridItem(
                category: category,
                onSelectCategory: () {
                  _selectedCategory(context, category);
                },
              )
          ],
        ));
  }
}
