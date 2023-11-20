import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:jom_makan/pages/search/search.dart';
import 'package:jom_makan/pages/search/food_list.dart';

mixin SearchResultsUpdater on State<SearchPage> {
  // Define a callback function
  void Function(String responseBody) updateSearchResultsCallback = (responseBody) {};

  void updateSearchResults(String responseBody) {
    List<Map<String, dynamic>> searchResults = [];

    try {
      // Attempt to parse the response body as a List<dynamic>
      List<dynamic> parsedList = json.decode(responseBody);

      // Check if the parsed response is a List<dynamic>
      if (parsedList is List<dynamic>) {
        // Convert each map in the list to a Map<String, dynamic>
        searchResults = parsedList.map((dynamic item) => item as Map<String, dynamic>).toList();
      } else {
        print('Invalid response format. Expected a List<dynamic> or Map<String, dynamic>.');
      }
    } catch (e) {
      print('Error parsing response: $e');
    }

    // Call the callback function to update the search results
    updateSearchResultsCallback(responseBody);
  }
}
