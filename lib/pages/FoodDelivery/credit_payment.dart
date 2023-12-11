import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jom_makan/pages/FoodDelivery/payment_success.dart';
import 'package:jom_makan/stores/user_provider.dart';
import 'package:provider/provider.dart';

class CreditCardPage extends StatefulWidget {
  final bool noCutlery;
  final List<Map<String, dynamic>> cartItems;
  final double totalPrice;
  final String orderMethod;
  final String address;
  final ValueNotifier<String> selectedSeatsNotifier;

  const CreditCardPage({
    super.key, required this.noCutlery, required this.cartItems,
    required this.totalPrice, required this.orderMethod, required this.address,
    required this.selectedSeatsNotifier,
  });

  @override
  State<StatefulWidget> createState() => _CreditCardPageState();
}


class _CreditCardPageState extends State<CreditCardPage> {
  late BuildContext _context;
  TextEditingController ccController = TextEditingController();
  TextEditingController expController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();

  bool showCardImage = false;

  Widget bodyData() => SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 20),
            Container(
              color: Colors.white10,
              width: 400,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(1, 10, 35, 15),
                    child: GestureDetector(
                      child: const Icon(
                        Icons.arrow_back,
                        size: 38,
                      ),
                      onTap: () {
                        Navigator.pop(_context);
                      },
                    ),
                  ),
                  const Text(
                    'Debit/Credit card',
                    style: TextStyle(
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                        fontSize: 28),
                  ),
                ],
              ),
            ),
            creditCardWidget(),
            fillEntries(),
            toggleCardImage(),
          ],
        ),
      );

  Widget creditCardWidget() {
    var deviceSize = MediaQuery.of(_context).size;
    return Container(
      height: deviceSize.height * 0.3,
      color: Colors.white10,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 3.0,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Container(decoration: const BoxDecoration(color: Colors.blue)), // Set your card color
              showCardImage
                  ? Opacity(
                      opacity: 0.5,
                      child: Image.asset(
                        "assets/map.png", // Replace with your card image path
                        fit: BoxFit.cover,
                      ),
                    )
                  : Container(), // Container for card image (you can replace this with your card image)
              MediaQuery.of(_context).orientation == Orientation.portrait
                  ? cardEntries()
                  : FittedBox(
                      child: cardEntries(),
                    ),
              const Positioned(
                right: 10.0,
                top: 10.0,
                child: Icon(
                  FontAwesomeIcons.ccVisa,
                  size: 30.0,
                  color: Colors.black,
                ),
              ),
              Positioned(
                right: 10.0,
                bottom: 10.0,
                child: Text(
                  nameController.text.isNotEmpty
                      ? nameController.text
                      : "Your Name",
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Raleway',
                      fontSize: 20.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget cardEntries() => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              ccController.text.isNotEmpty
                  ? ccController.text
                  : "**** **** **** ****",
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                ProfileTile(
                  textColor: Colors.black,
                  title: "Expiry",
                  subtitle: expController.text.isNotEmpty
                      ? expController.text
                      : "MM/YY",
                ),
                const SizedBox(
                  width: 30.0,
                ),
                ProfileTile(
                  textColor: Colors.black,
                  title: "CVV",
                  subtitle: cvvController.text.isNotEmpty
                      ? cvvController.text
                      : "***",
                ),
              ],
            ),
          ],
        ),
      );

 Widget fillEntries() => Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            controller: ccController,
            keyboardType: TextInputType.number,
            maxLength: 19,
            style: const TextStyle(fontFamily: 'Raleway', color: Colors.black),
            decoration: InputDecoration(
              labelText: "Credit Card Number",
              labelStyle: TextStyle(fontWeight: FontWeight.bold),
              errorText: _ccText(),
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                showCardImage = false;
              });
            },
          ),
          TextField(
            controller: expController,
            keyboardType: TextInputType.number,
            maxLength: 5,
            style: const TextStyle(fontFamily: 'Raleway', color: Colors.black),
            decoration: InputDecoration(
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              labelText: "MM/YY",
              errorText: _expText(),
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                showCardImage = false;
              });
            },
          ),
          TextField(
            controller: cvvController,
            keyboardType: TextInputType.number,
            maxLength: 3,
            style: const TextStyle(fontFamily: 'Raleway', color: Colors.black),
            decoration: InputDecoration(
              labelStyle: TextStyle(fontWeight: FontWeight.bold),
              labelText: "CVV",
              errorText: _cvvText(),
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                showCardImage = false;
              });
            },
          ),
          TextField(
            controller: nameController,
            keyboardType: TextInputType.text,
            maxLength: 20,
            style: const TextStyle(fontFamily: 'Raleway', color: Colors.black),
            decoration: InputDecoration(
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              labelText: "Name on card",
              errorText: _nameText(),
              border: OutlineInputBorder(),
            ),
          ),
          // Additional fields for account details
          TextField(
            controller: accountNumberController,
            keyboardType: TextInputType.number,
            maxLength: 16,
            style: const TextStyle(fontFamily: 'Raleway', color: Colors.black),
            decoration: InputDecoration(
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              labelText: "Account Number",
              errorText: _accountNumberText(),
              border: OutlineInputBorder(),
            ),
          ),
          TextField(
            controller: bankNameController,
            keyboardType: TextInputType.text,
            maxLength: 20,
            style: const TextStyle(fontFamily: 'Raleway', color: Colors.black),
            decoration: InputDecoration(
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              labelText: "Bank Name",
              errorText: _bankNameText(),
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );

// Validation Functions
String? _ccText() {
  final text = ccController.text;
  if (text.isEmpty) {
    return 'Please enter Credit Card Number';
  }
  // Add additional validation if needed
  return null;
}

String? _expText() {
  final text = expController.text;
  if (text.isEmpty) {
    return 'Please enter MM/YY';
  }
  // Add additional validation if needed
  return null;
}

String? _cvvText() {
  final text = cvvController.text;
  if (text.isEmpty) {
    return 'Please enter CVV';
  }
  // Add additional validation if needed
  return null;
}

String? _nameText() {
  final text = nameController.text;
  if (text.isEmpty) {
    return 'Please enter Name on card';
  }
  // Add additional validation if needed
  return null;
}

String? _accountNumberText() {
  final text = accountNumberController.text;
  if (text.isEmpty) {
    return 'Please enter Account Number';
  }
  // Add additional validation if needed
  return null;
}

String? _bankNameText() {
  final text = bankNameController.text;
  if (text.isEmpty) {
    return 'Please enter Bank Name';
  }
  // Add additional validation if needed
  return null;
}


  Widget toggleCardImage() => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const Text("Show Card Image: "),
            Switch(
              value: showCardImage,
              onChanged: (value) {
                setState(() {
                  showCardImage = value;
                });
              },
            ),
          ],
        ),
      );

  Widget floatingBar() {
    return Ink(
      decoration: const ShapeDecoration(
        shape: StadiumBorder(),
      ),
      child: FloatingActionButton.extended(
        onPressed: () async{
          // Navigate to PaymentMethodPage and wait for result
          Navigator.push(
            context, MaterialPageRoute(
              builder: (context) => PaymentSuccessPage(
                userID: Provider.of<UserProvider>(context, listen: false).userID!,
                noCutlery: widget.noCutlery,
                cartItems: widget.cartItems,
                paymentMethod: 'Debit/Credit Card',
                totalPrice: widget.totalPrice,
                orderMethod: widget.orderMethod,
                address: widget.address,
                seatNumbers: widget.selectedSeatsNotifier.value,
              ),
            ),
          );
        },
        backgroundColor: Colors.blue,
        icon: const Icon(
          Icons.check,
          color: Colors.black,
        ),
        label: const Text(
          "Continue",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: bodyData(),
      floatingActionButton: floatingBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class ProfileTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color textColor;

  const ProfileTile({super.key, required this.title, required this.subtitle, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(fontSize: 12.0, color: textColor),
        ),
        Text(
          subtitle,
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: textColor),
        ),
      ],
    );
  }
}
