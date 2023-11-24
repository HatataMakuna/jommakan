import 'package:flutter/material.dart';
import 'package:jom_makan/server/promotion.dart';

import '../../../../server/food/food.dart';

//void main() => runApp(const MaterialApp(home: CreateAccount()));

class addFood extends StatefulWidget {
  const addFood({super.key});

  @override
  State<StatefulWidget> createState() {
    return _addFoodState();
  }
}

class _addFoodState extends State<addFood> {
   final TextEditingController _foodIDController = TextEditingController();
  final TextEditingController _foodNameController = TextEditingController();
  final TextEditingController _stallIDController = TextEditingController();
  final TextEditingController _mainCategoryController = TextEditingController();
  final TextEditingController _subCategoryController = TextEditingController();
  final TextEditingController _foodPriceController = TextEditingController();
  final TextEditingController _qtyInStockController = TextEditingController();
  final TextEditingController _foodImageController = TextEditingController();
  bool isTyping = false;
  bool _showPassword = false;
  final Food _registerFood = Food(); // Instantiate Register (server-side) class
  bool _isRegistering = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Food'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: addFoodForm(),
    );
  }

  Widget addFoodForm() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            foodIDField(),
            const SizedBox(height: 20),
            foodNameField(),
            const SizedBox(height: 20),
            stallIDField(),
            const SizedBox(height: 20),
            mainCategoryField(),
            const SizedBox(height: 20),
            subCategoryField(),
            const SizedBox(height: 20),
            foodPriceField(),
            const SizedBox(height: 20),
            qtyInStockField(),
            const SizedBox(height: 20),
            foodImageField(),
            const SizedBox(height: 20),
            registerButton(),
            // text fields
          ],
        ),
      ),
    );
  }

  // Text Fields
  Widget foodIDField() {
    return TextField(
      controller: _foodIDController,
      decoration: const InputDecoration(labelText: 'FoodId'),
    );
  }

  Widget foodNameField() {
    return TextField(
      controller: _foodNameController,
      decoration: const InputDecoration(labelText: 'FoodName'),
    );
  }

  Widget stallIDField() {
    return TextField(
      controller: _stallIDController,
      decoration: const InputDecoration(labelText: 'StallID'),
    );
  }

  Widget mainCategoryField() {
    return TextField(
      controller: _mainCategoryController,
      decoration: const InputDecoration(labelText: 'MainCategory'),
    );
  }

  Widget subCategoryField() {
    return TextField(
      controller: _subCategoryController,
      decoration: const InputDecoration(labelText: 'SubCategory'),
    );
  }

  Widget foodPriceField() {
    return TextField(
      controller: _foodPriceController,
      decoration: const InputDecoration(labelText: 'FoodPrice'),
    );
  }

  Widget qtyInStockField() {
    return TextField(
      controller: _qtyInStockController,
      decoration: const InputDecoration(labelText: 'qtyInStock'),
    );
  }

  Widget foodImageField() {
    return TextField(
      controller: _foodImageController,
      decoration: const InputDecoration(labelText: 'FoodImage'),
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
        // Set the registration status to true before showing the dialog
        setState(() {
          _isRegistering = true;
        });

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
                    foodRegister(); // Call the registerUser function
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
    print("Navigating to login page");
    setState(() {
      Navigator.pushNamed(context, '/user/login');
    });
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
    return _foodIDController.text.isEmpty || 
      _foodNameController.text.isEmpty ||
      _stallIDController.text.isEmpty ||
      _mainCategoryController.text.isEmpty ||
      _subCategoryController.text.isEmpty ||
      _foodPriceController.text.isEmpty ||
      _qtyInStockController.text.isEmpty ||
      _foodImageController.text.isEmpty;
  }

  // Passing the data to "server/register.dart" for performing the server-side script
  void foodRegister() async {
    String foodId = _foodIDController.text;
    String foodName = _foodNameController.text;
    String stallID = _stallIDController.text;
    String mainCategory = _mainCategoryController.text;
    String subCategory = _subCategoryController.text;
    String foodPrice = _foodPriceController.text;
    String qtyInStock = _qtyInStockController.text;
    String foodImage = _foodImageController.text;

    bool registrationResult = await _registerFood.foodRegister(
      foodID: foodId, food_name: foodName, stallID: stallID, main_category: mainCategory, sub_category: subCategory, food_price: foodPrice, qty_in_stock: qtyInStock, food_image: foodImage,
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
                // Reset the registration status when canceling
                setState(() {
                  _isRegistering = false;
                });
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
            ElevatedButton(
              onPressed: goToLogin,
              child: const Text('Go to Login'),
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

  // @override
  // void dispose() {
  //   _emailController.dispose();
  //   super.dispose();
  // }
}