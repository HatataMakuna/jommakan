import 'package:flutter/material.dart';
import 'package:jom_makan/components/custom_icons_icons.dart';
import 'package:jom_makan/components/logo.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String _searchQuery = '';
  final Logo _logo = Logo();

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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            _logo.getLogoImage(),
            const SizedBox(height: 30),
            categoriesList(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // Categories List
  Widget categoriesList() {
    List<String> foodCategories = [
      'Rice', 'Noodle', 'Bread', 'Cake', 'Drinks',
      'Spaghetti', 'Pizza', 'Burger', 'Sushi', 'Western'
    ];

    List<IconData> foodIcons = [
      Icons.rice_bowl,
      Icons.ramen_dining,
      Icons.bakery_dining,
      Icons.cake,
      Icons.coffee,
      Icons.dinner_dining,
      Icons.local_pizza,
      Icons.lunch_dining,
      CustomIcons.sushiIcon,
      Icons.fastfood,
    ];

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
                      ]
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

  // You may like
  // recommendation applies here
}
