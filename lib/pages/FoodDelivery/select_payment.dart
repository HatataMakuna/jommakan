import 'package:flutter/material.dart';
import 'package:jom_makan/pages/FoodDelivery/payment_main.dart';


class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String selectedPaymentMethod = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: selectedPaymentMethod.isNotEmpty
            ? Text('Selected Payment Method: $selectedPaymentMethod')
            : const Text('Select Payment Method'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Order Summary',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Add widgets to display order summary here
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
              onPressed: () async {
                // Navigate to PaymentMethodPage and wait for result
                String selectedMethod = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentMethodPage(),
                  ),
                );

                // Update the selected payment method
                //if (selectedMethod != null) {
                setState(() {
                  selectedPaymentMethod = selectedMethod;
                });
                //}
              },
              child: Text(
                selectedPaymentMethod.isNotEmpty
                    ? 'Selected Payment Method: $selectedPaymentMethod'
                    : 'Select Payment Method',
              ),
            ),

            const Divider(),

            // Display a button with the selected payment method
            if (selectedPaymentMethod.isNotEmpty)
              ElevatedButton(
                onPressed: () {
                  // Implement payment processing logic
                  // This is a mockup, so you can print a message or show a dialog
                  print('Payment processed successfully!');
                },
                child: Text('Make Payment with $selectedPaymentMethod'),
              ),

            const Spacer(),
          ],
        ),
      ),
    );
  }
}
