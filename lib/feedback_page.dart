import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore package

class FeedbackPage extends StatelessWidget {
  final TextEditingController feedbackController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // Firestore instance

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Feedback"),
        backgroundColor: Color.fromARGB(255, 139, 69, 19), // Coffee color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView( // Allow scrolling for longer feedback
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "We value your feedback!",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 139, 69, 19)),
              ),
              SizedBox(height: 10),
              Text(
                "Please share your thoughts and suggestions below:",
                style: TextStyle(fontSize: 16, color: Colors.grey[700]), // Subtle color for better readability
              ),
              SizedBox(height: 20),
              TextField(
                controller: feedbackController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Enter your feedback',
                  labelStyle: TextStyle(color: Color.fromARGB(255, 139, 69, 19)), // Coffee color for label
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color.fromARGB(255, 139, 69, 19), width: 2), // Thicker border on focus
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1), // Light grey border when not focused
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  String feedback = feedbackController.text;

                  // Save feedback to Firestore
                  _firestore.collection('feedbacks').add({
                    'message': feedback,
                    'timestamp': FieldValue.serverTimestamp(), // Current timestamp
                  }).then((value) {
                    // Feedback successfully added
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Feedback submitted!')),
                    );
                    feedbackController.clear(); // Clear the text field
                  }).catchError((error) {
                    // Handle errors here
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error submitting feedback: $error')),
                    );
                  });
                },
                child: Text("Submit Feedback"),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0), // Increased padding
                  backgroundColor: Color.fromARGB(255, 139, 69, 19), // Coffee color
                  foregroundColor: Colors.white, // Set the text color to white
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0), // Rounded corners
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
