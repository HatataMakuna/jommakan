import 'package:flutter/material.dart';
import 'package:jom_makan/pages/foods/food_details.dart';
import 'package:jom_makan/server/food/get_foods.dart';

class FoodCategoryList extends StatefulWidget {
  final String selectedCategory;
  const FoodCategoryList({super.key, required this.selectedCategory});

  @override
  State<StatefulWidget> createState() => _FoodCategoryListState();
}

class _FoodCategoryListState extends State<FoodCategoryList> {
  bool loading = true;
  final GetFoods _getFoods = GetFoods();
  List<Map<String, dynamic>> allFoods = [];

  @override
  void initState() {
    super.initState();
    _fetchFoods();
  }

  void _fetchFoods() async {
    List<Map<String, dynamic>> results = await _getFoods.getFoodsByCategory(widget.selectedCategory);
    setState(() {
      allFoods = results;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Food Category: ${widget.selectedCategory}',
          style: const TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: loading ? const Center(child: CircularProgressIndicator()) : _initFoodList(),
    );
  }

  Widget _initFoodList() {
    if (allFoods.isEmpty) {
      return const Center(child: Text(
        'No foods found under this category.',
        style: TextStyle(fontSize: 14),
      ));
    } else {
      return _loadFoodList();
    }
  }

  Widget _loadFoodList() {
    return ListView.builder(
      itemCount: allFoods.length,
      itemBuilder: (context, index) {
        Map<String, dynamic> food = allFoods[index];
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
            ),
          ),
          ),
        );
      },
    );
  }
}