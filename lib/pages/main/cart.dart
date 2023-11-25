import 'package:flutter/material.dart';
import 'package:jom_makan/pages/cart/edit_cart.dart';
import 'package:jom_makan/server/cart/get_cart.dart';
import 'package:jom_makan/stores/user_provider.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});
  
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final GetCart _getCart = GetCart();
  List<Map<String, dynamic>> _cartItems = [];

  // for calculate total price
  double totalPrice = 0.0;
  bool isNoCutlery = false;

  @override
  void initState() {
    super.initState();
    _loadCartItems();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _loadCartItems() async {
    try {
      final cartItems = await _getCart.getCart(Provider.of<UserProvider>(context, listen: false).userID!);

      // Check if the widget is still mounted before calling setState
      if (mounted) {
        setState(() {
          _cartItems = cartItems;

          // Reset totalPrice to zero before recalculating
          totalPrice = 0.0;

          // Recalculate totalPrice based on the new cart items
          for (final cartItem in _cartItems) {
            totalPrice += int.parse(cartItem['quantity']) * double.parse(cartItem['food_price']);
          }
        });
      }
    } catch (error) {
      print('Error loading cart items: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: _initalizeCartPage(),
    );
  }

  Widget _initalizeCartPage() {
    if (_cartItems.isEmpty) {
      return const Center(child: Text('No items in the cart.'));
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            _buildCartContent(),
            const SizedBox(height: 10),
            _buildTotalPrice(),
            const SizedBox(height: 10),
            _buildNoCutleryRequest(),
            const SizedBox(height: 10),
            _checkoutButton(),
            const SizedBox(height: 10),
          ],
        ),
      );
    }
  }

  Widget _buildCartContent() {
    return Card(
      //margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 5,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
        side: BorderSide(
          color: Colors.grey,
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Set mainAxisSize to min
        children: [
          const SizedBox(height: 12),
          const Text(
            'Cart List',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          // ignore: sized_box_for_whitespace
          Container(
            height: 250, // adjust depend on other column usages
            child: _buildCartList(_cartItems),
          ),
        ],
      ),
    );
  }

  Widget _buildCartList(List<Map<String, dynamic>> cartItems) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final cartItem = cartItems[index];
          
          List<String> preferences = [
            if (int.parse(cartItem['no_vege']) == 1) 'No Vegetarian',
            if (int.parse(cartItem['extra_vege']) == 1) 'Extra Vegetarian',
            if (int.parse(cartItem['no_spicy']) == 1) 'No Spicy',
            if (int.parse(cartItem['extra_spicy']) == 1) 'Extra Spicy',
          ].where((preference) => preference.isNotEmpty).toList();

          return ListTile(
            // leading: image
            leading: Image(
              image: AssetImage('images/foods/${cartItem['food_image']}'),
              width: 100,
              height: 100,
            ),
            title: Text(cartItem['food_name'] ?? ''),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Quantity: ${cartItem['quantity'] ?? ''}',),
                const SizedBox(height: 8),
                _buildPreferencesDropdown(preferences),
                const SizedBox(height: 8),
                _buildAdditionalNotes(cartItem),
              ],
            ),
            // ignore: sized_box_for_whitespace
            trailing: Container(
              width: 150,
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      // Navigate to the food details page for editing
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditCartPage(cartItem: cartItem),
                        ),
                      );
                    }
                  ),
                  const SizedBox(width: 8),
                  Text('Price: RM ${(int.parse(cartItem['quantity']) * double.parse(cartItem['food_price'])).toStringAsFixed(2)}'),
                ],
              ),
            ),
          );
        },
      );
  }

  Widget _buildPreferencesDropdown(List<String> preferences) {
    if (preferences.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Additional Preferences:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          for (String preference in preferences)
            Text(preference),
        ]
      );
    } else {
      return const SizedBox.shrink(); // Empty container if there are no preferences
    }
  }
  
  Widget _buildAdditionalNotes(Map<String, dynamic> cartItem) {
    if (cartItem['notes'].toString() == 'null' || cartItem['notes'].toString().isEmpty) {
      return const SizedBox.shrink(); // Empty container if the additional notes is empty or NULL
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Additional Notes:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(cartItem['notes'].toString()),
        ],
      );
    }
  }

  Widget _buildTotalPrice() {
    return Card(
      elevation: 5,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
        side: BorderSide(
          color: Colors.grey,
          width: 1,
        ),
      ),
      child: ListTile(
        leading: const Text(
          'Total Price:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Text(
          'RM ${totalPrice.toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }

  Widget _buildNoCutleryRequest() {
    return Card(
      elevation: 5,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
        side: BorderSide(
          color: Colors.grey,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'No Cutlery Request:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Switch(
                  value: isNoCutlery, // Set the initial value based on user's preference
                  onChanged: (value) {
                    setState(() {
                      isNoCutlery = !isNoCutlery;
                    });
                  },
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    'We\'ll let the stall know you request not to provide cutlery. Thanks for reducing single-use plastic.',
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _checkoutButton() {
    return ElevatedButton(
      onPressed: _checkout,
      child: const Text('Checkout'),
    );
  }

  // TODO: Do something with the checkout logic; possibly need to merge
  void _checkout() {
    // Implement your checkout logic here
    // For example, you can navigate to a checkout page
    Navigator.pushNamed(context, '/checkout');
  }
}