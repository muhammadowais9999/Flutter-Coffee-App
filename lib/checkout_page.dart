import 'package:flutter/material.dart';

class CheckoutPage extends StatefulWidget {
  final double totalAmount;

  CheckoutPage({required this.totalAmount});

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController voucherController = TextEditingController();
  String paymentMethod = "credit_card"; // Default payment method

  @override
  void initState() {
    super.initState();
    // Pre-fill the address fields if needed.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Checkout"),
        backgroundColor: Color.fromARGB(255, 139, 69, 19),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Delivery Address",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 139, 69, 19)),
              ),
              SizedBox(height: 16),
              _buildAddressForm(),
              SizedBox(height: 20),
              Text(
                "Payment Method",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 139, 69, 19)),
              ),
              SizedBox(height: 16),
              _buildPaymentMethod(),
              SizedBox(height: 20),
              _buildVoucherSection(),
              SizedBox(height: 20),
              _buildSummary(),
              SizedBox(height: 20),
              _buildCheckoutButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddressForm() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Full Name", border: OutlineInputBorder()),
            ),
            SizedBox(height: 10),
            TextField(
              controller: addressController,
              decoration: InputDecoration(labelText: "Address", border: OutlineInputBorder()),
              maxLines: 2,
            ),
            SizedBox(height: 10),
            TextField(
              controller: cityController,
              decoration: InputDecoration(labelText: "City", border: OutlineInputBorder()),
            ),
            SizedBox(height: 10),
            TextField(
              controller: postalCodeController,
              decoration: InputDecoration(labelText: "Postal Code", border: OutlineInputBorder()),
            ),
            SizedBox(height: 10),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: "Phone Number", border: OutlineInputBorder()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethod() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: Text("Credit Card"),
              leading: Radio(
                value: "credit_card",
                groupValue: paymentMethod,
                onChanged: (value) {
                  setState(() {
                    paymentMethod = value.toString();
                  });
                },
              ),
            ),
            ListTile(
              title: Text("Cash on Delivery"),
              leading: Radio(
                value: "cash",
                groupValue: paymentMethod,
                onChanged: (value) {
                  setState(() {
                    paymentMethod = value.toString();
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVoucherSection() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Voucher Code",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 139, 69, 19)),
            ),
            SizedBox(height: 10),
            TextField(
              controller: voucherController,
              decoration: InputDecoration(
                labelText: "Enter Voucher Code",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Implement voucher validation logic
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Voucher applied successfully!")),
                );
              },
              child: Text("Apply Voucher"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 139, 69, 19), // Button background color
                foregroundColor: Colors.white, // Set the text color to white
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummary() {
    double tax = widget.totalAmount * 0.1; // Assuming a 10% tax
    double discount = 0.0; // Default discount amount
    if (voucherController.text == "DISCOUNT10") {
      discount = 10.0; // Example discount amount
    }
    double finalTotal = widget.totalAmount + tax - discount;

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Order Summary",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 139, 69, 19)),
            ),
            SizedBox(height: 10),
            _buildSummaryRow("Subtotal", "\$${widget.totalAmount.toStringAsFixed(2)}"),
            _buildSummaryRow("Tax (10%)", "\$${tax.toStringAsFixed(2)}"),
            _buildSummaryRow("Discount", "-\$${discount.toStringAsFixed(2)}"),
            Divider(),
            _buildSummaryRow("Total", "\$${finalTotal.toStringAsFixed(2)}", isTotal: true),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String title, String amount, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(fontSize: isTotal ? 18 : 16)),
        Text(amount, style: TextStyle(fontSize: isTotal ? 18 : 16)),
      ],
    );
  }

  Widget _buildCheckoutButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          // Implement checkout logic here
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Order Placed Successfully!")),
          );
        },
        child: Text("Place Order"),
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 139, 69, 19), // Button background color
          foregroundColor: Colors.white, // Set the text color to white
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          textStyle: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
