import 'package:flutter/material.dart';
import 'package:jom_makan/server/food/food.dart';


class AddFood extends StatefulWidget {
  const AddFood({super.key});

  @override
  _AddFoodState createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
   final TextEditingController _foodIDController = TextEditingController();
  final TextEditingController _foodNameController = TextEditingController();
  final TextEditingController _stallIDController = TextEditingController();
  final TextEditingController _mainCategoryController = TextEditingController();
  final TextEditingController _subCategoryController = TextEditingController();
  final TextEditingController _foodPriceController = TextEditingController();
  final TextEditingController _qtyInStockController = TextEditingController();
  final TextEditingController _foodImageController = TextEditingController();
  bool isTyping = false;
  final Food _registerFood = Food();

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
  /* Widget foodIDField() {
    return TextField(
      controller: _foodIDController,
      decoration: const InputDecoration(labelText: 'FoodId'),
    );
  } */

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


  Widget stallIDField() {
    return TextField(
      controller: _stallIDController,
      decoration: InputDecoration(labelText: 'StallID',
    errorText:_stallIDText(),
      ),
      onChanged: (value) => _validateStallID(value),
    );
  }

  // Error Messages
 String? _stallIDText() {
  final text = _stallIDController.text;
  if (text.isEmpty) {
    return 'Please enter Stall ID';
  }

  // Check if the entered value is one of the allowed values
  final int? stallID = int.tryParse(text);
  if (stallID == null || !isValidStallID(stallID)) {
    return 'Please enter a valid Stall ID (1. Kedai Masakan Malaysia, 2. YumYum Cafe, or 3. East Campus Cafe)';
  }

  return null;
}

bool isValidStallID(int value) {
  // Define the allowed stall IDs
  final List<int> allowedStallIDs = [1, 2, 3];

  // Check if the entered value is in the list of allowed stall IDs
  return allowedStallIDs.contains(value);
}


// Validations
  void _validateStallID(String value) {
    setState(() => isTyping = true);
  }

  Widget mainCategoryField() {
  return TextField(
    controller: _mainCategoryController,
    decoration: InputDecoration(labelText: 'MainCategory',
     errorText: _mainCategoryText(),
     ),
    onChanged: (value) => _validateMainCategory2(value),
  );
}

// Error Messages
String? _mainCategoryText() {
  final text = _mainCategoryController.text;
  if (text.isEmpty) {
    return 'Please enter Main Category';
  }

  // Check if the entered value is one of the allowed values
  final int? mainCategory = int.tryParse(text);
  if (mainCategory == null || !_validateMainCategory(mainCategory)) {
    return '(1.Rice, 2.Noodle, 3.Bread, 4.Cake, 5.Drinks, 6.Spaghetti, 7.Pizza, 8.Burger, 9.Sushi, or 10.Western)';
  }

  return null;
}

bool _validateMainCategory(int value) {
  // Define the allowed Main Category
  final List<int> allowedMainCategories = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  // Check if the entered value is in the list of allowed main categories
  return allowedMainCategories.contains(value);
}

// Validations
void _validateMainCategory2(String value) {
  setState(() => isTyping = true);
}

  Widget subCategoryField() {
    return TextField(
      controller: _subCategoryController,
      decoration: InputDecoration(labelText: 'SubCategory',
     errorText: _subCategoryText(),
     ),
    onChanged: (value) => _validatesubCategory2(value),
  );
}

// Error Messages
String? _subCategoryText() {
  final text = _subCategoryController.text;
  if (text.isEmpty) {
    return 'Please enter Main Category';
  }

  // Check if the entered value is one of the allowed values
  final int? subCategory = int.tryParse(text);
  if (subCategory == null || !_validatesubCategory(subCategory)) {
    return '(1.Rice, 2.Noodle, 3.Bread, 4.Cake, 5.Drinks, 6.Spaghetti, 7.Pizza, 8.Burger, 9.Sushi, or 10.Western)';
  }

  return null;
}

bool _validatesubCategory(int value) {
  // Define the allowed Main Category
  final List<int> allowedSubCategories = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  // Check if the entered value is in the list of allowed main categories
  return allowedSubCategories.contains(value);
}

// Validations
void _validatesubCategory2(String value) {
  setState(() => isTyping = true);
}

   Widget foodPriceField() {
    return TextField(
      controller: _foodPriceController,
      decoration: InputDecoration(labelText: 'FoodPrice',
   errorText:_foodPriceText(),
      ),
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

  Widget qtyInStockField() {
    return TextField(
      controller: _qtyInStockController,
      decoration: InputDecoration(labelText: 'qtyInStock',
    errorText:_quantityText(),
      ),
      onChanged: (value) => _validateQuantity(value),
    );
  }

  // Error Messages
 String? _quantityText() {
  final text = _qtyInStockController.value.text;
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

  Widget foodImageField() {
    return TextField(
      controller: _foodImageController,
      decoration: InputDecoration(labelText: 'FoodImage',
     errorText:_foodImageText(),
      ),
      onChanged: (value) => _validateFoodImage(value),
    );
  }


  // Error Messages
  String? _foodImageText() {
  final text = _foodImageController.value.text;
  if (text.isEmpty) {
    return 'Please enter Food Image';
  }
  return null;
}

// Validations
  void _validateFoodImage(String value) {
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
      foodName: foodName, stallID: int.parse(stallID),
      mainCategory: int.parse(mainCategory), subCategory: int.parse(subCategory),
      foodPrice: double.parse(foodPrice), qtyInStock: int.parse(qtyInStock), foodImage: foodImage, 
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
            //   child: const Text('Go to Login'),
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

  // @override
  // void dispose() {
  //   _emailController.dispose();
  //   super.dispose();
  // }
}