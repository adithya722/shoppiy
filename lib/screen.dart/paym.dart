// ignore_for_file: prefer_const_constructors, deprecated_member_use, sort_child_properties_last

import 'package:firebase/routes.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  final _addressController = TextEditingController();
  final _flatController = TextEditingController();
  final _trademarkController = TextEditingController();
  final _areaController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    "Add Address and Phone Number",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField(_addressController, 'House Address', 'Enter your house address', Icons.house, maxLines: 3),
              SizedBox(height: 16),
              _buildTextField(_areaController, 'Area', 'Enter the area', Icons.location_city),
              SizedBox(height: 16),
              _buildTextField(_flatController, 'Flat No.', 'Enter flat number', Icons.apartment),
              SizedBox(height: 16),
              _buildTextField(_trademarkController, 'Landmark', 'Enter landmark', Icons.location_on),
              SizedBox(height: 16),
              _buildTextField(_phoneController, 'Phone Number', 'Enter your phone number', Icons.phone, keyboardType: TextInputType.phone),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final address = _addressController.text.trim();
                  final phone = _phoneController.text.trim();

                  if (address.isEmpty || phone.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please fill out all fields'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                    return;
                  }

                  // Save to Firestore
                  FirebaseFirestore.instance.collection('pay').add({
                    'address': address,
                    'phone': phone,
                    'flat': _flatController.text.trim(),
                    'area': _areaController.text.trim(),
                    'landmark': _trademarkController.text.trim(),
                  }).then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Details saved successfully'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                    Navigator.of(context).pushNamed(Routes.check); // Navigate back after saving
                  }).catchError((error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Failed to save details'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  });
                },
                child: Text("Proceed to Pay"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, String hint, IconData icon, {int maxLines = 1, TextInputType keyboardType = TextInputType.text}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.blueAccent),
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: EdgeInsets.all(16),
        ),
        maxLines: maxLines,
        keyboardType: keyboardType,
      ),
    );
  }
}
