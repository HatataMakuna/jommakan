import 'package:flutter/material.dart';
import 'package:jom_makan/components/logo.dart';
import 'package:jom_makan/consts/category_icons.dart';
import 'package:jom_makan/model/rating.dart';
import 'package:jom_makan/model/recommendation.dart';
import 'package:jom_makan/pages/foods/food_details.dart';
import 'package:jom_makan/server/food/get_foods.dart';
import 'package:jom_makan/server/food/get_popular_foods.dart';
import 'package:jom_makan/server/rating/get_ratings.dart';
import 'package:jom_makan/stores/user_provider.dart';
import 'package:provider/provider.dart';

/*
  TODO:
  SELECT ORDER OPTION
  - Pre-order
  - Self-collect
  - Delivery
  - Order Now

  DISPLAY IN MENU
*/

// TODO: Populate the home page, make it scrollable

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Logo _logo = Logo();
  final GetFoods _getFoods = GetFoods();
  final GetPopularFoods _getPopularFoods = GetPopularFoods();
  final FoodRatings _foodRatings = FoodRatings();
  bool loadingRecommendations = true;

  List<Map<String, dynamic>> _popularFoods = [];
  List<Map<String, dynamic>> _recommendedFoods = [];

  @override
  void initState() {
    super.initState();
    _loadPopularFoods();
    _loadRecommendations();
  }

  Future<void> _loadPopularFoods() async {
    final popularFoods = await _getPopularFoods.getPopularFoods();
    if (mounted) {
      setState(() {
        _popularFoods = popularFoods;
      });
    }
  }

  void _loadRecommendations() async {
    List<Rating> ratings = await _foodRatings.getRatingsForRecommendation();
    RecommendationSystem recommendationSystem = RecommendationSystem(ratings: ratings);

    // Get user ID from the store
    int? userID = _getUserID();

    // Generate list of recommended food IDs
    List<int> recommendedFoodIDs = recommendationSystem.recommendFoods(userID!);
    
    // Pass the recommendd food IDs to the server to get its food details
    final recommendedFoods = await _getFoods.getFoodsByIds(recommendedFoodIDs);
    
    if (mounted) {
      setState(() {
        _recommendedFoods = recommendedFoods;
        loadingRecommendations = false;
      });
    }
  }

  int? _getUserID() {
    return Provider.of<UserProvider>(context, listen: false).userID;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          backgroundColor: Colors.white,
          title: SizedBox(
            height: kToolbarHeight,
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/search');
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        SizedBox(width: 20),
                        Text(
                          'Search for foods...',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            _logo.getLogoImageWithCustomSize(299, 60),
            const SizedBox(height: 10),
            categoriesList(),
            const SizedBox(height: 10),
            popularFoods(),
            const SizedBox(height: 10),
            loadingRecommendations ? const Center(child: CircularProgressIndicator()) : youMayLike(),
          ],
        ),
      ),
    );
  }

  // Categories List
  Widget categoriesList() {
    return Card(
      elevation: 5, // Set the shadow depth
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
                Icon(Icons.category_rounded),
                SizedBox(width: 15),
                Text(
                  'Categories',
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
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: foodCategories.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Icon(foodIcons[index]), // put the text below the icon
                        const SizedBox(height: 2),
                        Text(foodCategories[index]),
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

  // Popular foods
  Widget popularFoods() {
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
                Icon(Icons.whatshot_rounded),
                SizedBox(width: 15),
                Text(
                  'Trending Foods',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Display random foods
            // ignore: sized_box_for_whitespace
            Container(
              height: 130,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _popularFoods.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> food = _popularFoods[index];
                  return InkWell(
                    onTap: () {
                      // Navigate to food details page using food['foodID']
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FoodDetailsPage(selectedFood: food),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          // Display food image
                          Image(
                            image: AssetImage('images/foods/${food['food_image']}'),
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 5),
                          // Display food name
                          Text(
                            food['food_name'],
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    )
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // You may like
  Widget youMayLike() {
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
                Icon(Icons.thumb_up_rounded),
                SizedBox(width: 15),
                Text(
                  'Foods You May Like',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Display recommended foods based on user's ratings
            if (_recommendedFoods.isNotEmpty) ...[
              // ignore: sized_box_for_whitespace
              Container(
                height: 130,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _recommendedFoods.length,
                  itemBuilder: ((context, index) {
                    Map<String, dynamic> food = _recommendedFoods[index];
                    return InkWell(
                      onTap: () {
                        // Navigate to food details page using food['foodID']
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FoodDetailsPage(selectedFood: food),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            // display food image
                            Image(
                              image: AssetImage('images/foods/${food['food_image']}'),
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(height: 5),
                            // display food name
                            Text(
                              food['food_name'],
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ] else ...[
              // Display message if no recommended foods
              const Center(
                child: Text(
                  'No recommended foods. Try rate some foods to get recommendations.',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
