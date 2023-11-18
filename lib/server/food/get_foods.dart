import 'dart:convert';
import 'package:http/http.dart' as http;

class GetFoods {
  Future<Map<String, dynamic>> getAllFoods({
    String? searchQuery,
    int? priceRangeMin,
    int? priceRangeMax,
    double? minRating,
    List<String>? selectedLocations,
    List<String>? selectedCategories,
  }) async {
    final Map<String, String> queryParams = {};

    if (searchQuery != null) {
      queryParams['search'] = searchQuery;
    }

    if (minRating != null) {
      queryParams['minRating'] = minRating.toString();
    }

    if (selectedLocations != null && selectedLocations.isNotEmpty) {
      queryParams['locations'] = selectedLocations.join(',');
    }

    if (selectedCategories != null && selectedCategories.isNotEmpty) {
      queryParams['categories'] = selectedCategories.join(',');
    }

    // Add search query parameter to the API URL if provided
    final Uri uri = Uri.https('localhost:3000', '/get-all-foods', {
      'search': searchQuery,
      'priceRangeMin': priceRangeMin?.toString(),
      'priceRangeMax': priceRangeMax?.toString(),
      'minRating': minRating?.toString(),
      'locations': selectedLocations?.join(','),
      'categories': selectedCategories?.join(','),
    });

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        List<Map<String, dynamic>> foods = List<Map<String, dynamic>>.from(data['foods']);
        return {'success': true, 'foods': foods};
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
      return {'success': false, 'error': e.toString()};
    }
  }
}

/* void main() async {
  //Map<String, dynamic> result = await getAllFoods();

  if (result['success']) {
    List<dynamic> foods = result['foods'];
    for (var food in foods) {
      print('Food ID: ${food['foodID']}');
      print('Food Name: ${food['food_name']}');
      print('Stall Name: ${food['stall_name']}');
      print('Food Price: ${food['food_price']}');
      print('Qty in Stock: ${food['qty_in_stock']}');
      print('Food Image URL: ${food['food_image_url']}');
      print('-----------------------');
    }
  } else {
    print('Failed to fetch data: ${result['error']}');
  }
} */