import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // Firestore instance
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Load user data from Firebase
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      setState(() {
        emailController.text = user.email ?? '';
      });
      // Fetch user data from Firestore
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        var data = userDoc.data() as Map<String, dynamic>;
        phoneController.text = data['phone'] ?? ''; // Assuming you save phone number in Firestore
        fullNameController.text = data['fullName'] ?? ''; // Load the full name if you have it stored
        addressController.text = data['address'] ?? ''; // Load the address if you have it stored
        cityController.text = data['city'] ?? ''; // Load the city if you have it stored
        postalCodeController.text = data['postalCode'] ?? ''; // Load the postal code if you have it stored
      }
    }
  }

  Future<void> _saveProfile() async {
    User? user = _auth.currentUser;
    if (user != null) {
      // Basic validation
      if (fullNameController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Full Name cannot be empty!')),
        );
        return; // Prevent saving if the full name is empty
      }

      // Save the profile information to Firestore
      await _firestore.collection('users').doc(user.uid).set({
        'fullName': fullNameController.text,
        'phone': phoneController.text,
        'address': addressController.text,
        'city': cityController.text,
        'postalCode': postalCodeController.text,
      }, SetOptions(merge: true)); // Use merge to only update specified fields

      // Show a Snackbar message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile updated successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Color.fromARGB(255, 139, 69, 19), // Coffee color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Profile Details",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 139, 69, 19)),
            ),
            SizedBox(height: 20),
            _buildTextField(fullNameController, 'Full Name'),
            SizedBox(height: 16),
            _buildTextField(emailController, 'Email', enabled: false),
            SizedBox(height: 16),
            _buildTextField(phoneController, 'Phone Number'),
            SizedBox(height: 16),
            _buildTextField(addressController, 'Address'),
            SizedBox(height: 16),
            _buildTextField(cityController, 'City'),
            SizedBox(height: 16),
            _buildTextField(postalCodeController, 'Postal Code'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveProfile,
              child: Text("Save Profile"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 139, 69, 19), // Coffee color
                foregroundColor: Colors.white, // Set the text color to white
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to build text fields
  Widget _buildTextField(TextEditingController controller, String label, {bool enabled = true}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Color.fromARGB(255, 139, 69, 19)), // Coffee color
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 139, 69, 19)), // Coffee color
        ),
        border: OutlineInputBorder(),
      ),
      enabled: enabled,
      style: TextStyle(fontSize: 16), // Increased font size for clarity
    );
  }
}
