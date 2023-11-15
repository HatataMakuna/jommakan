import 'package:flutter/material.dart';

class SearchByRating {
  Future<void> showRatingFilterDialog(BuildContext context) async {
    double selectedRating = 0; // To store the selected rating

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Filter by Rating',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              Row(
                children: [
                  // Display stars for selecting the rating
                  for (int i = 1; i <= 5; i++)
                    GestureDetector(
                      onTap: () {
                        // Update the selected rating
                        selectedRating = i.toDouble();
                      },
                      child: Icon(
                        i <= selectedRating.floor() ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                      ),
                    ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Do something with the selected rating, e.g., update your filter
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