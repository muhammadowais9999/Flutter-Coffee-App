import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  final Function(String itemName) onOrderPlaced; // Callback function

  MenuPage({required this.onOrderPlaced}); // Constructor to accept the function

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Coffee Menu"),
        backgroundColor: Color.fromARGB(255, 139, 69, 19), // Coffee color
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Menu Title
              Text(
                "Our Coffees",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 139, 69, 19),
                ),
              ),
              SizedBox(height: 20),

              // Coffee Items List
              _buildCoffeeItem("Espresso", "images/coffee1.png", context),
              _buildCoffeeItem("Cappuccino", "images/coffee2.png", context),
              _buildCoffeeItem("Latte", "images/coffee3.png", context),
              _buildCoffeeItem("Mocha", "images/coffee4.png", context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCoffeeItem(String title, String imagePath, BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Image.asset(
              imagePath,
              width: 80,
              height: 80,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 139, 69, 19),
                    ),
                  ),
                  SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      onOrderPlaced(title); // Call the function to handle the order
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("$title added to cart!")),
                      );
                    },
                    child: Text("Add to Cart"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 139, 69, 19),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
