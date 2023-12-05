import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jom_makan/pages/FoodDelivery/location/map.dart';
import 'package:jom_makan/pages/foodDelivery/widgets/profile_tile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jom_makan/pages/main/home.dart';
import 'package:jom_makan/server/order/place_order.dart';
import 'package:jom_makan/server/payment/add_payment.dart';
import 'package:jom_makan/server/rider/add_delivery.dart';
import 'package:jom_makan/stores/user_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MaterialApp(
      home: ChangeNotifierProvider(
        create: (context) => UserProvider(),
        child: const PaymentSuccessPage(
          userID: 1,
          noCutlery: false,
          cartItems: [],
          paymentMethod: 'E-wallet',
          totalPrice: 0.0,
          orderMethod: 'Delivery',
          address: '',
        ),
      )
    ),
  );
}

class PaymentSuccessPage extends StatefulWidget {
  final int userID;
  final bool noCutlery;
  final List<Map<String, dynamic>> cartItems;
  final String paymentMethod;
  final double totalPrice;
  final String orderMethod;
  final String address;

  const PaymentSuccessPage({
    super.key, required this.userID, required this.noCutlery,
    required this.cartItems, required this.paymentMethod,
    required this.totalPrice, required this.orderMethod, required this.address,
  });

  /*
  required int userID, required bool noCutlery,
    required List<Map<String, dynamic>> cartItems,
    required String paymentMethod,

    userID: Provider.of<UserProvider>(context, listen: false).userID!,
    noCutlery: 
  */

  @override
  State<StatefulWidget> createState() => _PaymentSuccessPageState();
}

class _PaymentSuccessPageState extends State<PaymentSuccessPage> {
  final PlaceOrder _placeOrder = PlaceOrder();
  final AddPayment _addPayment = AddPayment();
  final AddDelivery _addDelivery = AddDelivery();
  bool isDataAvailable = true;
  late String formattedTime;  // Define formattedTime variable

  @override
  void initState() {
    super.initState();
    //formattedTime = _formatTime(DateTime.now());  // Initialize formattedTime in initState
  }

  Widget bodyData() => Center(
    child: isDataAvailable
          ? ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
                backgroundColor: Colors.amber,
              ),
              onPressed: () => processOrder(),
              child: const Text("Process Payment"),
            )
          : const CircularProgressIndicator(),
  );

  void processOrder() async {
    try {
      setState(() {
        isDataAvailable = false;
      });

      // Perform the place order logic
      bool isSuccess = await _placeOrder.placeOrder(
        userID: widget.userID, noCutlery: widget.noCutlery,
        cartItems: widget.cartItems, paymentMethod: widget.paymentMethod,
        totalPrice: widget.totalPrice, orderMethod: widget.orderMethod,
      );

      // If the order method is Delivery, add to Delivery database
      if (widget.orderMethod == 'Delivery') {
        await _addDelivery.addDelivery(orderID: _placeOrder.orderID, address: widget.address);
      }

      setState(() {
        if (isSuccess) {
          Future.delayed(const Duration(seconds: 3)).then((_) => goToDialog());
        } else {
          // Display the error while processing order message
        }
      });
    } catch (error) {
      // Handle errors thrown during the asynchronous operation
      setState(() {
        isDataAvailable = false; // Set loading state to false
        // You can show an error message or perform other actions here
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    /* Future.delayed(Duration.zero, () {
      Provider.of<UserProvider>(context, listen: false).setUserName('Testing');
      Provider.of<UserProvider>(context, listen: false).setUserID(1);
      Provider.of<UserProvider>(context, listen: false).setUserRole('User');
      Provider.of<UserProvider>(context, listen: false).setUserEmail('testing@tarc.edu.my');
    }); */

    return Scaffold(
      body: bodyData(),
    );
  }

  void goToDialog() {
    setState(() {
      isDataAvailable = true;
    });
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              successTicket(),
              const SizedBox(
                height: 10.0,
              ),
              FloatingActionButton(
                backgroundColor: Colors.black,
                child: const Icon(
                  Icons.clear,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      )
    );
  }

  Widget successTicket() {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        child: Material(
          clipBehavior: Clip.antiAlias,
          elevation: 2.0,
          borderRadius: BorderRadius.circular(4.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ProfileTile(
                  title: "Thank You!",
                  textColor: Colors.black,
                  subtitle: "Your transaction was successful",
                ),
                ListTile(
                  title: const Text("Date"),
                  subtitle: Text(_addPayment.paymentDate),
                  trailing: Text(_addPayment.paymentTime),
                ),
                ListTile(
                  title: Text(Provider.of<UserProvider>(context, listen: false).userName!),
                  subtitle: Text(Provider.of<UserProvider>(context, listen: false).userEmail!),
                  trailing: const CircleAvatar(
                    radius: 20.0,
                    backgroundImage: NetworkImage(
                      "https://lh3.googleusercontent.com/-pkPFE8SoLfI/XCkghv3J5SI/AAAAAAAAApg/0wY2TMfjTvAlJHA5iQ0BQ-e5u0jvwCIzACEwYBhgL/w138-h140-p/Screenshot_2018-12-19-11-42-04-053_com.instagram.android.png"
                    ),
                  ),
                ),
                ListTile(
                  title: const Text("Amount"),
                  subtitle: Text("RM ${widget.totalPrice.toStringAsFixed(2)}"),
                  trailing: const Text("Completed"),
                ),
                Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 0.0,
                  color: Colors.grey.shade300,
                  child: ListTile(
                    leading: const Icon(
                      FontAwesomeIcons.ccVisa,
                      color: Color(0xfffeb324),
                    ),
                    title: Text(widget.paymentMethod),
                    subtitle: const Text("PNB Card ending ***6"), // TODO: Change the subtitle depend on payment method
                  ),
                ),
                const SizedBox(height: 10),
                if (widget.orderMethod == 'Delivery') ...[
                  GestureDetector(
                    child: Container(
                      height: 40.0,
                      width: 220,
                      decoration: BoxDecoration(
                        color: const Color(0xfffeb324),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: const Center(
                        child: Text(
                          "Track Your Order",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => const Location(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                ],
                GestureDetector(
                  child: Container(
                    height: 40,
                    width: 220,
                    decoration: BoxDecoration(
                      color: const Color(0xfffeb324),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Center(
                      child: Text(
                        'Return to Home Page',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context, MaterialPageRoute(
                        builder: (BuildContext context) => const HomePage(),
                      ),
                    );
                  }
                ),
              ],
            ),
          ),
        ),
  );
  }

  /* String _formatTime(DateTime dateTime) {
    return "${_formatTwoDigitNumber(dateTime.hour)}:${_formatTwoDigitNumber(dateTime.minute)} ${_getPeriod(dateTime.hour)}";
  }

  String _formatTwoDigitNumber(int number) {
    return number.toString().padLeft(2, '0');
  }

  String _getPeriod(int hour) {
    return hour < 12 ? 'AM' : 'PM';
  } */
}
