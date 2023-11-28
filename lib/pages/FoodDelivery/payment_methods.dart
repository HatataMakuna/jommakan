// PAYMENT OPTIONS
import 'package:flutter/material.dart';
import 'package:jom_makan/components/payment/payment_option_button.dart';

void main() {
  runApp(const PaymentMethodPage());
}

class PaymentMethodPage extends StatelessWidget {
  const PaymentMethodPage({super.key});

  //ValueNotifier<String> selectedPaymentMethodNotifier = ValueNotifier<String>('');
  //String selectedPaymentMethod;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(primarySwatch: Colors.red),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Payment Options'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        resizeToAvoidBottomInset: false,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  // Payment Options
                  const Text(
                    'Choose Your Payment Method',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Cash On Delivery
                  PaymentOptionButton(
                    icon: Icons.local_atm,
                    text: 'Cash On Delivery',
                    onPressed: () {
                      _returnToPreviousPage(context, 'Cash On Delivery');
                    },
                  ),
                  const SizedBox(height: 20),
                  // Debit or Credit Card
                  PaymentOptionButton(
                    icon: Icons.credit_card,
                    text: 'Debit/Credit card',
                    onPressed: () {
                      print("Button pressed. Navigating to CreditCardPage.");
                      _returnToPreviousPage(context, 'Debit/Credit card');
                    },
                  ),
                  const SizedBox(height: 20),
                  // E-Wallet
                  PaymentOptionButton(
                    icon: Icons.credit_card,
                    text: 'E-wallet',
                    onPressed: () {
                      //print("Button pressed. Navigating to CreditCardPage.");
                      _returnToPreviousPage(context, 'E-wallet');
                    },
                  ),
                  // Image Container
                  const SizedBox(height: 20),
                  _loadImageContainer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _loadImageContainer() {
    return Container(
      height: 350,
      width: 340,
      decoration: const BoxDecoration(
        color: Colors.white24,
        image: DecorationImage(
          image: AssetImage('assets/moto.png'),
          fit: BoxFit.fill,
        ),
        shape: BoxShape.rectangle,
      ),
    );
  }

  // Navigations
  void _returnToPreviousPage(BuildContext context, String paymentMethod) {
    Navigator.pop(context, paymentMethod);
  }
}