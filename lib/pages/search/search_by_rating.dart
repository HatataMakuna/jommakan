import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'search.dart';
import 'search_results_updater.dart';

abstract class SearchByRating extends State<SearchPage> with SearchResultsUpdater {
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
            ElevatedButton(
              onPressed: () async {
                await applyFilter(selectedRating);
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Apply'),
            ),
          ],
        );
      },
    );
  }

  Future<void> applyFilter(double selectedRating) async {
    // Implement your logic to apply the filter
    // Make an HTTP request with the filter value
    final response = await http.get(Uri.parse('http://localhost:3000/get-all-foods?rating=$selectedRating'));

    // Process the response
    if (response.statusCode == 200) {
      // Handle the successful response
      print('Filter applied successfully');
      updateSearchResults(response.body);
    } else {
      // Handle errors
      print('Failed to apply filter. Status code: ${response.statusCode}');
    }
  }
}