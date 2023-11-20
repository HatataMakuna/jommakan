import 'package:flutter/material.dart';
import 'search.dart';
import 'search_results_updater.dart';

class SearchByPriceRange extends State<SearchPage> with SearchResultsUpdater {
  Future<void> showPriceRangeFilterDialog(BuildContext context) async {
    RangeValues values = const RangeValues(1, 100);
    RangeLabels labels = const RangeLabels('1', '100');

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Price Range',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              Text(
                "RM ${values.start.toInt()} - RM ${values.end.toInt()}",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              RangeSlider(
                divisions: 100,
                min: 1,
                max: 100,
                values: values,
                labels: labels,
                onChanged: (newValues) {
                  values = newValues;
                  labels = RangeLabels("RM ${values.start.toInt()}", "RM ${values.end.toInt()}");
                },
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
                //await applyFilter(values);
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Apply'),
            ),
          ],
        );
      },
    );
  }

  /* Future<void> applyFilter(RangeValues values) async {
    // Implement your logic to apply the filter
    final minPrice = values.start.toInt();
    final maxPrice = values.end.toInt();

    // Make an HTTP request with the filter values
    final response = await http.get(Uri.parse('http://localhost:3000/get-all-foods?priceRangeMin=$minPrice&priceRangeMax=$maxPrice'));

    // Process the response
    if (response.statusCode == 200) {
      // Handle the successful response
      print('Filter applied successfully');
      updateSearchResults(response.body);
    } else {
      // Handle errors
      print('Failed to apply filter. Status code: ${response.statusCode}');
    }
  } */

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}