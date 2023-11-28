import 'package:flutter/material.dart';
import 'package:jom_makan/consts/payment_option_deco.dart';

class PaymentOptionButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  const PaymentOptionButton({super.key, 
    required this.icon,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: paymentOptionButtonDecoration,
      width: 245.0,
      child: MaterialButton(
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(icon, color: Colors.black),
              const SizedBox(width: 25.0),
              Text(text, style: const TextStyle(color: Colors.black, fontSize: 20.0)),
            ],
          ),
        ),
    );
  }
}
