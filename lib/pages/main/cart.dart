import 'package:flutter/material.dart';
import 'package:jom_makan/server/cart/get_cart.dart';
import 'package:jom_makan/stores/user_provider.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});
  
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final GetCart _getCart = GetCart();
  List<Map<String, dynamic>> _cartItems = [];

  @override
  void initState() {
    super.initState();
    _loadCartItems();
  }

  Future<void> _loadCartItems() async {
    try {
      final cartItems = await _getCart.getCart(Provider.of<UserProvider>(context, listen: false).userID!);
      setState(() {
        _cartItems = cartItems;
      });
    } catch (error) {
      print('Error loading cart items: $error');
      // Handle the error as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            _buildCartContent(),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildCartContent() {
    if (_cartItems.isEmpty) {
      return const Center(child: Text('No items in the cart.'));
    } else {
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
              height: 120, // adjust depend on other column usages
              child: _buildCartList(_cartItems),
            ),
          ],
        ),
      );
    }
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
            image: AssetImage('images/foods/' + cartItem['food_image']),
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
          trailing: Text('Price: RM ${(int.parse(cartItem['quantity']) * double.parse(cartItem['food_price'])).toStringAsFixed(2)}'),
        );
      },
    );
  }

  Widget _buildPreferencesDropdown(List<String> preferences) {
    if (preferences.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Additional Preferences:'),
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
        children: [
          const Text('Additional Notes:'),
          Text(cartItem['notes'].toString()),
        ],
      );
    }
  }

  void _checkout() {
    // Implement your checkout logic here
    // For example, you can navigate to a checkout page
    Navigator.pushNamed(context, '/checkout');
  }
}