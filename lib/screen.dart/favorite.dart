// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/routes.dart';
import 'package:firebase/screen.dart/m.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Assuming the FavoriteProvider class is defined somewhere else in your code

class Favourite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    final favoriteIds = favoriteProvider.favorites;

    return Scaffold(
      appBar:   AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16),
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
                    "Wishlist",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: favoriteIds.isEmpty
            ? Center(
                child: Text(
                  'Your wishlist is empty',
                  style: TextStyle(fontSize: 18, ),
                ),
              )
            : ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                itemCount: favoriteIds.length,
                itemBuilder: (context, index) {
                  final productId = favoriteIds[index];
                  return FutureBuilder<DocumentSnapshot>(
                    future: FirebaseFirestore.instance
                        .collection('Products')
                        .doc(productId)
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (snapshot.hasData) {
                        final productData =
                            snapshot.data!.data() as Map<String, dynamic>;
                        return GestureDetector(
                          child: Card(
                            elevation: 5,
                            margin: EdgeInsets.only(bottom: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          productData['Image'],
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              productData['Brand Name'],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                            Text(
                                              '₹ ${productData['Price']}',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey[700]),
                                            ),
                                          ],
                                        ),
                                      ),
                                      ElevatedButton.icon(
                            onPressed: () {
                            
                            },
                            icon: Icon(Icons.delete),
                            label: Text("Remove"),
                            style: ElevatedButton.styleFrom(
                              primary: const Color.fromARGB(255, 135, 135, 135),
                            ),
                          ),
                                    ],
                                  ),
                                ),
                               
                              ],
                            ),
                          ),
                          onTap: () {
          Navigator.pushNamed(context, Routes.productscreen,arguments: {
            "Image":productData["Image"],
            "Brand Name":productData["Brand Name"],
             "Price":productData["Price"],
          }
         );
        },
                        );
                      } else {
                        return Center(child: Text('No products found.'));
                      }
                    },
                  );
                },
              ),
      ),
    );
  }
}
