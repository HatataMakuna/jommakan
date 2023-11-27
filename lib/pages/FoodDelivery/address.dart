import 'package:flutter/material.dart';

class AddressPage extends StatefulWidget {
  //final String initialAddress;
  final ValueNotifier<String> selectedAddressNotifier;

  const AddressPage({super.key, required this.selectedAddressNotifier});

  @override
  State<StatefulWidget> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  late TextEditingController addressController;

  @override
  void initState() {
    super.initState();
    addressController = TextEditingController(text: widget.selectedAddressNotifier.value);
  }

  void saveAddress(BuildContext context) {
    // Pass the edited address back to the previous screen
    Navigator.pop(context, addressController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Address'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Enter Your Address',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: addressController,
              maxLines: 3,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Address',
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Save the address and update the state in the PaymentPage
                  saveAddress(context);
                },
                child: const Text('Save Address'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
