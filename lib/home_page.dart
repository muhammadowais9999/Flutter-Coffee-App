import 'package:flutter/material.dart';
import 'cart_page.dart'; // Import the CartPage
import 'profile_page.dart'; // Import the ProfilePage
import 'feedback_page.dart'; // Import the FeedbackPage
import 'login_page.dart'; // Import your LoginPage here
import 'menu_page.dart'; // Import the MenuPage

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> cartItems = []; // List to store cart items
  int _selectedIndex = 0; // Track selected index for bottom navigation
  
  // List of coffee items with images and prices
  List<Map<String, String>> coffeeItems = [
    {'name': 'Espresso', 'image': 'images/coffee1.png', 'price': '3.99'},
    {'name': 'Cappuccino', 'image': 'images/coffee2.png', 'price': '4.99'},
    {'name': 'Latte', 'image': 'images/coffee3.png', 'price': '4.49'},
    {'name': 'Mocha', 'image': 'images/coffee4.png', 'price': '5.29'},
  ];

  void handleAddToCart(String itemName, String image, double price) {
    setState(() {
      cartItems.add({
        'title': itemName,
        'image': image,
        'price': price,
        'quantity': 1,
      });
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        // Navigate to MenuPage and pass the onOrderPlaced callback
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MenuPage(
              onOrderPlaced: (orderDetails) {
                // Handle order placement here, e.g., show a message or update cart
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Order placed: $orderDetails")),
                );
              },
            ),
          ),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CartPage(cartItems: cartItems),
          ),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfilePage(), // Navigate to ProfilePage
          ),
        );
        break;
    }
  }

  // Function to handle logout
  void _logout() {
    // Implement logout logic here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Logged out successfully")),
    );
    // Navigate to the login page
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()), // Replace with your actual login page widget
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Coffee Craft"),
        backgroundColor: Color.fromARGB(255, 139, 69, 19),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(cartItems: cartItems),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 20), // Space between the AppBar and the grid
          // GridView for coffee items with images and prices
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 items per row
                childAspectRatio: 3 / 4, // Adjust aspect ratio for image and text
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: coffeeItems.length,
              itemBuilder: (context, index) {
                final coffeeItem = coffeeItems[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Coffee Image
                      Expanded(
                        child: Image.asset(
                          coffeeItem['image']!,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 10),
                      // Coffee Name
                      Text(
                        coffeeItem['name']!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.brown,
                        ),
                      ),
                      SizedBox(height: 5),
                      // Coffee Price
                      Text(
                        "\$${coffeeItem['price']!}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                      SizedBox(height: 10),
                      // Add to Cart Button
                      ElevatedButton(
                        onPressed: () {
                          handleAddToCart(
                            coffeeItem['name']!,
                            coffeeItem['image']!,
                            double.parse(coffeeItem['price']!),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("${coffeeItem['name']} added to cart")),
                          );
                        },
                        child: Text(
                          "Add to Cart",
                          style: TextStyle(color: Colors.white), // Set text color to white
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 139, 69, 19),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Menu"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "My Profile"), // My Profile
        ],
        onTap: _onItemTapped,
      ),
      drawer: Drawer( // Drawer for additional navigation
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 139, 69, 19),
              ),
              child: Column(
                children: [
                  Text(
                    'Welcome',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Your Name', // Replace with the user's name
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text('Orders'),
              onTap: () {
                // Implement orders page navigation
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Orders page is not implemented yet")),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.feedback),
              title: Text('Feedback'),
              onTap: () {
                // Navigate to FeedbackPage
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FeedbackPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: _logout, // Call logout function
            ),
          ],
        ),
      ),
    );
  }
}
