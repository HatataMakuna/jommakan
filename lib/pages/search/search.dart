import 'package:flutter/material.dart';
import 'package:jom_makan/pages/foods/food_details.dart';
import 'package:jom_makan/server/food/get_all_foods.dart';
import 'package:jom_makan/stores/favorites_provider.dart';
import 'package:jom_makan/stores/user_provider.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final GetAllFoods _getAllFoods = GetAllFoods();
  List<Map<String, dynamic>> allFoods = []; // initial search result when the query is empty
  List<Map<String, dynamic>> foundFoods = []; // used as search result when the query is not empty
  bool loadingFoods = true;

  @override
  void initState() {
    super.initState();
    _fetchAllFoods();

    // all foods will be shown at initialise
    foundFoods = allFoods;

    setState(() {
      loadingFoods = false;
    });
  }

  void _fetchAllFoods() async {
    final getAllFoods = await _getAllFoods.getAllFoods();
    setState(() {
      allFoods = getAllFoods;
      foundFoods = getAllFoods;
    });
  }

  void _runSearchQuery(String query) {
    List<Map<String, dynamic>> results = [];
    if (query.isEmpty) {
      // If the search query is empty, return all foods to user
      results = allFoods;
    } else {
      results = allFoods
          .where((food) =>
              food["food_name"].toLowerCase().contains(query.toLowerCase()) || 
              food["stall_name"].toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    setState(() {
      foundFoods = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextField(
          onChanged: (value) => _runSearchQuery(value),
          decoration: const InputDecoration(
            hintText: 'Search for foods...',
            border: InputBorder.none,
            suffixIcon: Icon(Icons.search),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: loadingFoods ? const Center(child: CircularProgressIndicator()) : _initSearchScreen(),
    );
  }

  Widget _initSearchScreen() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: foundFoods.isNotEmpty ? _buildSearchResults()
        : const Center(
          child: Text(
            'No results found',
            style: TextStyle(fontSize: 24),
          ),
        ),
    );
  }

  Widget _buildSearchResults() {
    return ListView.builder(
      itemCount: foundFoods.length,
      itemBuilder: (context, index) {
        Map<String, dynamic> food = foundFoods[index];
        FavoritesProvider favoritesProvider = Provider.of<FavoritesProvider>(context, listen: false);
        int userID = Provider.of<UserProvider>(context, listen: false).userID!;

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          elevation: 5,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FoodDetailsPage(selectedFood: food),
                ),
              );
            },
            child: Container(
              constraints: const BoxConstraints(maxHeight: 150),
              child: ListTile(
                leading: Image(
                  image: AssetImage('images/foods/${food['food_image']}'),
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
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
                      'Price: RM${double.parse(food['food_price']).toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    if (int.parse(food['qty_in_stock']) == 0) ...[
                      const Text(
                        'Out of stock',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 15,
                        ),
                      ),
                    ] else ...[
                      Text(
                        '${food['qty_in_stock']} items remaining',
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(
                    favoritesProvider.isFavorite(int.parse(food['foodID']))
                      ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red,
                  ),
                  onPressed: () async {
                    String status = await favoritesProvider.toggleFavorite(int.parse(food['foodID']), userID);
                    setState(() {});
                    showSnackbarMessage(status);
                  },
                ),
              ),
            ),
          ),
        );
      }
    );
  }

  void showSnackbarMessage(String status) {
    // add success
    // add failure
    // remove success
    // remove failure
    switch (status) {
      case 'add success':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Food added to favorites.'),
            duration: Duration(seconds: 2),
          ),
        );
        break;
      case 'add failure':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error while adding food to favorites. Try again later.'),
            duration: Duration(seconds: 2),
          ),
        );
        break;
      case 'remove success':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Food removed from favorites.'),
            duration: Duration(seconds: 2),
          ),
        );
        break;
      case 'remove failure':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error while removing food from favorites. Try again later.'),
            duration: Duration(seconds: 2),
          ),
        );
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Unknown error occurred. Try again later.'),
            duration: Duration(seconds: 2),
          ),
        );
    }
  }
}