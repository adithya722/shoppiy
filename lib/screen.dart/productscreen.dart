// ignore_for_file: prefer_const_constructors, unused_local_variable, use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase/routes.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final TextEditingController _reviewController = TextEditingController();
  double _rating = 0.0;
  late Future<List<Map<String, dynamic>>> _reviewsFuture;
   late Stream<QuerySnapshot>? productsList;
  late Map<String, dynamic> _productView;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _productView = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    _reviewsFuture = _fetchReviews(_productView["productname"] ?? "Unknown Product");
  }

  Future<List<Map<String, dynamic>>> _fetchReviews(String productName) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection("reviews")
          .where("productname", isEqualTo: productName)
          .get();

      return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    } catch (e) {
      print("Error fetching reviews: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = _productView["image"] ?? "";

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Row(
            children: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Text(
                  "Product Details",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
              IconButton(
                icon: Icon(Icons.share, color: Colors.black),
                onPressed: () {
                  // Implement sharing functionality here
                },
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildImageCarousel(imageUrl),
                    SizedBox(height: 20),
                    _buildProductInfo(),
                    SizedBox(height: 20),
                    _buildRatingSection(),
                    SizedBox(height: 20),
                    _buildReviewSection(),
                    SizedBox(height: 20),
                    _buildReviewList(),
                  ],
                ),
              ),
            ),
          ),
          _buildStickyBottomBar(),
        ],
      ),
    );
  }

  Widget _buildImageCarousel(String imageUrl) {
    if (imageUrl.isEmpty) {
      return Center(child: Text('No image available'));
    }

    return CarouselSlider(
      options: CarouselOptions(
        height: 300,
        autoPlay: true,
        enlargeCenterPage: true,
       
        viewportFraction: 0.8,
      ),
      items: [imageUrl].map((url) {
        return GestureDetector(
          onTap: () {
            _showImageDialog(url);
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              url,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Center(child: Text('Image not available'));
              },
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildProductInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _productView["productname"] ?? "Unknown Product",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          "₹${_productView["price"] ?? "Price not available"}",
          style: TextStyle(fontSize: 20, color: Colors.grey[800]),
        ),
        SizedBox(height: 12),
        Text(
          _productView["productdesc"] ?? "No description available",
          style: TextStyle(fontSize: 16, color: Colors.grey[800]),
        ),
      ],
    );
  }

  Widget _buildRatingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 40),
        Text(
          "Rate your products",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Row(
          children: List.generate(5, (index) {
            final rating = index + 1;
            return IconButton(
              icon: Icon(Icons.star, color: _rating >= rating ? Colors.yellow : Colors.grey),
              onPressed: () => _setRating(rating.toDouble()),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildReviewSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 27),
        Text(
          "Write a Review:",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        TextField(
          controller: _reviewController,
          decoration: InputDecoration(
            hintText: 'Write your review here...',
          ),
        ),
        SizedBox(height: 8),
        ElevatedButton(
          onPressed: _submitReview,
          child: Text("Submit Review"),
        ),
      ],
    );
  }

  Widget _buildStickyBottomBar() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Row(
        children: [
          SizedBox(width: 10),
          Expanded(
            child: ElevatedButton(
              onPressed: () => _addToCart(),
              child: Text("Add to Cart"),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: ElevatedButton(
              onPressed: () => _buyNow(),
              child: Text("Buy Now"),
            ),
          ),
        ],
      ),
    );
  }

  void _showImageDialog(String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl,
              fit: BoxFit.none,
              errorBuilder: (context, error, stackTrace) {
                return Center(child: Text('Image not available'));
              },
            ),
          ),
        );
      },
    );
  }

  void _setRating(double rating) {
    setState(() {
      _rating = rating;
    });
  }

  void _submitReview() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You need to be logged in to submit a review')),
      );
      return;
    }

    try {
      final userDoc = await FirebaseFirestore.instance.collection("user").doc(user.uid).get();
      final userName = userDoc.data()?["userId"] ?? "Anonymous";

      await FirebaseFirestore.instance.collection("reviews").add({
        "image": _productView["image"],
        "productname": _productView["productname"],
        "price": _productView["price"],
        "productdesc": _productView["productdesc"],
        "review": _reviewController.text,
        "rating": _rating,
        "userId": user.uid,
        "userName": userName,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Review submitted'), duration: Duration(seconds: 2)),
      );
      _reviewController.clear();
      setState(() {
        _rating = 0.0;
        _reviewsFuture = _fetchReviews(_productView["productname"] ?? "Unknown Product");
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to submit review: $error'), duration: Duration(seconds: 2)),
      );
    }
  }

  void _addToCart() {
    FirebaseFirestore.instance.collection("cart").add({
      "image": _productView["image"],
      "productname": _productView["productname"],
      "productdesc": _productView["productdesc"],
      "price": _productView["price"],
      "rating": _rating,
      "userId": FirebaseAuth.instance.currentUser?.uid,
    }).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Product added to cart'), duration: Duration(seconds: 2)),
      );
      Navigator.pushNamed(context, Routes.cart);
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add to cart: $error'), duration: Duration(seconds: 2)),
      );
    });
  }

  void _buyNow() {
    Navigator.pushNamed(
      context,
      Routes.buy,
      arguments: _productView,
    );
  }

  Widget _buildReviewList() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _reviewsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Failed to load reviews'));
        }

        final reviews = snapshot.data ?? [];

        if (reviews.isEmpty) {
          return Center(child: Text('No reviews yet'));
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Reviews:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            ...reviews.map((review) {
              return Card(
                elevation: 2,
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        review["userName"] ?? "Anonymous",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: List.generate(5, (index) {
                          final rating = index + 1;
                          return Icon(
                            Icons.star,
                            color: review["rating"] >= rating ? Colors.yellow : Colors.grey,
                          );
                        }),
                      ),
                      SizedBox(height: 4),
                      Text(
                        review["review"] ?? "No review provided",
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ],
        );
      },
    );
  }
}
