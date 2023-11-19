import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:jom_makan/database/db_connection.dart';
import 'package:jom_makan/server/food/get_ratings.dart';

class FoodDetailsPage extends StatefulWidget {
  final Map<String, dynamic> selectedFood; // Replace this with the actual data type you have

  const FoodDetailsPage({Key? key, required this.selectedFood}) : super(key: key);

  @override
  _FoodDetailsPageState createState() => _FoodDetailsPageState();
}

class _FoodDetailsPageState extends State<FoodDetailsPage> {
  final FoodRatings _foodRatings = FoodRatings(MySqlConnectionPool());
  int quantity = 1;
  String notes = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
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
    Future<List<int>> ratingsFuture = _foodRatings.getRatingsForFood(
      widget.selectedFood['food_name'],
      widget.selectedFood['stall_name']
    );

    return FutureBuilder<List<int>>(
      future: ratingsFuture,
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
                  Text(
                    'Average Rating: $averageRating',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  RatingBar.builder(
                    initialRating: averageRating,
                    minRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 20,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      // You can handle rating updates if needed
                    },
                  ),
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