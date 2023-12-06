import 'package:flutter/material.dart';
import 'package:jom_makan/pages/foods/food_details.dart';

// ignore: must_be_immutable
class OrderDetailsPage extends StatelessWidget {
  Map<String, dynamic> selectedOrderItem;

  OrderDetailsPage({super.key, required this.selectedOrderItem});

  @override
  Widget build(BuildContext context) {
    List<String> preferences = [
      if (int.parse(selectedOrderItem['no_vege']) == 1) 'no vegetarian',
      if (int.parse(selectedOrderItem['extra_vege']) == 1) 'extra vegetarian',
      if (int.parse(selectedOrderItem['no_spicy']) == 1) 'no spicy',
      if (int.parse(selectedOrderItem['extra_spicy']) == 1) 'extra spicy',
    ].where((preference) => preference.isNotEmpty).toList();

    String notes = selectedOrderItem['notes'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Order Details',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                constraints: const BoxConstraints.expand(height: 250),
                child: Image(
                  image: AssetImage('images/foods/${selectedOrderItem['food_image']}'),
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              _title(),
              const SizedBox(height: 16),
              if (preferences.isNotEmpty) ...[
                _loadPreferences(preferences),
                const SizedBox(height: 16),
              ],
              if (notes.isNotEmpty) ...[
                _loadAdditionalNotes(notes),
              ],
            ],
          ),
        )
      ),
    );
  }

  Widget _title() {
    return Card(
      elevation: 5,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
        side: BorderSide(
          color: Colors.grey,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedOrderItem['odetailsID'].toString(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  selectedOrderItem['date'],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    '${selectedOrderItem['food_name']}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'RM ${double.parse(selectedOrderItem['price']).toStringAsFixed(2)} (${selectedOrderItem['quantity'].toString()} ITEMS) - ${selectedOrderItem['payment']}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            if (selectedOrderItem['status'] == 'Completed') ...[
              Text(
                'Status: ${selectedOrderItem['status']}',
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ]
            else ...[
              Text(
                'Status: ${selectedOrderItem['status']}',
                style: const TextStyle(
                  color: Colors.yellow,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _loadPreferences(List<String> preferences) {
    return Card(
      elevation: 5,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
        side: BorderSide(
          color: Colors.grey,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(
              'Preferences',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            for (String preference in preferences) ...[
              Row (
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('- $preference'),
                  const SizedBox(height: 16),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _loadAdditionalNotes(String notes) {
    return Card(
      elevation: 5,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
        side: BorderSide(
          color: Colors.grey,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(
              'Additional Notes',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(notes, style: const TextStyle(fontSize: 16)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}