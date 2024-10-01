import 'package:flutter/material.dart';

class ProductDetailsPage extends StatelessWidget {
  final String name;
  final String image;
  final String price;
  final String ingredients;

  ProductDetailsPage({
    required this.name,
    required this.image,
    required this.price,
    required this.ingredients,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        backgroundColor: Color.fromARGB(255, 139, 69, 19),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Display the coffee image
          Image.asset(
            image,
            height: 200,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 20),
          // Coffee name and price
          Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.brown,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Price: $price',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 20),
          // Display ingredients
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Ingredients: $ingredients',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20),
          // Add to Cart Button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.brown, // Background color
            ),
            onPressed: () {
              // Add logic to handle adding to cart
              Navigator.pop(context, 'added'); // Pop and return status
            },
            child: Text('Add to Cart'),
          ),
        ],
      ),
    );
  }
}
