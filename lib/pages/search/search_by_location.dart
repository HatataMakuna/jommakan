import 'package:flutter/material.dart';
import 'package:jom_makan/consts/location_icons.dart';
import 'search.dart';
import 'search_results_updater.dart';

abstract class SearchByLocation extends State<SearchPage> with SearchResultsUpdater {
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
                            if (value) {
                              selectedLocations.add(locations[i]);
                            } else {
                              selectedLocations.remove(locations[i]);
                            }
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
              onPressed: () async {
                //await applyFilter(selectedLocations);
                Navigator.pop(context);
              },
              child: const Text('Apply'),
            )
          ]
        );
      }
    );
  }

  /* Future<void> applyFilter(List<String> selectedLocations) async {
    // Implement your logic to apply the filter
    // Make an HTTP request with the filter values
    final response = await http.get(Uri.parse('http://localhost:3000/get-all-foods?locations=${selectedLocations.join(',')}'));
    
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
}