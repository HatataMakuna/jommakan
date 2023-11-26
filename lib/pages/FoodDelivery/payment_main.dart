// TODO: Payment methods link to paymentPage.dart then return here after selecting one method
import 'package:flutter/material.dart';
import 'package:jom_makan/pages/FoodDelivery/address.dart';
import 'creditPayment.dart';

//void main() => runApp(MyApp());

/* class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KFC Payment Page',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: PaymentPage(selectedPaymentMethod: '', selectedAddress: ''), // Initially set to empty strings
    );
  }
} */

class PaymentPage extends StatelessWidget {
  String selectedPaymentMethod = '';
  String selectedAddress = '';
  final List<Map<String, dynamic>> cartItems;

  PaymentPage({super.key, required this.cartItems});
  //PaymentPage({required this.selectedPaymentMethod, required this.selectedAddress});

  IconData getPaymentMethodIcon() {
    switch (selectedPaymentMethod) {
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

  String getPaymentButtonLabel() {
    switch (selectedPaymentMethod) {
      case 'Credit Card':
        return 'Pay with Credit Card';
      case 'PayPal':
        return 'Pay with PayPal';
      case 'Cash':
        return 'Pay with Cash';
      default:
        return 'Select Payment Method';
    }
  }

  void handlePayment(BuildContext context) {
    switch (selectedPaymentMethod) {
      case 'Credit Card':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CreditCardPage(),
          ),
        );
        break;
      case 'PayPal':
        print('Processing PayPal payment...');
        break;
      case 'Cash':
        print('Processing cash payment...');
        break;
      default:
        print('Please select a payment method');
    }
  }

  void navigateToAddressPage(BuildContext context) async {
    /* final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddressPage(initialAddress: selectedAddress),
      ),
    );

    if (result != null && result is String) {
      // Update the selected address if the user has chosen a new address
      // You can also perform any other necessary actions here
      print('Selected Address: $result');
    } */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: selectedPaymentMethod.isNotEmpty
            ? Row(
                children: [
                  Icon(getPaymentMethodIcon()),
                  SizedBox(width: 8),
                  Text('Selected Payment Method: $selectedPaymentMethod'),
                ],
              )
            : const Text('Selected Payment Method: None'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
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
                  child: Text(
                    selectedAddress.isNotEmpty ? selectedAddress : 'No address selected',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    // Navigate to the AddressPage when the edit icon is pressed
                    navigateToAddressPage(context);
                  },
                ),
              ],
            ),
            const Divider(),
            const Text(
              'Order Summary',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            // TODO: Add widgets to display order summary here
            // ...
            const Divider(),
            const Text(
              'Payment Method',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentMethodPage(),
                  ),
                );
              },
              child: Row(
                children: [
                  Icon(getPaymentMethodIcon()),
                  const SizedBox(width: 8),
                  const Text('Select Payment Method'),
                ],
              ),
            ),
            const Divider(),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  handlePayment(context);
                },
                child: Text(getPaymentButtonLabel()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentMethodPage extends StatelessWidget {
  final List<String> paymentMethods = ['Credit Card', 'PayPal', 'Cash'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Payment Method'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Choose a Payment Method',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: paymentMethods.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(paymentMethods[index]),
                    onTap: () {
                      String selectedPaymentMethod = paymentMethods[index];
                      print('Selected Payment Method: $selectedPaymentMethod');

                      /* Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentPage(
                            selectedPaymentMethod: selectedPaymentMethod,
                            selectedAddress: '',
                          ),
                        ),
                      ); */
                    },
                  );
                },
              ),
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}