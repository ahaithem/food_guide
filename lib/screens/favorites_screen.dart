import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favoriteMeals;
  FavoritesScreen(this.favoriteMeals);

  @override
  Widget build(BuildContext context) {
    if (favoriteMeals.isEmpty) {
      return Center(
        child: Text('There is no Favorites yet'),
      );
    } else {
      return ListView.builder(
        // Add 'return' here
        // Dynamically create a list of meal items
        itemBuilder: (ctx, index) {
          // Return a widget for each meal item
          return MealItem(
            id: favoriteMeals[index].id,
            title: favoriteMeals[index].title,
            imageUrl: favoriteMeals[index].imageUrl,
            affordability: favoriteMeals[index].affordability,
            duration: favoriteMeals[index].duration,
            complexity: favoriteMeals[index].complexity,
          );
        },
        itemCount: favoriteMeals.length, // The number of items to display
      );
    }
  }
}
