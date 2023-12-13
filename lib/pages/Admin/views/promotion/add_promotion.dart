import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//import 'package:jom_makan/pages/Admin/views/promotion/list.dart';
import 'package:jom_makan/server/promotion.dart';

class AddPromotion extends StatefulWidget {
  const AddPromotion({super.key});

  @override
  State<StatefulWidget> createState() => _PromotionState();
}

class _PromotionState extends State<AddPromotion> {
  late TextEditingController _foodIdController = TextEditingController();
  late TextEditingController _foodNameController = TextEditingController();
  late TextEditingController _foodPriceController = TextEditingController();
  late TextEditingController _foodPromotionController = TextEditingController();
  late TextEditingController _datePromotionController = TextEditingController();
  late TextEditingController _quantityController = TextEditingController();
  late TextEditingController _foodStallController = TextEditingController();
  late TextEditingController _foodDescriptionController = TextEditingController();
  late bool isTyping = false;
  late Promotion _registerPromotion = Promotion();
  late String _errorMessage;

  @override
  void initState() {
    super.initState();
    _foodIdController = TextEditingController();
    _foodNameController = TextEditingController();
    _foodPriceController = TextEditingController();
    _foodPromotionController = TextEditingController();
    _datePromotionController = TextEditingController();
    _quantityController = TextEditingController();
    _foodStallController = TextEditingController();
    _foodDescriptionController = TextEditingController();
    isTyping = false;
    _registerPromotion = Promotion();
    _errorMessage = '';
  }

