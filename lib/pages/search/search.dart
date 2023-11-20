import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jom_makan/server/search/search_foods.dart';

import 'food_list.dart';
import 'search_by_price_range.dart';
import 'search_by_rating.dart';
import 'search_by_category.dart';
import 'search_by_location.dart';
import 'search_results_updater.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with SearchResultsUpdater {
  List<Map<String, dynamic>> searchResults = []; // List to store search results
  TextEditingController searchController = TextEditingController();
  late String _searchQuery = '';

  late SearchByCategory _searchByCategory;
  late SearchByLocation _searchByLocation;
  final SearchByPriceRange _searchByPriceRange = SearchByPriceRange();
  late SearchByRating _searchByRating;

  void handleSearchResultsUpdate(String responseBody) {
    // Handle the state update here
    setState(() {
      // Parse the JSON response into a list of maps
      List<dynamic> parsedList = json.decode(responseBody);

      // Convert each map in the list to a Map<String, dynamic>
      searchResults = parsedList.map((dynamic item) => item as Map<String, dynamic>).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    // Set the callback function
    updateSearchResultsCallback = handleSearchResultsUpdate;
  }

  void searchFoods() async {
    try {
      final searchFoods = SearchFoods();
      final foods = await searchFoods.getFoods(_searchQuery);

      setState(() {
        searchResults = foods;
      });
    } catch (e) {
      print('Error searching for foods: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextField(
          onChanged: (value) {
            setState(() {
              _searchQuery = value;
            });
            searchFoods(); // Call the searchFoods method when the search query changes
          },
          decoration: InputDecoration(
            hintText: 'Search for foods...',
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                setState(() {
                  _searchQuery = '';
                });
              },
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 16),
            // filter buttons
            filterButtons(),
            const SizedBox(height: 16),
            // food list
            Expanded(
              child: searchResults.isEmpty ? foodList() : const Center(
                child: Text(
                  'No results found.',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget filterButtons() {
    List<String> filterCriterias = ['Price Range', 'Rating', 'Category', 'Location'];

    return Card(
      elevation: 5,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
        side: BorderSide(
          color: Colors.grey,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Filters',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // ignore: sized_box_for_whitespace
            Container(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: filterCriterias.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        // Text button with white background, solid border 1px, and bold text
                        TextButton(
                          onPressed: () {
                            // Call the respectively dialogs
                            if (filterCriterias[index] == 'Price Range') {
                              _searchByPriceRange.showPriceRangeFilterDialog(context);
                            } else if (filterCriterias[index] == 'Rating') {
                              _searchByRating.showRatingFilterDialog(context);
                            } else if (filterCriterias[index] == 'Category') {
                              _searchByCategory.showCategoryFilterDialog(context);
                            } else {
                              _searchByLocation.showLocationFilterDialog(context);
                            }
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.all(10.0),
                            side: const BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                          child: Text(
                            filterCriterias[index],
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}