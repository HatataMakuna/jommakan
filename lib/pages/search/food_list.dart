import 'package:flutter/material.dart';
import 'package:jom_makan/pages/foods/food_details.dart';
import 'package:jom_makan/server/food/get_foods.dart';

final GetFoods _getFoods = GetFoods();

  Widget foodList({
    String? searchQuery,
    int? priceRangeMin,
    int? priceRangeMax,
    double? minRating,
    List<String>? selectedLocations,
    List<String>? selectedCategories,
  }) {
    return FutureBuilder(
      future: _getFoods.getAllFoods(
        searchQuery: searchQuery,
        priceRangeMin: priceRangeMin,
        priceRangeMax: priceRangeMax,
        minRating: minRating,
        selectedLocations: selectedLocations,
        selectedCategories: selectedCategories,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!['foods'] == null) {
          return const Center(child: Text('No data available'));
        } else {
          List<Map<String, dynamic>> foods = snapshot.data?['foods'];

          return ListView.builder(
            itemCount: foods.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> food = foods[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                elevation: 5,
                
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FoodDetailsPage(selectedFood: food),
                      )
                    );
                  },
                  child: Container(
                    constraints: const BoxConstraints(
                      maxHeight: 150,
                    ),
                    child: ListTile(
                      // Wrap Image.network with Container to crop width and height
                      // ignore: sized_box_for_whitespace
                      leading: Container(
                        width: 100,
                        height: 100,
                        child: Image.network(
                          food['food_image_url'],
                          fit: BoxFit.fitHeight, // Use BoxFit.cover to crop the image
                        )
                      ),
                      title: Text(
                        '${food['food_name']} - ${food['stall_name']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 25),
                          Text(
                            'Price: RM${food['food_price'].toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            '${food['qty_in_stock']} items remaining',
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
