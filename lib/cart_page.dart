import 'package:flutter/material.dart';
import 'checkout_page.dart'; // Import CheckoutPage here

class CartPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;

  CartPage({required this.cartItems});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Cart"),
        backgroundColor: Color.fromARGB(255, 139, 69, 19), // Coffee color
        iconTheme: IconThemeData(color: Colors.white), // Set back button color to white
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Items in Your Cart",
                style: TextStyle(
                  fontSize: 26, // Increased font size
                  fontWeight: FontWeight.w700, // Made it bold
                  color: Color.fromARGB(255, 139, 69, 19), // Coffee color
                  decoration: TextDecoration.underline, // Optional underline for emphasis
                ),
              ),
              SizedBox(height: 20),

              // Check if cart is empty
              if (widget.cartItems.isEmpty)
                Center(
                  child: Text(
                    "Your cart is empty!",
                    style: TextStyle(fontSize: 18, color: Colors.red),
                  ),
                )
              else
                // Display cart items
                ListView.builder(
                  itemCount: widget.cartItems.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return _buildCartItem(widget.cartItems[index]);
                  },
                ),

              SizedBox(height: 20),

              // Total Price
              Text(
                "Total: \$${_calculateTotal()}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 139, 69, 19),
                ),
              ),
              SizedBox(height: 20),

              // Checkout Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (widget.cartItems.isEmpty) {
                      // Show Snackbar if cart is empty
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Your cart is empty!"),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    } else {
                      // Navigate to Checkout Page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CheckoutPage(totalAmount: _calculateTotal()),
                        ),
                      );
                    }
                  },
                  child: Text("Proceed to Checkout"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 139, 69, 19), // Button background color
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    textStyle: TextStyle(fontSize: 18), // Only set the font size here
                    foregroundColor: Colors.white, // Set the text color to white
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCartItem(Map<String, dynamic> item) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Image.asset(
              item['image'],
              width: 80,
              height: 80,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['title'],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 139, 69, 19),
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$${item['price']} x ${item['quantity']}",
                        style: TextStyle(fontSize: 16),
                      ),
                      IconButton(
                        icon: Icon(Icons.remove, color: Colors.red),
                        onPressed: () {
                          _updateQuantity(item, -1);
                        },
                      ),
                      Text(
                        "${item['quantity']}",
                        style: TextStyle(fontSize: 16),
                      ),
                      IconButton(
                        icon: Icon(Icons.add, color: Colors.green),
                        onPressed: () {
                          _updateQuantity(item, 1);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          _removeItem(item);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _calculateTotal() {
    double total = 0.0;
    for (var item in widget.cartItems) {
      total += item['price'] * item['quantity'];
    }
    return total;
  }

  void _updateQuantity(Map<String, dynamic> item, int change) {
    setState(() {
      if (item['quantity'] + change > 0) {
        item['quantity'] += change;
      } else {
        _removeItem(item);
      }
    });
  }

  void _removeItem(Map<String, dynamic> item) {
    setState(() {
      widget.cartItems.remove(item);
    });
  }
}
