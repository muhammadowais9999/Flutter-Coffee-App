import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'signup_page.dart'; // Create this later
import 'home_page.dart'; // Create this later

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> loginUser() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } catch (e) {
      print(e); // Handle login error
      // You might want to show a Snackbar or a dialog here to inform the user
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // App logo
                Image.asset(
                  'images/coffeelogo.png', // Add your app logo here
                  width: 100, // Adjust the width as needed
                  height: 100, // Adjust the height as needed
                ),
                SizedBox(height: 20),

                // Login Heading (newly added)
                Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 139, 69, 19), // Coffee color for the heading
                  ),
                ),
                SizedBox(height: 20),

                // Email TextField
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Color.fromARGB(255, 139, 69, 19)), // Coffee color
                    prefixIcon: Icon(Icons.email, color: Color.fromARGB(255, 139, 69, 19)), // Email icon
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color.fromARGB(255, 139, 69, 19)), // Coffee color
                    ),
                    border: OutlineInputBorder(),
                  ),
                  textAlign: TextAlign.center, // Center align text
                ),
                SizedBox(height: 16),

                // Password TextField
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Color.fromARGB(255, 139, 69, 19)), // Coffee color
                    prefixIcon: Icon(Icons.lock, color: Color.fromARGB(255, 139, 69, 19)), // Password icon
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color.fromARGB(255, 139, 69, 19)), // Coffee color
                    ),
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  textAlign: TextAlign.center, // Center align text
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Add forgot password functionality here
                    },
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(color: Color.fromARGB(255, 139, 69, 19)), // Coffee color
                    ),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: loginUser,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 139, 69, 19), // Coffee color
                    padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 100.0), // Wider button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0), // Rounded corners for a professional look
                    ),
                  ),
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 18, color: Colors.white), // White color for button text
                  ),
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => SignUpPage()));
                  },
                  child: Text(
                    "Don't have an account? Sign up",
                    style: TextStyle(color: Color.fromARGB(255, 139, 69, 19)), // Coffee color
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
