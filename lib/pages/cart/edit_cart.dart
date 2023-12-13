import 'package:flutter/material.dart';
import 'package:jom_makan/server/cart/modify_remove_cart.dart';

class EditCartPage extends StatefulWidget {
  final Map<String, dynamic> cartItem; // selected cart item

  const EditCartPage({super.key, required this.cartItem});

  @override
  State<StatefulWidget> createState() => _EditCartPageState();
}

class _EditCartPageState extends State<EditCartPage> {
  int quantity = 1;
  String notes = '';
  List<String> preferences = [];
  double totalPrice = 0.0;
  bool isModifySuccess = false;
  bool isRemovalSuccess = false;

  final ModifyRemoveCart _modifyRemoveCart = ModifyRemoveCart();
  final TextEditingController _notesController = TextEditingController();

  @override
  void initState() {
    super.initState();

    setState(() {
      quantity = int.parse(widget.cartItem['quantity']);

      preferences = [
        if (int.parse(widget.cartItem['no_vege']) == 1) 'no vegetarian',
        if (int.parse(widget.cartItem['extra_vege']) == 1) 'extra vegetarian',
        if (int.parse(widget.cartItem['no_spicy']) == 1) 'no spicy',
        if (int.parse(widget.cartItem['extra_spicy']) == 1) 'extra spicy',
      ].where((preference) => preference.isNotEmpty).toList();

      if (widget.cartItem['notes'] != null) {
        _notesController.text = widget.cartItem['notes'];
      }
    });

    _calculateTotalPrice();
  }

  void _calculateTotalPrice() {
    setState(() {
      totalPrice = quantity * double.parse(widget.cartItem['food_price']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Edit Cart Details',
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
                  image: AssetImage('images/foods/${widget.cartItem['food_image']}'),
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              foodTitle(),
              const SizedBox(height: 16),
              adjustQuantity(),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Total Price: ',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'RM${totalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              buildPreferencesCheckboxes(),
              const SizedBox(height: 16),
              buildAdditionalNotesTextField(),
              const SizedBox(height: 16),
              modifyCartItemButton(),
              const SizedBox(height: 16),
              removeItemFromCartButton(),
            ],
          )
        )
      )
    );
  }

  Widget foodTitle() {
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    '${widget.cartItem['food_name']} - ${widget.cartItem['stall_name']}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'RM ',
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Text(
                  double.parse(widget.cartItem['food_price']).toStringAsFixed(2),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget adjustQuantity() {
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Quantity',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    if (quantity > 1) {
                      setState(() {
                        quantity--;
                        _calculateTotalPrice();
                      });
                    }
                  }
                ),
                const SizedBox(width: 8),
                Text(quantity.toString()),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      quantity++;
                      _calculateTotalPrice();
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPreferencesCheckboxes() {
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Preferences:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            buildCheckbox('No vegetarian', 'no vegetarian'),
            buildCheckbox('Extra vegetarian', 'extra vegetarian'),
            buildCheckbox('No Spicy', 'no spicy'),
            buildCheckbox('Extra Spicy', 'extra spicy'),
          ],
        ),
      ),
    );
  }

  Widget buildCheckbox(String title, String preference) {
    bool isChecked = preferences.contains(preference);
    //print(isChecked);

    return Row(
      children: [
        Checkbox(
          value: isChecked,
          onChanged: (bool? value) {
            if (value != null) {
              setState(() {
                if (value) {
                  preferences.add(preference);
                } else {
                  preferences.remove(preference);
                }
              });
            }
          },
        ),
        const SizedBox(width: 5),
        Text(title),
      ],
    );
  }

  Widget buildAdditionalNotesTextField() {
    
    //notesController.text = widget.cartItem['notes'].toString();

    return TextField(
      controller: _notesController,
      decoration: const InputDecoration(
        labelText: 'Additional Notes (optional)',
        hintText: 'Add special instructions...',
      ),
    );
  }

  Widget modifyCartItemButton() {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Confirmation?'),
              content: const Text('Are you sure you want to save your cart details?'),
              actions: <Widget>[
                TextButton(
                  child: const Text('No'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                ElevatedButton(
                  child: const Text('Yes'),
                  onPressed: () async {
                    Navigator.of(context).pop();

                    isModifySuccess = await _modifyRemoveCart.modifyCart(
                      cartID: int.parse(widget.cartItem['cartID']),
                      newQuantity: quantity,
                      newPreferences: preferences,
                      newNotes: _notesController.text,
                    );

                    showModifyCartStatus();
                  },
                ),
              ],
            );
          }
        );
      },
      child: const Text('Modify Cart Item'),
    );
  }

  void showModifyCartStatus() {
    if (isModifySuccess) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Success'),
            content: const Text('Your cart item has been modified successfully!'),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Sorry'),
            content: const Text(
              'There is an error while we\'re trying to modify your cart item. Please try again later.'
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  Widget removeItemFromCartButton() {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Confirmation'),
              content: const Text('Are you sure you want to remove this item from cart?'),
              actions: <Widget>[
                TextButton(
                  child: const Text('No'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  ),
                  child: const Text('Yes'),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    
                    isRemovalSuccess = await _modifyRemoveCart.removeFromCart(
                      cartID: int.parse(widget.cartItem['cartID'])
                    );

                    showRemoveCartStatus();
                  },
                ),
              ],
            );
          },
        );
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
      ),
      child: const Text('Remove from Cart'),
    );
  }

  void showRemoveCartStatus() {
    if (isRemovalSuccess) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Success'),
            content: const Text('Your cart item has been removed successfully!'),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Sorry'),
            content: const Text(
              'There is an error while we\'re trying to remove your cart item. Please try again later.'
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}