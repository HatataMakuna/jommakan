import 'package:flutter/material.dart';
import 'package:jom_makan/pages/FoodDelivery/creditPayment.dart';
import 'const/themeColor.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Header Section
              Container(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(1, 10, 10, 15),
                      child: GestureDetector(
                        child: const Icon(
                          Icons.arrow_back,
                          size: 45,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    const Text(
                      'Payment Option',
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                        fontSize: 38,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // Payment Options
              PaymentOptionButton(
                icon: Icons.local_atm,
                text: 'Cash On Delivery',
                onPressed: () {
                  
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (BuildContext context) => CreditCardPage(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              PaymentOptionButton(
                icon: Icons.credit_card,
                text: 'Debit/Credit card',
                onPressed: () {
                  print("Button pressed. Navigating to CreditCardPage.");
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (BuildContext context) => CreditCardPage(),
                    ),
                  );
                },
              ),

              // Image Container
              const SizedBox(height: 150),
              const ImageContainer(),
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentOptionButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  const PaymentOptionButton({
    required this.icon,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: paymentOptionButtonDecoration,
      width: 245.0,
      child: Align(
        alignment: Alignment.centerRight,
        child: MaterialButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(
                icon,
                color: Colors.black,
              ),
              const SizedBox(width: 25.0),
              Text(
                text,
                style: const TextStyle(color: Colors.black, fontSize: 20.0),
              ),
            ],
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}

class ImageContainer extends StatelessWidget {
  const ImageContainer();

  @override
  Widget build(BuildContext context) {
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
}

// Constants
final BoxDecoration paymentOptionButtonDecoration = BoxDecoration(
  color: Themes.color,
  borderRadius: BorderRadius.circular(30.0),
  boxShadow: [BoxShadow(blurRadius: 2, color: Themes.color)],
);
