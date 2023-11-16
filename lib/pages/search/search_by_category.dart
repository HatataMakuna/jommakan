import 'package:flutter/material.dart';
import 'package:jom_makan/consts/category_icons.dart';

class SearchByCategory {
  Future<void> showCategoryFilterDialog(BuildContext context) async {
    List<String> selectedCategories = []; // To store the selected categories

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Filter by Category',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Container(
            constraints: const BoxConstraints(maxHeight: 300), // Set the maximum height
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 15),
                  // Display a checkbox for each category with icons
                  for (int i = 0; i < foodCategories.length; i++)
                    ListTile(
                      title: Row(
                        children: [
                          Icon(foodIcons[i]), // Display the food icon
                          const SizedBox(width: 8), // Add spacing between icon and text
                          Expanded(
                            child: Text(foodCategories[i]),
                          ),
                        ],
                      ),
                      trailing: Checkbox(
                        value: selectedCategories.contains(foodCategories[i]),
                        onChanged: (bool? value) {
                          if (value != null) {
                            if (value) {
                              selectedCategories.add(foodCategories[i]);
                            } else {
                              selectedCategories.remove(foodCategories[i]);
                            }
                          }
                          // Note: State is not being set here, as it's not required in this case
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Do something with the selected categories, e.g., update your filter
                // ...

                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Apply'),
            ),
          ],
        );
      },
    );
  }
}