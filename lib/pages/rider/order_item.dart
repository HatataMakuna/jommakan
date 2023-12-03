import 'package:flutter/material.dart';

class OrderItemWidget extends StatefulWidget {
  final Map<String, dynamic> item;
  final Map<String, dynamic> selectedDelivery;
  const OrderItemWidget({Key? key, required this.item, required this.selectedDelivery}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItemWidget> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    List<String> preferences = [
      if (int.parse(widget.item['no_vege'] ?? '0') == 1) 'No Vegetarian',
      if (int.parse(widget.item['extra_vege'] ?? '0') == 1) 'Extra Vegetarian',
      if (int.parse(widget.item['no_spicy'] ?? '0') == 1) 'No Spicy',
      if (int.parse(widget.item['extra_spicy'] ?? '0') == 1) 'Extra Spicy',
    ].where((preference) => preference.isNotEmpty).toList();

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Image(
            image: AssetImage('images/foods/${widget.item['food_image'] ?? ''}'),
            width: 80,
            height: 80,
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.item['food_name'] ?? '',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.item['stall_name'] ?? '',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'x ${widget.item['quantity'] ?? '0'}',
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 8.0),
                _buildPreferencesDropdown(preferences),
                const SizedBox(height: 8.0),
                _buildAdditionalNotes(widget.item),
              ],
            ),
          ),
          if (widget.selectedDelivery['status'] == 'In progress') ...[
            const SizedBox(width: 8.0),
          ] else ...[
            const SizedBox(width: 16.0),
          ],
          Text(
            'Price: RM ${(int.parse(widget.item['quantity'] ?? '0') * double.parse(widget.item['price'] ?? '0.0')).toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 14),
          ),
          if (widget.selectedDelivery['status'] == 'In progress') ...[
            const SizedBox(width: 4.0),
            _buildCheckbox(),
            const SizedBox(width: 4.0),
            IconButton(
              icon: const Icon(Icons.info),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Reminder'),
                      content: const Text('Please check your order items to ensure nothing is missed.'),
                      actions: <Widget>[
                        ElevatedButton(
                          child: const Text('Ok'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  }
                );
              }
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPreferencesDropdown(List<String> preferences) {
    if (preferences.isNotEmpty) {
      return Text('Preferences: ${preferences.join(', ')}', style: const TextStyle(fontSize: 14));
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _buildAdditionalNotes(Map<String, dynamic> item) {
    if (item['notes'] != '') {
      return Text('Additional Notes: ${item['notes'] ?? ''}', style: const TextStyle(fontSize: 14));
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _buildCheckbox() {
    return Checkbox(
      value: isChecked,
      onChanged: (bool? value) {
        if (value != null) {
          setState(() {
            isChecked = !isChecked;
          });
        }
      },
    );
  }
}