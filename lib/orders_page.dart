import 'package:flutter/material.dart';

class OrdersPage extends StatelessWidget {
  final List<String> orders; // List of orders

  OrdersPage({required this.orders}); // Constructor to accept orders

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Orders"),
        backgroundColor: Color.fromARGB(255, 139, 69, 19),
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(orders[index]),
          );
        },
      ),
    );
  }
}
