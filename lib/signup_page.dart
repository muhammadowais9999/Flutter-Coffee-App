import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_page.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> registerUser() async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    } catch (e) {
      print(e); // Handle sign-up error
      // You can show an alert dialog or snackbar here for better user feedback
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center( // Centering the app name
          child: Text(
            "CoffeeCraft",
            style: TextStyle(
              fontWeight: FontWeight.bold, // Bold font for CoffeeCraft
            ),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 139, 69, 19), // Coffee color
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView( // Use SingleChildScrollView for better scrolling
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // App Logo
                Image.asset(
                  'images/coffeelogo.png', // Path to your logo
                  width: 100, // Adjust the size as needed
                  height: 100,
                ),
                SizedBox(height: 20),

                // Sign Up Title
                Text(
                  "Create an Account",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 139, 69, 19), // Coffee color for the heading
                    fontFamily: 'Poppins', // Use the Poppins font or any font you like
                  ),
                ),
                SizedBox(height: 20),

                // Name TextField
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(color: Color.fromARGB(255, 139, 69, 19)), // Font color
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person, color: Color.fromARGB(255, 139, 69, 19)), // Icon color
                  ),
                  textAlign: TextAlign.center, // Center align text
                ),
                SizedBox(height: 16),

                // Email TextField
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Color.fromARGB(255, 139, 69, 19)), // Font color
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email, color: Color.fromARGB(255, 139, 69, 19)), // Icon color
                  ),
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center, // Center align text
                ),
                SizedBox(height: 16),

                // Password TextField
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Color.fromARGB(255, 139, 69, 19)), // Font color
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock, color: Color.fromARGB(255, 139, 69, 19)), // Icon color
                  ),
                  obscureText: true,
                  textAlign: TextAlign.center, // Center align text
                ),
                SizedBox(height: 20),

                // Sign Up Button
                ElevatedButton(
                  onPressed: registerUser,
                  child: Text("Sign Up", style: TextStyle(color: Colors.white)), // White text color
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 139, 69, 19), // Button color
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // Rounded corners for the button
                    ),
                  ),
                ),
                SizedBox(height: 10),

                // TextButton to Login Page
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Already have an account? Log in",
                    style: TextStyle(
                      color: Color.fromARGB(255, 139, 69, 19), // Coffee color for text button
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
