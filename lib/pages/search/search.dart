import 'package:flutter/material.dart';

import 'search_by_price_range.dart';
import 'search_by_rating.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<String> searchResults = []; // List to store search results
  TextEditingController searchController = TextEditingController();
  late String _searchQuery = '';

  final SearchByPriceRange _searchByPriceRange = SearchByPriceRange();
  final SearchByRating _searchByRating = SearchByRating();

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
            filterButtons(),
            // filter buttons
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
                            // Logic here
                            if (filterCriterias[index] == 'Price Range') {
                              _searchByPriceRange.showPriceRangeFilterDialog(context);
                            } else if (filterCriterias[index] == 'Rating') {
                              _searchByRating.showRatingFilterDialog(context);
                            } else if (filterCriterias[index] == 'Category') {

                            } else {
                              // if Location
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
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}