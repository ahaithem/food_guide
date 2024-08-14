import 'package:flutter/material.dart';
import 'package:food_guide/models/meal.dart';
import '../widgets/meal_item.dart';
import '../dummy_data.dart';

// Screen to show meals for a chosen category
class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';
  //_availableMeals
  final List<Meal> availableMeals;
  CategoryMealsScreen(this.availableMeals);

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  // Declare variables to hold the category title and the list of meals to display
  late String categoryTitle;
  late List<Meal> displayedMeals;

  // A flag to ensure that initialization happens only once
  var _loadedInitData = false;

  @override
  void initState() {
    super.initState();
    // We use didChangeDependencies instead of initState here to access context
  }

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      // Access the arguments passed to this screen via the Navigator
      final routeArgs =
          ModalRoute.of(context)?.settings.arguments as Map<String, String>?;

      if (routeArgs == null) {
        // If no arguments are found, we handle this in the build method (below)
        return;
      }

      // Extract the title and ID of the category from the route arguments
      categoryTitle = routeArgs['title'] ?? 'No Title';
      final categoryId = routeArgs['id'];

      // Filter the dummy meal data to only include meals that belong to the selected category
      displayedMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();

      // Set the flag to true so this block only runs once
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  // Method to remove a meal from the list (called when a meal is deleted)
  void _removeMeal(String mealId) {
    setState(() {
      displayedMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    // If initialization data is not loaded or no meals are found, display an error message
    if (!_loadedInitData || displayedMeals.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('No category data found or no meals available!'),
        ),
      );
    }

    // Main screen layout
    return Scaffold(
      appBar: AppBar(
        // Set the app bar title to the category title
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        // Dynamically create a list of meal items
        itemBuilder: (ctx, index) {
          // Return a widget for each meal item
          return MealItem(
            id: displayedMeals[index].id,
            title: displayedMeals[index].title,
            imageUrl: displayedMeals[index].imageUrl,
            affordability: displayedMeals[index].affordability,
            duration: displayedMeals[index].duration,
            complexity: displayedMeals[index].complexity,
          );
        },
        itemCount: displayedMeals.length, // The number of items to display
      ),
    );
  }
}
