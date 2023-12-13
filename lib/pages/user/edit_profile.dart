import 'package:flutter/material.dart';
import 'package:jom_makan/server/user/user_profile.dart';
import 'package:jom_makan/stores/user_provider.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  final int? userID;
  const EditProfile({super.key, required this.userID});

  @override
  State<StatefulWidget> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final UserProfile _userProfile = UserProfile();
  
  // Controller for text fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _currentPasswordController = TextEditingController();

  // Error texts
  String? _emailError;

  late String existingUsername;

  // Fetch user profile data when the widget is initialized
  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  // Fetch user profile data
  void _fetchUserProfile() async {
    int userID = widget.userID!;
    var userProfileData = await _userProfile.getUserProfile(userID);
    if (userProfileData['success']) {
      // Set the text controllers with the retrieved data
      setState(() {
        _nameController.text = userProfileData['username'];
        _emailController.text = userProfileData['email'];
      });

      // Get the username and temporarily stores in a variable for server-side purpose
      existingUsername = _nameController.text;
    } else {
      showErrorFetchingProfileMessage();
    }
  }

  void showErrorFetchingProfileMessage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Oops! There is an error!'),
          content: const Text('Error while retrieving user profile. Please try again later.'),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                // Go back to the previous page
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      }
    );
  }
  
  // Dispose controllers to avoid memory leaks
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _currentPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Edit Profile',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            name(),
            const SizedBox(height: 16),
            email(),
            const SizedBox(height: 16),
            currentPassword(),
            const SizedBox(height: 16),
            saveButton(),
          ],
        ),
      ),
    );
  }

  // Text fields
  Widget name() {
    return TextField(
      controller: _nameController,
      decoration: const InputDecoration(labelText: 'Name'),
    );
  }

  Widget email() {
    return TextField(
      controller: _emailController,
      decoration: InputDecoration(
        labelText: 'Email (someone@example.com)',
        errorText: _emailError,
      ),
      onChanged: (value) => _validateEmail(value),
    );
  }

  Widget currentPassword() {
    return TextField(
      controller: _currentPasswordController,
      obscureText: true,
      decoration: const InputDecoration(labelText: 'Current Password'),
    );
  }

  Widget saveButton() {
    return ElevatedButton(
      onPressed: _saveChanges,
      child: const Text('Save Changes'),
    );
  }

  // Validations
  void _validateEmail(String value) {
    if (value.isEmpty) {
      _emailError = 'Email cannot be empty';
    } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$').hasMatch(value)) {
      _emailError = 'Please enter a valid email';
    } else {
      _emailError = null;
    }
    setState(() {});
  }

  // Function to handle save button press
  void _saveChanges() async {
    // Get the values from the text controllers
    final String name = _nameController.text;
    final String email = _emailController.text;
    final String currentPassword = _currentPasswordController.text;

    int userID = Provider.of<UserProvider>(context, listen: false).userID!;

    // Validate the inputs
    _validateEmail(email);

    // Check for errors
    if (name.isEmpty || email.isEmpty || currentPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in the missing fields')),
      );
      return;
    }
    if (_emailError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid email')),
      );
      return;
    }

    // Check if the current password matches with the database
    bool isCurrentPasswordMatch = await _userProfile.checkCurrentPassword(userID, currentPassword);

    if (!isCurrentPasswordMatch) {
      showInvalidCurrentPasswordMessage();
    } else {
      // If there are no errors, show confirmation message
      showConfirmationMessage();
    }
  }

  void showInvalidCurrentPasswordMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Invalid current password')),
    );
  }

  void showConfirmationMessage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: const Text('Are you sure you want to save your changes?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            ElevatedButton(
              child: const Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog

                // Update the user profile
                updateUserProfile(_nameController.text, _emailController.text);
              },
            ),
          ],
        );
      }
    );
  }

  // function to update user profile
  void updateUserProfile(String username, String email) async {
    int userID = Provider.of<UserProvider>(context, listen: false).userID!;
    bool isUpdateSuccessful = await _userProfile.updateNameEmail(userID, username, email);
    
    if (isUpdateSuccessful) {
      // Show a success message or navigate back
      showUpdateSuccessfulMessage(username, email);
    } else {
      // Show an error message or handle the update failure
      showUpdateFailedMessage();
    }
  }

  void showUpdateSuccessfulMessage(String username, String email) {
    Provider.of<UserProvider>(context, listen: false).setUserName(username);
    Provider.of<UserProvider>(context, listen: false).setUserEmail(email);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile updated successfully')),
    );
  }

  void showUpdateFailedMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Failed to update profile. Please try again.')),
    );
  }
}