  Future<void> _selectDateAndTime(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (selectedDate != null) {
      // ignore: use_build_context_synchronously
      TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (selectedTime != null) {
        DateTime selectedDateTime = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );

        setState(() {
          _datePromotionController.text =
              DateFormat('yyyy-MM-dd HH:mm').format(selectedDateTime);
          _errorMessage = ''; // Clear any previous error messages
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Promotion'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: addPromotionForm(),
    );
  }

  Widget addPromotionForm() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            foodIdField(),
            const SizedBox(height: 20),
            foodNameField(),
            const SizedBox(height: 20),
            foodPriceField(),
            const SizedBox(height: 20),
            foodPromotionField(),
            const SizedBox(height: 20),
            datePromotionField(),
            const SizedBox(height: 20),
            quantityField(),
            const SizedBox(height: 20),
            foodStallField(),
            const SizedBox(height: 20),
            foodDescriptionField(),
            const SizedBox(height: 20),
            registerButton(),
            // text fields
          ],
        ),
      ),
    );
  }

  // Text Fields
  Widget foodIdField() {
    return TextField(
      controller: _foodIdController,
      decoration: InputDecoration(labelText: 'FoodId',
      errorText:_foodIDText(),
      ),
      onChanged: (value) => _validateFoodID(value),
    );
  }

  // Error Messages
  String? _foodIDText() {
    final text = _foodIdController.value.text;
    if (text.isEmpty) {
      return 'Please enter Food ID';
    } else if (!RegExp(r'^F0[\w-]+$').hasMatch(text)) {
      return 'FoodId must start with F0';
    }
    return null;
  }

  // Validations
  void _validateFoodID(String value) {
    setState(() => isTyping = true);
  }

  Widget foodNameField() {
    return TextField(
      controller: _foodNameController,
      decoration: InputDecoration(labelText: 'FoodName',
      errorText:_foodNameText(),
      ),
      onChanged: (value) => _validateFoodName(value),
    );
  }

  // Error Messages
  String? _foodNameText() {
    final text = _foodNameController.value.text;
    if (text.isEmpty) {
      return 'Please enter Food Name';
    }
    return null;
  }

  // Validations
  void _validateFoodName(String value) {
    setState(() => isTyping = true);
  }

  Widget foodPriceField() {
    return TextField(
      controller: _foodPriceController,
      decoration: InputDecoration(labelText: 'FoodPrice', errorText:_foodPriceText()),
      onChanged: (value) => _validateFoodPrice(value),
    );
  }

  // Error Messages
  String? _foodPriceText() {
    final text = _foodPriceController.value.text;
    if (text.isEmpty) {
      return 'Please enter Food Price';
    }

    // Check if the entered value is a valid double with two decimal places
    final RegExp regex = RegExp(r'^\d+(\.\d{1,2})?$');
    if (!regex.hasMatch(text)) {
      return 'Please enter a valid number for Food Price with up to two decimal places';
    }

    return null;
  }

  // Validations
  void _validateFoodPrice(String value) {
    setState(() => isTyping = true);
  }

  Widget foodPromotionField() {
    return TextField(
      controller: _foodPromotionController,
      decoration: InputDecoration(labelText: 'FoodPromotion', 
      errorText:_foodPromotionText(),
      ),
      onChanged: (value) => _validateFoodPromotion(value),
    );
  }

  // Error Messages
  String? _foodPromotionText() {
    final foodPriceText = _foodPriceController.value.text;
    final promotionPriceText = _foodPromotionController.value.text;

    if (promotionPriceText.isEmpty) {
      return 'Please enter Food Promotion';
    }

    // Check if the entered value is a valid double with two decimal places
    final RegExp regex = RegExp(r'^\d+(\.\d{1,2})?$');
    if (!regex.hasMatch(promotionPriceText)) {
      return 'Please enter a valid number for Food Promotion with up to two decimal places';
    }

    // Parse the values as doubles for comparison
    final double? foodPrice = double.tryParse(foodPriceText);
    final double? promotionPrice = double.tryParse(promotionPriceText);

    // Check if promotion price is less than food price
    if (foodPrice != null && promotionPrice != null && promotionPrice >= foodPrice) {
      return 'Promotion price should be less than the food price';
    }

    return null;
  }

  // Validations
  void _validateFoodPromotion(String value) {
    setState(() => isTyping = true);
  }

  //@override
  Widget datePromotionField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _datePromotionController,
          decoration: InputDecoration(labelText: 'Date Promotion',
          errorText:_datePromotionText(),
      ),
      readOnly: true,
          onTap: () => _selectDateAndTime(context),
          onChanged: (value) => _validateDatePromotion(value),
        ),
        if (_errorMessage.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              _errorMessage,
              style: const TextStyle(color: Colors.red),
            ),
          ),
      ],
    );
  }

  // Error Messages
  String? _datePromotionText() {
    final text = _datePromotionController.value.text;
    if (text.isEmpty) {
      return 'Please Select the Date Promotion';
    }
    return null;
  }

  // Validations
  void _validateDatePromotion(String value) {
    setState(() => isTyping = true);
  }

  Widget quantityField() {
    return TextField(
      controller: _quantityController,
      decoration: InputDecoration(labelText: 'Quantity',
    errorText:_quantityText(),
      ),
      onChanged: (value) => _validateQuantity(value),
    );
  }

  // Error Messages
  String? _quantityText() {
    final text = _quantityController.value.text;
    if (text.isEmpty) {
      return 'Please enter Food Quantity';
    }

    // Check if the entered value is a valid integer
    final int? quantity = int.tryParse(text);
    if (quantity == null) {
      return 'Please enter a valid integer for Food Quantity';
    }

    return null;
  }

  // Validations
  void _validateQuantity(String value) {
    setState(() => isTyping = true);
  }

  Widget foodStallField() {
    return TextField(
      controller: _foodStallController,
      decoration: InputDecoration(labelText: 'FoodStall',
     errorText:_foodStallText(),
      ),
      onChanged: (value) => _validateFoodStall(value),
    );
  }

  // Error Messages
  String? _foodStallText() {
    final text = _foodStallController.value.text;
    if (text.isEmpty) {
      return 'Please enter Food Stall';
    }
    return null;
  }

  // Validations
  void _validateFoodStall(String value) {
    setState(() => isTyping = true);
  }

  Widget foodDescriptionField() {
    return TextField(
      controller: _foodDescriptionController,
      decoration: InputDecoration(
        labelText: 'FoodDescription',
        errorText:_foodDescriptionText(),
      ),
      onChanged: (value) => _validateFoodDescription(value),
    );
  }

  // Error Messages
  String? _foodDescriptionText() {
    final text = _foodDescriptionController.value.text;
    if (text.isEmpty) {
      return 'Please enter Food Description';
    }
    return null;
  }

  // Validations
  void _validateFoodDescription(String value) {
    setState(() => isTyping = true);
  }

  // Register Button
  Widget registerButton() {
    return ElevatedButton(
      // Disable the button if there are errors or empty fields
      onPressed: () {
        // confirm register
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Confirm Registration?'),
              content: const Text('Are you sure you want to register?'),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                ),
                ElevatedButton(
                  child: const Text('Register'),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                    promotionRegister(); // Call the registerUser function
                  }
                )
              ]
            );
          },
        );
      },
      style: ElevatedButton.styleFrom(
        elevation: 5, // Set the elevation (depth) of the button
        shadowColor: Colors.black, // Set the shadow color
      ),
      child: const Text('Register Now'),
    );
  }

  void promotionRegister() async {
    String foodId = _foodIdController.text;
    String foodName = _foodNameController.text;
    String foodPrice = _foodPriceController.text;
    String foodPromotion = _foodPromotionController.text;
    DateTime datePromotion = DateTime.parse(_datePromotionController.text);
    int quantity = _quantityController.hashCode;
    String foodStall = _foodStallController.text;
    String foodDescription = _foodDescriptionController.text;

    bool registrationResult = await _registerPromotion.promotionRegister(
      foodId: foodId, foodName: foodName, foodPrice: foodPrice, foodPromotion: foodPromotion, datePromotion: datePromotion, quantity: quantity, foodStall: foodStall, foodDescription: foodDescription,
    );

    if (registrationResult) {
      // Registration was successful, handle navigation or other tasks here
      _showSuccessDialog();
    } else {
      // Registration failed, show an error message or handle it accordingly
      _showFailureDialog();
    }
  }

  // Show dialog message where the user has been successfully registered
  Future<void> _showSuccessDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Registration Successful'),
          content: const Text('You have been successfully registered.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ]
        );
      }
    );
  }

  // Show dialog message where registration failed
  Future<void> _showFailureDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Registration Failed'),
          content: const Text('Sorry, registration failed. Please try again.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Ok'),
            )
          ]
        );
      }
    );
  }
}