import 'package:flutter/material.dart';
import 'package:jom_makan/consts/location_icons.dart';

class SearchByLocation {
  Future<void> showLocationFilterDialog(BuildContext context) async {
    List<String> selectedLocations = []; // To store the selected locations

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Filter by Location',
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
                  // Display a checkbox for each location with images
                  for (int i = 0; i < locations.length; i++)
                    ListTile(
                      title: Row(
                        children: [
                          locationImages[i], // Display the image
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(locations[i]),
                          ),
                        ],
                      ),
                      trailing: Checkbox(
                        value: selectedLocations.contains(locations[i]),
                        onChanged: (bool? value) {
                          if (value != null) {
                            selectedLocations.add(locations[i]);
                          } else {
                            selectedLocations.remove(locations[i]);
                          }
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
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Do something with the selected locations, e.g., update your filter
                Navigator.pop(context);
              },
              child: const Text('Apply'),
            )
          ]
        );
      }
    );
  }
}