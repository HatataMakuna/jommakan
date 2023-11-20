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
      appBar: AppBar(
        title: const Text('Cart'),
        backgroundColor: Colors.white,
      ),
      body: _buildCartContent(),
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
            Expanded(
              child: _buildCartList(_cartItems),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildCartList(List<Map<String, dynamic>> cartItems) {
    return ListView.builder(
      itemCount: cartItems.length,
      itemBuilder: (context, index) {
        final cartItem = cartItems[index];
        
        List<String> preferences = [
          if (cartItem['no_vege'] == 1) 'No Vegeterian',
          if (cartItem['extra_vege'] == 1) 'Extra Vegeterian',
          if (cartItem['no_spicy'] == 1) 'No Spicy',
          if (cartItem['extra_spicy'] == 1) 'Extra Spicy',
        ];

        return ListTile(
          // leading: image
          leading: Image(
            image: AssetImage('images/foods/' + cartItem['food_image']),
            width: 100,
            height: 100,
          ),
          title: Text(cartItem['food_name'] ?? ''),
          subtitle: Column(
            children: [
              Text(
                'Quantity: ${cartItem['quantity'] ?? ''}',
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 8),
              _buildPreferencesDropdown(preferences),
            ],
          ),
          trailing: Text('Price: RM ${(int.parse(cartItem['quantity']) * double.parse(cartItem['food_price'])).toStringAsFixed(2)}'),
        );
      },
    );
  }

  Widget _buildPreferencesDropdown(List<String> preferences) {
    bool isExpanded = false;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('Additional Preferences:'),
            GestureDetector(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: Visibility(
                visible: isExpanded,
                child: const Icon(Icons.expand_less),
                replacement: const Icon(Icons.expand_more),
              ),
            ),
          ],
        ),
        if (isExpanded)
          ListView.builder(
            shrinkWrap: true,
            itemCount: preferences.length,
            itemBuilder: (context, index) {
              return Text(preferences[index]);
            },
          ),
      ],
    );
  }
  
  void _checkout() {
    // Implement your checkout logic here
    // For example, you can navigate to a checkout page
    Navigator.pushNamed(context, '/checkout');
  }
}