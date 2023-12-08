import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jom_makan/pages/Admin/views/promotion/list.dart';
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
      decoration: const InputDecoration(labelText: 'FoodId'),
    );
  }

  Widget foodNameField() {
    return TextField(
      controller: _foodNameController,
      decoration: const InputDecoration(labelText: 'FoodName'),
    );
  }

  Widget foodPriceField() {
    return TextField(
      controller: _foodPriceController,
      decoration: const InputDecoration(labelText: 'FoodPrice'),
    );
  }

  Widget foodPromotionField() {
    return TextField(
      controller: _foodPromotionController,
      decoration: const InputDecoration(labelText: 'FoodPromotion'),
    );
  }

  @override
  Widget datePromotionField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _datePromotionController,
          decoration: InputDecoration(labelText: 'Date Promotion'),
          readOnly: true,
          onTap: () => _selectDateAndTime(context),
        ),
        if (_errorMessage.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              _errorMessage,
              style: TextStyle(color: Colors.red),
            ),
          ),
      ],
    );
  }


  Widget quantityField() {
    return TextField(
      controller: _quantityController,
      decoration: const InputDecoration(labelText: 'Quantity'),
    );
  }

  Widget foodStallField() {
    return TextField(
      controller: _foodStallController,
      decoration: const InputDecoration(labelText: 'FoodStall'),
    );
  }

  Widget foodDescriptionField() {
    return TextField(
      controller: _foodDescriptionController,
      decoration: const InputDecoration(labelText: 'FoodDescription'),
    );
  }

  // Widget emailField() {
  //   return TextField(
  //     controller: _emailController,
  //     decoration: InputDecoration(
  //       labelText: 'Email (someone@example.com)',
  //       errorText: _emailErrorText(),
  //     ),
  //     onChanged: (value) => _validateEmail(value),
  //   );
  // }

  // Widget passwordField() {
  //   return TextField(
  //     controller: _passwordController,
  //     decoration: InputDecoration(
  //       labelText: 'Password (minimum 8 characters)',
  //       errorText: _passwordErrorText(),
        
  //       // "Show Password" icon
  //       suffixIcon: IconButton(
  //         icon: Icon(_showPassword ? Icons.visibility_off : Icons.visibility),
  //         onPressed: () {
  //           setState(() {
  //             _showPassword = !_showPassword;
  //           });
  //         },
  //       ),
  //     ),
  //     onChanged: (value) => _validatePassword(value),
  //     obscureText: !_showPassword, // Hide or show password based on _showPassword value
  //   );
  // }

  // Widget repeatPasswordField() {
  //   return TextField(
  //     controller: _repeatPasswordController,
  //     decoration: InputDecoration(
  //       labelText: 'Repeat Password',
  //       errorText: _repeatPasswordErrorText(),
        
  //       // "Show Password" icon
  //       suffixIcon: IconButton(
  //         icon: Icon(_showPassword ? Icons.visibility_off : Icons.visibility),
  //         onPressed: () {
  //           setState(() {
  //             _showPassword = !_showPassword;
  //           });
  //         },
  //       ),
  //     ),
  //     onChanged: (value) => _validateRepeatPassword(value),
  //     obscureText: !_showPassword, // Hide or show password based on _showPassword value
  //   );
  // }

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
      child: const Text('Register Now'),
      style: ElevatedButton.styleFrom(
        elevation: 5, // Set the elevation (depth) of the button
        shadowColor: Colors.black, // Set the shadow color
      ),
    );
  }

  // Validations
  void _validateEmail(String value) {
    setState(() => isTyping = true);
  }

  void _validatePassword(String value) {
    setState(() {});
  }

  void _validateRepeatPassword(String value) {
    setState(() {});
  }

  // Navigate to login page
  void goToLogin() {
    // print("Navigating to login page");
  //   Navigator.push(
  //   context,
  //   MaterialPageRoute(builder: (context) => UserList()),
  // );
  }

  // // Error Messages
  // String? _emailErrorText() {
  //   final text = _emailController.value.text;
  //   if (text.isEmpty) {
  //     return null;
  //   } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$').hasMatch(text)) {
  //     return 'Please enter a valid email';
  //   }
  //   return null;
  // }

  // String? _passwordErrorText() {
  //   final text = _passwordController.value.text;
  //   if (text.isEmpty) {
  //     return null;
  //   } else if (text.length < 8) {
  //     return 'Password too short';
  //   }
  //   return null;
  // }

  // String? _repeatPasswordErrorText() {
  //   if (_isRegistering) {
  //     final textToCompare = _passwordController.value.text;
  //     final inputText = _repeatPasswordController.value.text;
  //     if (inputText != textToCompare) {
  //       return 'Password does not match';
  //     } else {
  //       return null;
  //     }
  //   }
  //   return null;
  // }

  // // Check whether the registration form has any errors
  // bool _hasErrors() {
  //   return _emailErrorText() != null ||
  //     _passwordErrorText() != null ||
  //     _repeatPasswordErrorText() != null;
  // }

  // Check whether the registration form has any empty fields
  bool _hasEmptyFields() {
    return _foodIdController.text.isEmpty || 
      _foodNameController.text.isEmpty ||
      _foodPriceController.text.isEmpty ||
      _foodPromotionController.text.isEmpty ||
      _foodStallController.text.isEmpty ||
      _foodDescriptionController.text.isEmpty;
  }

  // Passing the data to "server/register.dart" for performing the server-side script
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
            // ElevatedButton(
            //   onPressed: goToLogin,
            //   child: const Text('Go to Promotion Page'),
            // ),
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