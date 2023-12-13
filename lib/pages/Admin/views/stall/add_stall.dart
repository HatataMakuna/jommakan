import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
//import 'package:jom_makan/pages/Admin/views/stall/renew_stall.dart';
//import 'package:jom_makan/server/promotion.dart';
import 'package:file_picker/file_picker.dart';
import 'package:jom_makan/server/renewStall/renew.dart';

class AddStall extends StatefulWidget {
  const AddStall({super.key});

  @override
  State<StatefulWidget> createState() => _RenewStallState();
}

class _RenewStallState extends State<AddStall> {
  late TextEditingController _stallIDController = TextEditingController();
  late TextEditingController _stallNameController = TextEditingController();
  late TextEditingController _stallOwnerController = TextEditingController();
  late TextEditingController _totalStaffController = TextEditingController();
  late TextEditingController _canteenController = TextEditingController();
  late TextEditingController _hygieneLevelController = TextEditingController();
  late bool isTyping = false;
  late Renew _registerRenew = Renew();
  late String _errorMessage;


  @override
  void initState() {
    super.initState();
    _stallIDController = TextEditingController();
    _stallNameController = TextEditingController();
    _stallOwnerController = TextEditingController();
    _totalStaffController = TextEditingController();
    _canteenController = TextEditingController();
    _hygieneLevelController = TextEditingController();

    isTyping = false;
    _registerRenew = Renew();
    _errorMessage = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Renew Stall Information'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: renewStallForm(),
    );
  }

  Widget renewStallForm() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            stallIDField(),
            const SizedBox(height: 20),
            stallNameField(),
            const SizedBox(height: 20),
            stallOwnerField(),
            const SizedBox(height: 20),
            totalStaffField(),
            const SizedBox(height: 20),
            canteenField(),
            const SizedBox(height: 20),
            hygieneLevelField(),
            const SizedBox(height: 20),
            registerButton(),
            // text fields
          ],
        ),
      ),
    );
  }

  // Text Fields
  Widget stallIDField() {
    return TextField(
      controller: _stallIDController,
      decoration: InputDecoration(
        labelText: 'Stall ID',
        errorText:_stallIDText(),
      ),
      onChanged: (value) => _validateStallID(value),
    );
  }

  // Error Messages
  String? _stallIDText() {
    final text = _stallIDController.value.text;
    if (text.isEmpty) {
      return 'Please enter Stall ID';
    } else if (!RegExp(r'^S0[\w-]+$').hasMatch(text)) {
      return 'Stall Id must start with S0';
    }
    return null;
  }

  // Validations
  void _validateStallID(String value) {
    setState(() => isTyping = true);
  }

  Widget stallNameField() {
    return TextField(
      controller: _stallNameController,
      decoration: InputDecoration(labelText: 'Stall Name',
    errorText:_stallNameText(),
      ),
      onChanged: (value) => _validatestallName(value),
    );
  }

  // Error Messages
  String? _stallNameText() {
    final text = _stallNameController.value.text;
    if (text.isEmpty) {
      return 'Please enter Stall Name';
    }
    return null;
  }

  // Validations
  void _validatestallName(String value) {
    setState(() => isTyping = true);
  }

  Widget stallOwnerField() {
    return TextField(
      controller: _stallOwnerController,
      decoration: InputDecoration(labelText: 'Stall Owner',
    errorText:_stallOwnerText(),
      ),
      onChanged: (value) => _validatestallOwner(value),
    );
  }

  // Error Messages
  String? _stallOwnerText() {
    final text = _stallOwnerController.value.text;
    if (text.isEmpty) {
      return 'Please enter Stall Owner';
    }
    return null;
  }

  // Validations
  void _validatestallOwner(String value) {
    setState(() => isTyping = true);
  }

  Widget totalStaffField() {
    return TextField(
      controller: _totalStaffController,
      decoration: InputDecoration(
        labelText: 'Total Staff',
        errorText:_totalStaffText(),
      ),
      onChanged: (value) => _validateTotalStaff(value),
    );
  }

  // Error Messages
  String? _totalStaffText() {
    final text = _totalStaffController.value.text;
    if (text.isEmpty) {
      return 'Please enter Total Staff';
    }

    // Check if the entered value is a valid integer
    final int? quantity = int.tryParse(text);
    if (quantity == null) {
      return 'Please enter a valid integer for Total Staff';
    }

    return null;
  }

  // Validations
  void _validateTotalStaff(String value) {
    setState(() => isTyping = true);
  }

  String? selectedCanteen;

  final List<String> canteenChoices = [
    'RedBrick Cafe',
    'YumYum Cafe',
    'East Campus Cafe',
    'Swimming Pool Cafe',
    'CITC Cafe',
  ];

  Widget canteenField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _canteenController,
          decoration: InputDecoration(labelText: 'Canteen',
          errorText:_canteenText(),
          ),
          readOnly: true,
          onTap: () {
            _selectCanteen(context);
          },
          onChanged: (value) => _validateCanteen(value),
        ),
      ],
    );
  }

  // Error Messages
  String? _canteenText() {
    final text = _canteenController.value.text;
    if (text.isEmpty) {
      return 'Please Select the Canteen';
    }
    return null;
  }

  // Validations
  void _validateCanteen(String value) {
    setState(() => isTyping = true);
  }

  Future<void> _selectCanteen(BuildContext context) async {
    final result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Canteen'),
          content: Column(
            children: canteenChoices.map((canteen) {
              return ListTile(
                title: Text(canteen),
                onTap: () {
                  Navigator.pop(context, canteen);
                },
              );
            }).toList(),
          ),
        );
      },
    );

    if (result != null) {
      setState(() {
        selectedCanteen = result;
        _canteenController.text = result;
      });
    }
  }


  Widget hygieneLevelField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _hygieneLevelController,
                readOnly: true,
                decoration: const InputDecoration(
                  hintText: 'Please Submit Government Hygiene Level.PDF',
                ),
              ),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: _pickPDF,
              child: const Text('Pick PDF'),
            ),
          ],
        ),
      ],
    );
  }

  void _pickPDF() async {
    // Use a file picker library or any other method to allow users to pick a PDF file.
    // Here, I'm using the `FilePicker` library as an example.
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _hygieneLevelController.text = result.files.first.name ?? '';
      });
    }
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
                    renewRegister(); // Call the registerUser function
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

  // Passing the data to "server/register.dart" for performing the server-side script
  void renewRegister() async {
    String stallID = _stallIDController.text;
    String stallName = _stallNameController.text;
    String stallOwner = _stallOwnerController.text;
    String totalStaff = _totalStaffController.text;
    String canteen = _canteenController.text;

    bool registrationResult = await _registerRenew.renewRegister(
      stallID: stallID, stallName: stallName, stallOwner: stallOwner, totalStaff: totalStaff, canteen: canteen,
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