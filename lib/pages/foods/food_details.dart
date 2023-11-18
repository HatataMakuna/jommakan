import 'package:flutter/material.dart';

class FoodDetailsPage extends StatefulWidget {
  final Map<String, dynamic> selectedFood; // Replace this with the actual data type you have

  const FoodDetailsPage({Key? key, required this.selectedFood}) : super(key: key);

  @override
  _FoodDetailsPageState createState() => _FoodDetailsPageState();
}

class _FoodDetailsPageState extends State<FoodDetailsPage> {
  int quantity = 1;
  String notes = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display food details (replace with your actual data)
            Text('Food Name: ${widget.selectedFood['food_name']}'),
            Text('Stall Name: ${widget.selectedFood['stall_name']}'),
            Text('Price: RM${widget.selectedFood['food_price'].toStringAsFixed(2)}'),
            const SizedBox(height: 16),

            // Quantity selection
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

            // Additional notes
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

            // Add to Cart button
            ElevatedButton(
              onPressed: () {
                // Replace this with your logic to add the item to the cart
                addToCart();
              },
              child: Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }

  // Replace this method with your actual logic to add the item to the cart
  void addToCart() {
    print('Added to cart: ${widget.selectedFood['food_name']}, Quantity: $quantity, Notes: $notes');
  }
}