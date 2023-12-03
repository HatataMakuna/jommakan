import 'package:flutter/material.dart';
import 'package:jom_makan/pages/Booking/booking_main.dart';
import 'package:jom_makan/pages/FoodDelivery/address.dart';
import 'package:jom_makan/pages/FoodDelivery/credit_payment.dart';
import 'package:jom_makan/pages/FoodDelivery/payment_methods.dart';
import 'package:jom_makan/pages/FoodDelivery/payment_success.dart';
import 'package:jom_makan/pages/PreOrder/time.dart';
import 'package:jom_makan/stores/user_provider.dart';
import 'package:provider/provider.dart';

/*
TODO:
preorder => link to select time
delivery => show delivery charges
else => link to booking seat
*/

class PaymentPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  final bool noCutlery;
  final String orderMethod;
  //String selectedPaymentMethod;

  const PaymentPage({super.key, required this.cartItems, required this.noCutlery, required this.orderMethod});

  @override
  State<StatefulWidget> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  double totalPrice = 0.0;
  ValueNotifier<String> selectedAddressNotifier = ValueNotifier<String>('');
  ValueNotifier<String> selectedPaymentMethodNotifier = ValueNotifier<String>('');
  //String paymentMethod = '';
  
  @override
  void initState() {
    super.initState();
    _calculateTotalPrice();
  }

  void _calculateTotalPrice() {
    // Check if the widget is still mounted before calling setState
    if (mounted) {
      setState(() {
        // Reset totalPrice to zero before recalculating
        totalPrice = 0.0;

        // Recalculate totalPrice based on the new cart items
        for (final cartItem in widget.cartItems) {
          totalPrice += int.parse(cartItem['quantity']) * double.parse(cartItem['food_price']);
        }
      });
    }
  }

  // Get icons for payment methods
  IconData getPaymentMethodIcon() {
    switch (selectedPaymentMethodNotifier.value) {
      case 'Credit Card':
        return Icons.credit_card;
      case 'PayPal':
        return Icons.payment;
      case 'Cash':
        return Icons.attach_money;
      default:
        return Icons.local_atm;
    }
  }

  void handlePayment() {
    switch (selectedPaymentMethodNotifier.value) {
      case 'Debit/Credit card':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CreditCardPage(
              noCutlery: widget.noCutlery, cartItems: widget.cartItems,
              totalPrice: totalPrice, orderMethod: widget.orderMethod,
              address: selectedAddressNotifier.value
            ),
          ),
        );
        break;
      case 'E-wallet':
        navigateToProcessPaymentPage();
        break;
      case 'Cash On Delivery':
        navigateToProcessPaymentPage();
        break;
      default:
        navigateToPaymentMethodPage();
        //print('Please select a payment method');
    }
  }

  String getPaymentButtonLabel() {
    switch (selectedPaymentMethodNotifier.value) {
      case 'Debit/Credit card':
        return 'Pay with Debit/Credit Card';
      case 'E-wallet':
        return 'Pay with E-wallet';
      case 'Cash On Delivery':
        return 'Pay with Cash';
      default:
        return 'Select Payment Method';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(primarySwatch: Colors.red),
      child: Scaffold(
        appBar: AppBar(
          title: ValueListenableBuilder(
            valueListenable: selectedPaymentMethodNotifier,
            builder: (context, selectedPaymentMethod, child) {
              if (selectedPaymentMethod.isNotEmpty) {
                return Row(
                  children: [
                    Icon(getPaymentMethodIcon(), color: Colors.white),
                    const SizedBox(width: 8),
                    ValueListenableBuilder(
                      valueListenable: selectedPaymentMethodNotifier,
                      builder: (context, selectedPaymentMethod, child) {
                        return Text(
                          'Selected Payment Method: $selectedPaymentMethod',
                          style: const TextStyle(color: Colors.white),
                        );
                      }
                    )
                  ],
                );
              } else {
                return const Text(
                  'Selected Payment Method: None',
                  style: TextStyle(color: Colors.white),
                );
              }
            }
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // delivery only content
                if (widget.orderMethod == 'Delivery') ...[
                  _loadDeliveryContent(),
                  const Divider(),
                ]
                // pre-order only content
                else if (widget.orderMethod == 'Pre-Order') ...[
                  _selectPreOrderTimeButton(),
                  const Divider(),
                ]
                // order now and self pick-up content
                else ...[
                  _bookSeatButton(),
                  const Divider(),
                ],

                // display cart items
                _loadOrderSummary(),
                const Divider(),
                // payment methods link
                _loadPaymentMethods(),
                const Divider(),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => handlePayment(),
                    child: Text(getPaymentButtonLabel()),
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }

  // Select time [for Pre-Order only]
  Widget _selectPreOrderTimeButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context, MaterialPageRoute(
            builder: (context) => PreOrderPage(orderMethod: widget.orderMethod),
          ),
        );
      },
      child: const Text('Select Pre-Order Time'),
    );
  }

  // Book seats [for Order Now and Self Pick-Up]
  Widget _bookSeatButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context, MaterialPageRoute(
            builder: (context) => const BusLayout(),
          ),
        );
      },
      child: const Text('Book Your Seat'),
    );
  }

  Widget _loadSeatsContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Selected Seats',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        // display seats
      ],
    );
  }

  // Delivery address [for Delivery only]
  Widget _loadDeliveryContent() {
    return Column(
      children: [
        const Text(
          'Delivery Address',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: selectedAddressNotifier,
                builder: (context, selectedAddress, child) {
                  return Text(
                    selectedAddress.isNotEmpty ? selectedAddress : 'No address selected',
                    style: const TextStyle(fontSize: 16),
                  );
                }
              ),
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                // Navigate to the AddressPage when the edit icon is pressed
                navigateToAddressPage();
              },
            ),
          ],
        ),
      ],
    );
  }

  // Order Summary section
  Widget _loadOrderSummary() {
    return Column(
      children: [
        const Text(
          'Order Summary',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        // Load cart list
        // ignore: sized_box_for_whitespace
        _buildCartList(),
        const SizedBox(height: 10),
        // Load Total Price
        _buildTotalPrice(),
        const SizedBox(height: 10),
        // Load No Cutlery Request
        _buildNoCutlery(),
      ],
    );
  }

  Widget _buildCartList() {
    List<Map<String, dynamic>> cartItems = widget.cartItems;

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
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
          leading: Image(
            image: AssetImage('images/foods/${cartItem['food_image']}'),
            width: 80,
            height: 80,
          ),
          title: Text(
            cartItem['food_name'] ?? '',
            style: const TextStyle(fontSize: 12),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Quantity: ${cartItem['quantity'] ?? ''}',
                style: const TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 8),
              _buildPreferencesList(preferences),
              const SizedBox(height: 8),
              _buildAdditionalNotes(cartItem),
            ],
          ),
          // ignore: sized_box_for_whitespace
          trailing: Text(
            'Price: RM ${(int.parse(cartItem['quantity']) * double.parse(cartItem['food_price'])).toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 12),
          ),
        );
      },
    );
  }

  Widget _buildPreferencesList(List<String> preferences) {
    if (preferences.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Additional Preferences:',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          for (String preference in preferences)
            Text(preference, style: const TextStyle(fontSize: 12)),
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
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
          Text(cartItem['notes'].toString(), style: const TextStyle(fontSize: 12)),
        ],
      );
    }
  }

  Widget _buildTotalPrice() {
    return ListTile(
      leading: const Text(
        'Total Price: ',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: Text(
        'RM ${totalPrice.toStringAsFixed(2)}',
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.red,
        ),
      ),
    );
  }

  Widget _buildNoCutlery() {
    String noCutleryRequest;
    if (widget.noCutlery) {
      noCutleryRequest = 'Yes';
    } else {
      noCutleryRequest = 'No';
    }

    return ListTile(
      leading: const Text(
        'No Cutlery Requested?',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: Text(
        noCutleryRequest,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }

  // Payment Method section
  Widget _loadPaymentMethods() {
    return Column(
      children: [
        const Text(
          'Payment Method',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () => navigateToPaymentMethodPage(),
          child: const Row(
            children: [
              Icon(Icons.local_atm),
              SizedBox(width: 8),
              Text('Select Payment Method'),
            ],
          ),
        ),
      ],
    );
  }

  // Navigations
  void navigateToAddressPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddressPage(selectedAddressNotifier: selectedAddressNotifier),
      ),
    );

    if (result != null && result is String) {
      setState(() {
        selectedAddressNotifier.value = result; // Update the selected address
      });
      //print('Selected Address: $result');
    }
  }

  void navigateToPaymentMethodPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PaymentMethodPage()),
    );

    if (result != null && result is String) {
      setState(() {
        selectedPaymentMethodNotifier.value = result;
        //paymentMethod = result;
      });
    }
  }

  void navigateToProcessPaymentPage() async {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => PaymentSuccessPage(
        userID: Provider.of<UserProvider>(context, listen: false).userID!,
        noCutlery: widget.noCutlery,
        cartItems: widget.cartItems,
        paymentMethod: selectedPaymentMethodNotifier.value,
        totalPrice: totalPrice,
        orderMethod: widget.orderMethod,
        address: selectedAddressNotifier.value,
      ),
    ));
  }
}