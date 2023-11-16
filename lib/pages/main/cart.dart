import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});
  
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
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
    return const Center(
      child: Text('Cart Page Content'),
    );
    /* ListView.builder(
      itemCount: _cart.items.length,
      itemBuilder: (context, index) {
        final foodItem = _cart.items[index];
        return ListTile(
          title: Text(foodItem.name),
          subtitle: Text('\$${foodItem.price.toStringAsFixed(2)}'),
          trailing: IconButton(
            icon: const Icon(Icons.remove_shopping_cart),
            onPressed: () {
              setState(() {
                _cart.removeFromCart(foodItem);
              });
            },
          ),
        );
      },
    ); */
  }

  /* Widget _buildBottomBar() {
    return BottomAppBar(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total: \$${_cart.calculateTotal().toStringAsFixed(2)}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Implement checkout logic here
                _checkout();
              },
              child: const Text('Checkout'),
            ),
          ],
        ),
      ),
    );
  }
 */
  void _checkout() {
    // Implement your checkout logic here
    // For example, you can navigate to a checkout page
    Navigator.pushNamed(context, '/checkout');
  }
}