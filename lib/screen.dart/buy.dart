// ignore_for_file: unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase/routes.dart';
import 'package:flutter/material.dart';
import 'package:input_quantity/input_quantity.dart';

class Buy extends StatefulWidget {
  const Buy({Key? key}) : super(key: key);

  @override
  State<Buy> createState() => _BuyState();
}

class _BuyState extends State<Buy> {
  dynamic totalprice = 0.0;
  dynamic productQuantity = 1;
  Map<String, dynamic>? productArgs;
  String _selectedPaymentMethod = 'Credit Card'; // Default payment method
  bool isloading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchProductArgsAndPrice();
  }

  Future<void> _fetchProductArgsAndPrice() async {
    final arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (arguments != null) {
      setState(() {
        productArgs = arguments;
        final productPrice = double.tryParse(arguments["price"]?.toString() ?? '0') ?? 0.0;
        totalprice = productPrice * productQuantity;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final productArg = productArgs ?? (ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?);

    if (productArg == null) {
      return Scaffold(
        body: Center(child: Text('No product details available')),
      );
    }

    final productPrice = productArg["price"] ?? '0';
    final price = double.tryParse(productPrice.toString()) ?? 0.0;
    final productName = productArg["productname"] ?? "Unknown Product";
    final productImage = productArg["image"] ?? "";
    final desc = productArg["productdesc"] ?? "";
    totalprice = price * productQuantity;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Text(
                    "Review Your Order",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Product details section
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: productImage.isNotEmpty
                              ? (productImage.startsWith('http')
                                  ? NetworkImage(productImage)
                                  : AssetImage(productImage) as ImageProvider)
                              : AssetImage('assets/cll.png'), // Fallback asset
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            productName,
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "₹ ${price.toStringAsFixed(2)}",
                            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Quantity",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              InputQty(
                                maxVal: 20,
                                initVal: 1,
                                minVal: 1,
                                steps: 1,
                                onQtyChanged: (val) {
                                  setState(() {
                                    productQuantity = val;
                                    totalprice = price * productQuantity;
                                  });
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          const Divider(),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Total Price:",
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "₹ ${totalprice.toStringAsFixed(2)}",
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Payment method section
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Payment Method",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    _buildPaymentMethodOption('Credit Card', 'assets/creditcard.png'),
                    _buildPaymentMethodOption('PayPal', 'assets/paypal.png'),
                    _buildPaymentMethodOption('Google Pay', 'assets/gpay.png'),
                    _buildPaymentMethodOption('Cash on Delivery', 'assets/del.png'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Order summary and action buttons
            const Text(
              "Order Summary",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () async {
                if (isloading) return; // Prevent multiple submissions
                setState(() {
                  isloading = true;
                });

                try {
                  await FirebaseFirestore.instance.collection("buy").add({
                    "image": productImage,
                    "productname": productName,
                    "productdesc": desc,
                    "price": totalprice,
                    "userId": FirebaseAuth.instance.currentUser?.uid,
                  });

                  await Future.delayed(Duration(seconds: 2));

                  Navigator.of(context).pushNamed(Routes.paym);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: $e')),
                  );
                } finally {
                  setState(() {
                    isloading = false;
                  });
                }
              },
              child: isloading
                  ? const CircularProgressIndicator()
                  : const Text("Buy Now"),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
              style: OutlinedButton.styleFrom(
                primary: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodOption(String title, String iconPath) {
    return ListTile(
      leading: Radio<String>(
        value: title,
        groupValue: _selectedPaymentMethod,
        onChanged: (value) {
          if (value != null) {
            setState(() {
              _selectedPaymentMethod = value;
            });
          }
        },
      ),
      title: Row(
        children: [
          Image.asset(
            iconPath,
            height: 27,
            width: 25,
          ),
          const SizedBox(width: 8),
          Text(title),
        ],
      ),
    );
  }
}
