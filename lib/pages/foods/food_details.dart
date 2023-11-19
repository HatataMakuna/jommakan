import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:jom_makan/server/food/get_ratings.dart';

class FoodDetailsPage extends StatefulWidget {
  final Map<String, dynamic> selectedFood; // Replace this with the actual data type you have

  const FoodDetailsPage({super.key, required this.selectedFood});

  @override
  _FoodDetailsPageState createState() => _FoodDetailsPageState();
}

class _FoodDetailsPageState extends State<FoodDetailsPage> {
  final FoodRatings _foodRatings = FoodRatings();
  int quantity = 1;
  String notes = '';
  late Future<List<int>> ratingsFuture; // Declare the Future variable

  @override
  void initState() {
    super.initState();

    // Get ratings for the current food in initState
    ratingsFuture = _foodRatings.getRatingsForFood(
      int.parse(widget.selectedFood['foodID']),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          widget.selectedFood['food_name'],
          style: const TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                constraints: const BoxConstraints.expand(height: 250),
                child: Image(
                  image: AssetImage('images/foods/' + widget.selectedFood['food_image']),
                  fit: BoxFit.cover,
                )
              ),
              titleRating(),
              // more contents
            ],
          ),
        ),
      ),
    );
  }

  Widget titleRating() {
    // Get ratings for the current food
    print('Title Rating');
    print('Get Ratings for Food');

    return FutureBuilder<List<int>>(
      future: ratingsFuture, // Use the pre-assigned Future variable
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // If the Future is still running, show a loading indicator
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // If there's an error, display it to the user
          return Text('Error: ${snapshot.error}');
        } else {
          // If the Future is complete and the data is available
          List<int> ratings = snapshot.data!;
          double averageRating = _foodRatings.calculateAverageRating(ratings);

          return Column(
            children: [
              Text(
                '${widget.selectedFood['food_name']} - ${widget.selectedFood['stall_name']}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Average Rating: ',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Text(
                    averageRating.toStringAsFixed(2),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.blue,
                    )
                  )
                ],
              ),
            ],
          );
        }
      },
    );
  }

  // Replace this method with your actual logic to add the item to the cart
  void addToCart() {
    print('Added to cart: ${widget.selectedFood['food_name']}, Quantity: $quantity, Notes: $notes');
  }
}

/*
Text('Food Name: ${widget.selectedFood['food_name']}'),
            Text('Stall Name: ${widget.selectedFood['stall_name']}'),
            Text('Price: RM${widget.selectedFood['food_price'].toStringAsFixed(2)}'),
            const SizedBox(height: 16),
Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Quantity'),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        if (quantity > 1) {
                          setState(() {
                            quantity--;
                          });
                        }
                      },
                    ),
                    Text(quantity.toString()),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          quantity++;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
TextField(
              decoration: InputDecoration(
                labelText: 'Additional Notes',
                hintText: 'Add special instructions...',
              ),
              onChanged: (value) {
                setState(() {
                  notes = value;
                });
              },
            ),
            const SizedBox(height: 16),
ElevatedButton(
              onPressed: () {
                // Replace this with your logic to add the item to the cart
                addToCart();
              },
              child: Text('Add to Cart'),
            ),
 */