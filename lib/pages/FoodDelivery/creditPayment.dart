import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jom_makan/pages/FoodDelivery/payment_success.dart';

class CreditCardPage extends StatefulWidget {
  @override
  _CreditCardPageState createState() => _CreditCardPageState();
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
              decoration: const InputDecoration(
                labelText: "Credit Card Number",
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
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
              decoration: const InputDecoration(
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                labelText: "MM/YY",
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
              decoration: const InputDecoration(
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                labelText: "CVV",
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
              decoration: const InputDecoration(
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                labelText: "Name on card",
                border: OutlineInputBorder(),
              ),
            ),
            // Additional fields for account details
            TextField(
              controller: accountNumberController,
              keyboardType: TextInputType.number,
              maxLength: 16,
              style: const TextStyle(fontFamily: 'Raleway', color: Colors.black),
              decoration: const InputDecoration(
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                labelText: "Account Number",
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: bankNameController,
              keyboardType: TextInputType.text,
              maxLength: 20,
              style: const TextStyle(fontFamily: 'Raleway', color: Colors.black),
              decoration: const InputDecoration(
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                labelText: "Bank Name",
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      );

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

  Widget floatingBar() => Ink(
        decoration: const ShapeDecoration(
          shape: StadiumBorder(),
        ),
        child: FloatingActionButton.extended(
          onPressed: ()async{
                // Navigate to PaymentMethodPage and wait for result
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentSuccessPage(),
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

  ProfileTile({required this.title, required this.subtitle, required this.textColor});

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