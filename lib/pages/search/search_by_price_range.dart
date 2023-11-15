import 'package:flutter/material.dart';

class SearchByPriceRange {
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
              onPressed: () {
                // Do something with minPrice and maxPrice, e.g., update your filter
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