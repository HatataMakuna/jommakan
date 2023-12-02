import 'package:flutter/material.dart';
import 'package:jom_makan/pages/foods/food_details.dart';
import 'package:jom_makan/server/food/get_foods.dart';
import 'package:jom_makan/stores/favorites_provider.dart';
import 'package:jom_makan/stores/user_provider.dart';
import 'package:provider/provider.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({super.key});
  
  @override
  State<StatefulWidget> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  final GetFoods _getFoods = GetFoods();
  //int userID = Provider.of<UserProvider>(context, listen: false).userID!;
  bool loading = true;

  List<Map<String, dynamic>> _favoriteFoods = [];

  @override
  void initState() {
    super.initState();
    _loadFavoriteFoods();
  }

  void _loadFavoriteFoods() async {
    FavoritesProvider favoritesProvider = Provider.of<FavoritesProvider>(context, listen: false);

    if (favoritesProvider.favoriteFoodIDs.isNotEmpty) {
      final favoriteFoods = await _getFoods.getFoodsByIds(
        Provider.of<FavoritesProvider>(context, listen: false).favoriteFoodIDs
      );

      if (mounted) {
        setState(() {
          _favoriteFoods = favoriteFoods;
        });
      }
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: loading ? const Center(child: CircularProgressIndicator()) : _initFavoritesPage(),
    );
  }

  Widget _initFavoritesPage() {
    FavoritesProvider favoritesProvider = Provider.of<FavoritesProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: favoritesProvider.favoriteFoodIDs.isNotEmpty ? _buildFavoritesList()
        : const Center(
          child: Text(
            'No favorite foods found',
            style: TextStyle(fontSize: 24),
          ),
        ),
    );
  }

  Widget _buildFavoritesList() {
    return ListView.builder(
      itemCount: _favoriteFoods.length,
      itemBuilder: (context, index) {
        Map<String, dynamic> food = _favoriteFoods[index];
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