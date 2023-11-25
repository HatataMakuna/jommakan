// TODO: Register as rider
import 'package:flutter/material.dart';
import 'package:jom_makan/server/rider/get_rider_info.dart';
import 'package:jom_makan/server/rider/register_as_rider.dart';
import 'package:jom_makan/stores/user_provider.dart';
import 'package:provider/provider.dart';

class RiderInfo extends StatefulWidget {
  const RiderInfo({super.key});

  @override
  State<StatefulWidget> createState() => _RiderInfoState();
}

class _RiderInfoState extends State<RiderInfo> {
  final GetRiderInfo _getRiderInfo = GetRiderInfo();
  final RegisterAsRider _registerAsRider = RegisterAsRider();
  bool? isRegistered = false;
  bool readAndAgreed = false;

  @override
  void initState() {
    super.initState();

    _checkIsRegistered();
  }

  // Method to check whether the user is being registered as rider
  void _checkIsRegistered() async {
    bool? _isRegistered = await _getRiderInfo.riderIsRegistered(
      Provider.of<UserProvider>(context, listen: false).userID!
    );
    setState(() {
      isRegistered = _isRegistered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Rider Info',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: const Center(child: Text('WIP')),
    );
  }

  Widget _loadUnregisteredContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Image(
          image: AssetImage('images/delivery.png'),
          width: 200,
          height: 200,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 12),
        const Text(
          'You are not yet registered as a rider. Join our delivery team and start earning passive money!',
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        const Text(
          'Rules and Regulations:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        // Need change the rules
        const Text(
          '1. Riders must stay at the campus by the time you accept any delivery offer.',
          textAlign: TextAlign.start,
        ),
        const Text(
          '2. Riders must complete at least 2 deliveries every week.',
          textAlign: TextAlign.start,
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Checkbox(
              value: false, // Provide the actual value based on user's choice
              onChanged: (bool? value) {
                // Handle the checkbox value change
                setState(() {
                  readAndAgreed = !readAndAgreed;
                });
              },
            ),
            const Text(
              'I have read and agree to the rules and regulations.',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            // Handle the registration button click
            // Navigate to the rider registration page or perform the necessary actions
          },
          child: const Text('Register as a Rider'),
        ),
      ],
    );
  }

  void _showRegisterConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Register'),
          content: const Text('Are you sure you want to register as a rider?'),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop();

                // register
                
              }
            ),
          ],
        );
      }
    );
  }

  void registerRider() async {
    bool registerResult = await _registerAsRider.registerRider(
      Provider.of<UserProvider>(context, listen: false).userID!
    );

    if (registerResult) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Success'),
            content: const Text('You have successfully registered as a rider.'),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        }
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Sorry'),
            content: const Text('There is an error while registering as rider. Please try again later.'),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        }
      );
    }
  }

  Widget _loadRiderMenu() {
    return Column(
      children: [
        // delivery image
        const Image(
          image: AssetImage('images/delivery.png'),
          width: 200,
          height: 200,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 12),
        // username
        Text(
          Provider.of<UserProvider>(context, listen: false).userName!,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        // display menu buttons
        _buildButton(context, 'Rider Reviews', 0xFFFFE5BA),
        _buildButton(context, 'Pending Deliveries', 0xFFFFE5BA),
        _buildButton(context, 'Delivery History', 0xFFFFE5BA),
      ],
    );
  }

  Widget _buildButton(BuildContext context, String label, int colorHex) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ElevatedButton(
        onPressed: () {
          
        },
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(colorHex),
          minimumSize: const Size(double.infinity, 1), // removes space between buttons
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero, // no border radius
          ),
        ),
      ),
    );
  }

  /*
    If is registered, display the rider menu: rider reviews, pending deliveries, delivery history.

    If not registered, display the rider introduction, provide the button for user to register
    (must adhere to the rider rules and regulations)
  */
}