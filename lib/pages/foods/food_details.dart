import 'package:flutter/material.dart';
import 'package:jom_makan/server/cart/add_to_cart.dart';
import 'package:jom_makan/server/food/get_ratings.dart';
import 'package:jom_makan/stores/user_provider.dart';
import 'package:provider/provider.dart';

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
  double averageRating = 0.0; // Initialize averageRating
  List<String> preferences = [];
  double totalPrice = 0.0;

  @override
  void initState() {
    super.initState();

    // Call your function to get average ratings directly
    _getAverageRatings();
    // Calculate initial total price
    _calculateTotalPrice();
  }

  // Function to get average ratings and update the state
  void _getAverageRatings() async {
    try {
      List<int> ratings = await _foodRatings.getRatingsForFood(
        int.parse(widget.selectedFood['foodID']),
      );

      double newAverageRating = _foodRatings.calculateAverageRating(ratings);

      // Update the state with the new average rating
      setState(() {
        averageRating = newAverageRating;
      });
    } catch (error) {
      // Handle errors if needed
      print('Error: $error');
    }
  }

  // Calculate total price based on quantity and food price
  void _calculateTotalPrice() {
    setState(() {
      totalPrice = quantity * double.parse(widget.selectedFood['food_price']);
    });
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
              const SizedBox(height: 16),
              titleRating(),
              // quantity
              const SizedBox(height: 16),
              adjustQuantity(),
              const SizedBox(height: 16),
              buildPreferencesCheckboxes(),
              const SizedBox(height: 16),
              buildAdditionalNotesTextField(),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Replace this with your logic to add the item to the cart
                  addToCart();
                },
                child: Text('Add to Cart - RM${totalPrice.toStringAsFixed(2)}'),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget titleRating() {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    '${widget.selectedFood['food_name']} - ${widget.selectedFood['stall_name']}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
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
                  ),
                ),
                const Text(
                  '/ 5.00',
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                  )
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'RM ',
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Text(
                  double.parse(widget.selectedFood['food_price']).toStringAsFixed(2),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget adjustQuantity() {
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Quantity',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    if (quantity > 1) {
                      setState(() {
                        quantity--;
                        _calculateTotalPrice();
                      });
                    }
                  }
                ),
                const SizedBox(width: 8),
                Text(quantity.toString()),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      quantity++;
                      _calculateTotalPrice();
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPreferencesCheckboxes() {
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Preferences:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            buildCheckbox('No vegetarian', 'no vegetarian'),
            buildCheckbox('Extra vegetarian', 'extra vegetarian'),
            buildCheckbox('No Spicy', 'no spicy'),
            buildCheckbox('Extra Spicy', 'extra spicy'),
          ],
        ),
      ),
    );
  }

  Widget buildCheckbox(String title, String preference) {
    return Row(
      children: [
        Checkbox(
          value: preferences.contains(preference),
          onChanged: (bool? value) {
            setState(() {
              if (value != null && value) {
                preferences.add(preference);
              } else {
                preferences.remove(preference);
              }
            });
          },
        ),
        const SizedBox(width: 5),
        Text(title),
      ],
    );
  }

  Widget buildAdditionalNotesTextField() {
    return TextField(
      decoration: const InputDecoration(
        labelText: 'Additional Notes (optional)',
        hintText: 'Add special instructions...',
      ),
      onChanged: (value) {
        setState(() {
          notes = value;
        });
      },
    );
  }

  // Replace this method with your actual logic to add the item to the cart
  /* void addToCart() {
    print('Added to cart: ${widget.selectedFood['food_name']}, Quantity: $quantity, Notes: $notes, Total Price: RM${totalPrice.toStringAsFixed(2)}');
  } */

  void addToCart() async {
    AddToCart addToCart = AddToCart();

    bool noVege = preferences.contains('no vegetarian');
    bool extraVege = preferences.contains('extra vegetarian');
    bool noSpicy = preferences.contains('no spicy');
    bool extraSpicy = preferences.contains('extra spicy');
    print(noVege);
    print(extraVege);
    print(noSpicy);
    print(extraSpicy);

    // Convert to boolean
    noVege = (noVege == 1);
    extraVege = (extraVege == 1);
    noSpicy = (noSpicy == 1);
    extraSpicy = (extraSpicy == 1);

    bool addToCartResult = await addToCart.addToCart(
      userID: Provider.of<UserProvider>(context, listen: false).userID!, // replace with the actual user ID
      foodID: int.parse(widget.selectedFood['foodID']), // replace with the actual food ID
      quantity: quantity,
      noVege: preferences.contains('no vegetarian'),
      extraVege: preferences.contains('extra vegetarian'),
      noSpicy: preferences.contains('no spicy'),
      extraSpicy: preferences.contains('extra spicy'),
      notes: notes,
    );

    if (addToCartResult) {
      print('Item added to cart successfully');
    } else {
      print('Failed to add item to cart');
    }
  }
}