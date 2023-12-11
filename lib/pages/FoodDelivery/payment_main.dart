import 'package:flutter/material.dart';
import 'package:jom_makan/pages/Booking/booking_main.dart';
import 'package:jom_makan/pages/FoodDelivery/address.dart';
import 'package:jom_makan/pages/FoodDelivery/credit_payment.dart';
import 'package:jom_makan/pages/FoodDelivery/payment_methods.dart';
import 'package:jom_makan/pages/FoodDelivery/payment_success.dart';
import 'package:jom_makan/pages/PreOrder/time.dart';
import 'package:jom_makan/stores/user_provider.dart';
import 'package:provider/provider.dart';

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
  double deliveryFees = 0.0;
  double subtotal = 0.0;
  ValueNotifier<String> selectedAddressNotifier = ValueNotifier<String>('');
  ValueNotifier<String> selectedPaymentMethodNotifier = ValueNotifier<String>('');
  ValueNotifier<String> selectedTimeNotifier = ValueNotifier<String>('');
  ValueNotifier<String> selectedSeatsNotifier = ValueNotifier<String>('');
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
        deliveryFees = 0.0;
        subtotal = 0.0;

        // Recalculate totalPrice based on the new cart items
        for (final cartItem in widget.cartItems) {
          totalPrice += int.parse(cartItem['quantity']) * double.parse(cartItem['food_price']);

          // If the order method is delivery, extra 5% delivery charges is applied
          if (widget.orderMethod == 'Delivery') {
            deliveryFees = totalPrice * 0.05;
            subtotal = double.parse((totalPrice + deliveryFees).toStringAsFixed(1));
          }
          // Else, no extra charges is applied
          else {
            subtotal = double.parse(totalPrice.toStringAsFixed(1));
          }
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
    print(selectedAddressNotifier.value);
    print(selectedTimeNotifier.value);
    print(selectedSeatsNotifier.value);
    switch (selectedPaymentMethodNotifier.value) {
      case 'Debit/Credit card':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CreditCardPage(
              noCutlery: widget.noCutlery, cartItems: widget.cartItems,
              totalPrice: totalPrice, orderMethod: widget.orderMethod,
              address: selectedAddressNotifier.value,
              selectedSeatsNotifier: selectedSeatsNotifier,
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
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Pre-Order Time:'),
                      ValueListenableBuilder(
                        valueListenable: selectedTimeNotifier,
                        builder: (context, selectedTime, child) {
                          return Text(
                            selectedTime.isNotEmpty ? selectedTime : 'Not selected',
                            style: const TextStyle(fontSize: 14),
                          );
                        },
                      ),
                    ],
                  ),
                  const Divider(),
                ]
                // order now and self pick-up content
                else ...[
                  _bookSeatButton(),
                  const SizedBox(height: 12),
                  _loadSeatsContent(),
                  // display seat numbers
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
                    onPressed: () => selectedAddressNotifier.value != '' || 
                      selectedTimeNotifier.value != '' || 
                      selectedSeatsNotifier.value != ''
                      ? handlePayment()
                      : displayIncompleteStepMessage(),
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
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => navigateToSelectTimePage(),
        child: const Text('Select Pre-Order Time'),
      ),
    );
  }

  // Book seats [for Order Now and Self Pick-Up]
  Widget _bookSeatButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => navigateToSelectSeatPage(),
        child: const Text('Book Your Seat'),
      ),
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
        // display seat numbers
        ValueListenableBuilder(
          valueListenable: selectedSeatsNotifier,
          builder: (context, selectedSeat, child) {
            //print('Rebuilding ValueListenableBuilder: $selectedSeat');
            return Text(
              selectedSeat.isNotEmpty ? selectedSeat : 'Not selected',
              style: const TextStyle(fontSize: 14),
            );
          }
        ),
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
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ValueListenableBuilder(
              valueListenable: selectedAddressNotifier,
              builder: (context, selectedAddress, child) {
                return Text(
                  selectedAddress.isNotEmpty ? selectedAddress : 'No address selected',
                  style: const TextStyle(fontSize: 12),
                );
              }
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

  void displayIncompleteStepMessage() {
    switch (widget.orderMethod) {
      case 'Pre-Order': 
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select your pre-order time'),
            duration: Duration(seconds: 2),
          ),
        );
        break;
      case 'Delivery':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter your address'),
            duration: Duration(seconds: 2),
          ),
        );
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select your seat'),
            duration: Duration(seconds: 2),
          ),
        );
        break;
    }
  }

  // Order Summary section
  Widget _loadOrderSummary() {
    return Column(
      children: [
        const Text(
          'Order Summary',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        // Load cart list
        // ignore: sized_box_for_whitespace
        Container(
          height: 200,
          child: _buildCartList(),
        ),
        const SizedBox(height: 8),
        // Load Total Price
        _buildTotalPrice(),
        const SizedBox(height: 8),
        _buildDeliveryFees(),
        const SizedBox(height: 8),
        _buildSubtotal(),
        const SizedBox(height: 8),
        // Load No Cutlery Request
        _buildNoCutlery(),
      ],
    );
  }

  Widget _buildCartList() {
    List<Map<String, dynamic>> cartItems = widget.cartItems;

    return SingleChildScrollView(
      child: Column(
        children: cartItems.map((cartItem) {
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
        }).toList(),
      ),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Total Price: ',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'RM ${totalPrice.toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
      ],
    );
  }

  Widget _buildDeliveryFees() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Delivery Fees: ',
          style: TextStyle(fontSize: 13),
        ),
        Text(
          'RM ${deliveryFees.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 13),
        ),
      ],
    );
  }

  Widget _buildSubtotal() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Subtotal: (after rounding adjustment)',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'RM ${subtotal.toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
      ],
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
          fontSize: 13,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: Text(
        noCutleryRequest,
        style: const TextStyle(fontSize: 13),
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
  void navigateToSelectSeatPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BusLayout(selectedSeatsNotifier: selectedSeatsNotifier),
      ),
    );

    if (result != null && result is String) {
      setState(() {
        selectedSeatsNotifier.value = result;
      });
    }
  }

  void navigateToSelectTimePage() async {
    final result = await Navigator.push(
      context, MaterialPageRoute(
        builder: (context) {
          return PreOrderPage(
            orderMethod: widget.orderMethod, selectedTimeNotifier: selectedTimeNotifier
          );
        }
      ),
    );

    if (result != null && result is String) {
      setState(() {
        selectedTimeNotifier.value = result;
      });
    }
  }

  void navigateToAddressPage() async {
    final result = await Navigator.push(
      context, MaterialPageRoute(
        builder: (context) => AddressPage(selectedAddressNotifier: selectedAddressNotifier),
      ),
    );

    if (result != null && result is String) {
      setState(() {
        selectedAddressNotifier.value = result; // Update the selected address
      });
    }
  }

  void navigateToPaymentMethodPage() async {
    final result = await Navigator.push(
      context, MaterialPageRoute(builder: (context) => const PaymentMethodPage()),
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
        totalPrice: subtotal,
        orderMethod: widget.orderMethod,
        address: selectedAddressNotifier.value,
        seatNumbers: selectedSeatsNotifier.value,
      ),
    ));
  }
}