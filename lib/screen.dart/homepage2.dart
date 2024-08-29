// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase/routes.dart';
// import 'package:firebase/screen.dart/buy.dart';
// import 'package:firebase/screen.dart/cart.dart';

// import 'package:firebase/screen.dart/favorite.dart';
// import 'package:firebase/screen.dart/m.dart';

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class Homepage2 extends StatefulWidget {
//   const Homepage2({Key? key}) : super(key: key);

//   @override
//   State<Homepage2> createState() => _Homepage2State();
// }

// class _Homepage2State extends State<Homepage2> {
//   late Stream<QuerySnapshot>? productsList;
//   TextEditingController _searchController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     fetchProducts();
//   }

//   void fetchProducts() {
//     setState(() {
//       productsList =
//           FirebaseFirestore.instance.collection('Products').snapshots();
//     });
//   }

//   void filterProductsByCategory(String category) {
//     setState(() {
//       productsList = FirebaseFirestore.instance
//           .collection('Products')
//           .where("categories", isEqualTo: category)
//           .snapshots();
//     });
//   }

//   void searchProducts(String query) {
//     setState(() {
//       productsList = FirebaseFirestore.instance
//           .collection('Products')
//           .where("Brand Name", isGreaterThanOrEqualTo: query)
//           .where("Brand Name", isLessThanOrEqualTo: query + '\uf8ff')
//           .snapshots();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Image.asset(
//               'assets/homelogo.png',
//               fit: BoxFit.cover,
//               height: 25,
//               width: 20,
//             ),
//             const SizedBox(width: 8),
//             Text(
//               'Solid Shop',
//               style: TextStyle(
//                 color: Colors.blue,
//               ),
//             ),
//           ],
//         ),
//         actions: [
//           SizedBox(width: 17),
//           IconButton(
//             icon: Icon(Icons.shopping_cart_outlined),
//             color: Colors.blue,
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => const Cart()),
//               );
//             },
//           ),
//           SizedBox(width: 19),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             buildSearchBar(),
//             SizedBox(height: 30),
//           SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Row(children: [  categoryButton(word: 'All',onTap: (){
//                 setState(() {
//                    productsList = FirebaseFirestore.instance
//             .collection('Products')
//             .where("categories")
//             .snapshots();
//                 });
//               }),])
//               categoryButton(word: "Electronics", onTap: (){
//                 setState(() {
//                    productsList = FirebaseFirestore.instance
//             .collection('Products')
//             .where("categories",isEqualTo:"Electronics" )
//             .snapshots();
//                 });
//               }),

//                categoryButton(word: "Mobiles", onTap: (){
//                 setState(() {
//                    productsList = FirebaseFirestore.instance
//             .collection('Products')
//             .where("categories",isEqualTo:"Mobiles" )
//             .snapshots();
//                 });
//               }),
//                categoryButton(word: "Home appliances", onTap: (){
//                 setState(() {
//                    productsList = FirebaseFirestore.instance
//             .collection('Products')
//             .where("categories",isEqualTo:"Home appliances" )
//             .snapshots();
//                 });
//               }),
//                categoryButton(word: "Grocery", onTap: (){
//                 setState(() {
//                    productsList = FirebaseFirestore.instance
//             .collection('Products')
//             .where("categories",isEqualTo:"Grocery")
//             .snapshots();
//                 });
//               }),
//                categoryButton(word:  "Clothes", onTap: (){
//                 setState(() {
//                    productsList = FirebaseFirestore.instance
//             .collection('Products')
//             .where("categories",isEqualTo: "Clothes")
//             .snapshots();
//                 });
//               }),
//               categoryButton(word:   "Snacks", onTap: (){
//                 setState(() {
//                    productsList = FirebaseFirestore.instance
//             .collection('Products')
//             .where("categories",isEqualTo:  "Snacks")
//             .snapshots();
//                 });
//               }),],),
//           ),
//             SizedBox(height: 30),
//             buildBestSellingSection(),
//             SizedBox(height: 20),
//             buildSuggestionsSection(),
//           ],
//         ),
//       ),
//       bottomNavigationBar: buildBottomNavigationBar(),
//     );
//   }

//   Widget buildSearchBar() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//       child: TextField(
//         controller: _searchController,
//         onChanged: (query) => searchProducts(query),
//         decoration: InputDecoration(
//           prefixIcon: Icon(Icons.search, color: Colors.blue),
//           hintText: 'Search for products...',
//           hintStyle: TextStyle(color: Colors.blueGrey),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//       ),
//     );
//   }

//   // Widget categoryButtons() {
//   //   return SingleChildScrollView(
//   //     scrollDirection: Axis.horizontal,
//   //     padding: EdgeInsets.symmetric(horizontal: 16),
//   //     child: Row(
//   //       children: [
//   //         // buildCategoryButton("All", () {
//   //         //   fetchProducts();
//   //         // }),
//   //         // buildCategoryButton("Fashion", () {
//   //         //   filterProductsByCategory("Fashion");
//   //         // }),
//   //         // buildCategoryButton("Snacks", () {
//   //         //   filterProductsByCategory("Snacks");
//   //         // }),
//   //         // buildCategoryButton("Electronics", () {
//   //         //   filterProductsByCategory("Electronics");
//   //         // }),
//   //         // buildCategoryButton("Mobiles", () {
//   //         //   filterProductsByCategory("Mobiles");
//   //         // }),
//   //         // buildCategoryButton("Home appliances", () {
//   //         //   filterProductsByCategory("Home appliances");
//   //         // }),
//   //         // buildCategoryButton("Grocery", () {
//   //         //   filterProductsByCategory("Grocery");
//   //         // }),
//   //         // buildCategoryButton("Clothes", () {
//   //         //   filterProductsByCategory("Clothes");
//   //         // }),
//   //     categoryButton("Mobiles", () {
//   //           setState(() {
//   //             productsList = FirebaseFirestore.instance
//   //                 .collection("Products")
//   //                 .where("category",isEqualTo: "Mobiles").snapshots();
//   //           });
//   //         })
//   //       ],
//   //     ),
//   //   );
//   // }

//   Widget categoryButton({required String word, required Function()? onTap}) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         height: 35,
//         margin: EdgeInsets.only(left: 8),
//         decoration: BoxDecoration(
//           color: Colors.blue,
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: ElevatedButton(
//           onPressed: onTap,
//           child: Text(
//             word,
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               letterSpacing: 2,
//               color: Colors.white,
//             ),
//           ),
//         ),

//       ),

//     );
//   }

//   Widget buildBestSellingSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: Text(
//             "Best Selling",
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               color: Colors.blue,
//             ),
//           ),
//         ),
//         SizedBox(height: 20),
//         CarouselSlider(
//           items: [
//             buildCarouselItem("assets/shop.jpeg"),
//             buildCarouselItem("assets/trends.jpeg"),
//             buildCarouselItem("assets/mob.jpeg"),
//             buildCarouselItem("assets/d.jpeg"),
//           ],
//           options: CarouselOptions(
//             height: 200,
//             enlargeCenterPage: true,
//             initialPage: 0,
//             autoPlay: true,
//             autoPlayCurve: Curves.fastOutSlowIn,
//             autoPlayAnimationDuration: Duration(seconds: 5),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget buildCarouselItem(String imagePath) {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 7),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(7),
//         image: DecorationImage(
//           image: AssetImage(imagePath),
//           fit: BoxFit.cover, // Changed to cover to handle image overflow
//           filterQuality: FilterQuality.high,
//         ),
//       ),
//     );
//   }

//   Widget buildSuggestionsSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: Text(
//             "Suggestions for you",
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               color: Colors.blue,
//             ),
//           ),
//         ),
//         SizedBox(height: 13),
//         StreamBuilder<QuerySnapshot>(
//           stream: productsList,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             } else if (snapshot.hasError) {
//               return Center(
//                 child: Text("Error fetching data"),
//               );
//             } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//               return Center(
//                 child: Text("No products found"),
//               );
//             } else {
//               return GridView.builder(
//                 padding: EdgeInsets.all(1.0),
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   childAspectRatio: 0.7,
//                   crossAxisSpacing: 16,
//                   mainAxisSpacing: 16,
//                 ),
//                 itemCount: snapshot.data!.docs.length,
//                 shrinkWrap: true,
//                 physics: NeverScrollableScrollPhysics(),
//                 itemBuilder: (context, index) {
//                   final productmap = snapshot.data!.docs[index];
//                   return buildProductView(
//                     image: productmap["Image"],
//                     productname: productmap["Brand Name"],
//                     price: productmap["Price"],
//                     productdesc: productmap["productDescription"],
//                     productId: productmap.id, // Use document ID as product ID
//                   );
//                 },
//               );
//             }
//           },
//         ),
//       ],
//     );
//   }

//   Widget buildProductView({
//     required String image,
//     required String productname,
//     required String price,
//     required String productdesc,
//     required String productId,
//   }) {
//     return Consumer<FavoriteProvider>(
//       builder: (context, favoriteProvider, child) {
//         bool isFavorite = favoriteProvider.isFavorite(productId);

//         return GestureDetector(
//           child: Card(
//             elevation: 8,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(15),
//             ),
//             child: Stack(
//               children: [
//                 Container(
//                   height: 207.5,
//                   width: 164.4,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                         height: 150,
//                         decoration: BoxDecoration(
//                           image: DecorationImage(
//                             image: NetworkImage(image),
//                             fit: BoxFit.cover,
//                             filterQuality: FilterQuality.high,
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 6),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 8),
//                         child: Text(
//                           productname,
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 15,
//                             color: Color.fromARGB(255, 114, 115, 117),
//                           ),
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                       SizedBox(height: 2),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 8),
//                         child: Text(
//                           "₹ $price",
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 15,
//                             color: Color.fromARGB(255, 114, 115, 117),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Positioned(
//                   bottom: 21,
//                   right: 9,
//                   child: IconButton(
//                     onPressed: () {
//                       favoriteProvider.toggleFavorite(productId);
//                     },
//                     icon: Icon(
//                       isFavorite ? Icons.favorite : Icons.favorite_outline,
//                       color: isFavorite ? Colors.red : Colors.grey,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           onTap: () {
//             Navigator.pushNamed(context, Routes.productscreen, arguments: {
//               "image": image,
//               "productname": productname,
//               "price": price,
//               "productdesc": productdesc,
//               "productId": productId,
//             });
//           },
//         );
//       },
//     );
//   }

//   Widget buildBottomNavigationBar() {
//     return BottomNavigationBar(
//       type: BottomNavigationBarType.fixed,
//       fixedColor: Colors.blue,
//       items: [
//         BottomNavigationBarItem(
//           label: "Home",
//           icon: Icon(Icons.home),
//         ),
//         BottomNavigationBarItem(
//           label: "Categories",
//           icon: Icon(Icons.category_outlined),
//         ),
//         BottomNavigationBarItem(
//           label: "Wishlist",
//           icon: Icon(Icons.favorite),
//         ),
//         BottomNavigationBarItem(
//           label: "Account",
//           icon: Icon(Icons.person_outline),
//         ),
//       ],
//       onTap: (index) {
//         switch (index) {
//           case 0:
//             Navigator.pushNamed(context, Routes.home);
//             break;
//           case 1:
//             Navigator.pushNamed(context, Routes.categories);
//             break;
//           case 2:
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => Favourite()),
//             );
//             break;
//           case 3:
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => Buy()),
//             );
//             break;
//           default:
//             break;
//         }
//       },
//     );
//   }
// }

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/routes.dart';
import 'package:firebase/screen.dart/buy.dart';
import 'package:firebase/screen.dart/cart.dart';
import 'package:firebase/screen.dart/favorite.dart';
import 'package:firebase/screen.dart/m.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class Homepage2 extends StatefulWidget {
  const Homepage2({Key? key}) : super(key: key);

  @override
  State<Homepage2> createState() => _Homepage2State();
}

class _Homepage2State extends State<Homepage2> {
  late Stream<QuerySnapshot>? productsList;
  TextEditingController _searchController = TextEditingController();
  String selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  void fetchProducts() {
    setState(() {
      productsList = FirebaseFirestore.instance.collection('Products').snapshots();
    });
  }

  void filterProductsByCategory(String category) {
    setState(() {
      selectedCategory = category;
      if (category == 'All') {
        fetchProducts();
      } else {
        productsList = FirebaseFirestore.instance
            .collection('Products')
            .where("categories", isEqualTo: category)
            .snapshots();
      }
    });
  }

  void searchProducts(String query) {
    setState(() {
      productsList = FirebaseFirestore.instance
          .collection('Products')
          .where("Brand Name", isGreaterThanOrEqualTo: query)
          .where("Brand Name", isLessThanOrEqualTo: query + '\uf8ff')
          .snapshots();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/homelogo.png',
              fit: BoxFit.cover,
              height: 25,
              width: 20,
            ),
            const SizedBox(width: 8),
            Text(
              'Solid Shop',
              style: TextStyle(
                color: Color.fromARGB(255, 64, 168, 140),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart_outlined),
            color: Color.fromARGB(255, 22, 80, 65),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Cart()),
              );
            },
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSearchBar(),
            SizedBox(height: 20),
            buildCategoryButtons(),
            SizedBox(height: 20),
            buildBestSellingSection(),
            SizedBox(height: 20),
            buildSuggestionsSection(),
          ],
        ),
      ),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  Widget buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: TextField(
        controller: _searchController,
        onChanged: (query) => searchProducts(query),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: Color.fromARGB(255, 64, 168, 140),
          ),
          hintText: 'Search for products...',
          hintStyle: TextStyle(
            color: Color.fromARGB(255, 22, 80, 65),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget buildCategoryButtons() {
    const categories = [
      'All',
      'Electronics',
      'Mobiles',
      'Home appliances',
      'Grocery',
      'Clothes',
      'Snacks'
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((category) {
          return categoryButton(
            word: category,
            onTap: () => filterProductsByCategory(category),
            isSelected: category == selectedCategory,
          );
        }).toList(),
      ),
    );
  }

  Widget categoryButton({required String word, required Function()? onTap, required bool isSelected}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          primary: isSelected ? Color.fromARGB(255, 22, 80, 65) : Colors.grey[300],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          word,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            color: isSelected ? Colors.white : Color.fromARGB(255, 22, 80, 65),
          ),
        ),
      ),
    );
  }

  Widget buildBestSellingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "Best Selling",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 22, 80, 65),
            ),
          ),
        ),
        SizedBox(height: 20),
        CarouselSlider(
          items: [
            buildCarouselItem("assets/shop.jpeg"),
            buildCarouselItem("assets/trends.jpeg"),
            buildCarouselItem("assets/mob.jpeg"),
            buildCarouselItem("assets/d.jpeg"),
          ],
          options: CarouselOptions(
            height: 200,
            enlargeCenterPage: true,
            initialPage: 0,
            autoPlay: true,
            autoPlayCurve: Curves.fastOutSlowIn,
            autoPlayAnimationDuration: Duration(seconds: 5),
          ),
        ),
      ],
    );
  }

  Widget buildCarouselItem(String imagePath) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
          filterQuality: FilterQuality.high,
        ),
      ),
    );
  }

  Widget buildSuggestionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "Suggestions for you",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 22, 80, 65),
            ),
          ),
        ),
        SizedBox(height: 13),
        StreamBuilder<QuerySnapshot>(
          stream: productsList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error fetching data"));
            } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(child: Text("No products found"));
            }
            var filteredProducts = snapshot.data!.docs.toList();
            return StaggeredGridView.countBuilder(
              padding: EdgeInsets.all(16.0),
              crossAxisCount: 4,
              staggeredTileBuilder: (index) => StaggeredTile.fit(2),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final productMap = filteredProducts[index].data() as Map<String, dynamic>;
                return buildProductView(
                  image: productMap["Image"],
                  productName: productMap["Brand Name"],
                  price: productMap["Price"],
                  description: productMap["Description"],
                  productId: filteredProducts[index].id,
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget buildProductView({
    required String image,
    required String productName,
    required String price,
    required String description,
    required String productId,
  }) {
    return Consumer<FavoriteProvider>(
      builder: (context, favoriteProvider, child) {
        bool isFavorite = favoriteProvider.isFavorite(productId);

        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, Routes.productscreen, arguments: {
              "image": image,
              "productname": productName,
              "price": price,
              "description": description,
              "productId": productId,
            });
          },
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Stack(
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: NetworkImage(image),
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      color: Colors.black54,
                      padding: EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            productName,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4),
                          Text(
                            "₹ $price",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: IconButton(
                    onPressed: () {
                      favoriteProvider.toggleFavorite(productId);
                    },
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_outline,
                      color: isFavorite ? Colors.red : Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      fixedColor: Color.fromARGB(255, 22, 80, 65),
      items: [
        BottomNavigationBarItem(
          label: "Home",
          icon: Icon(
            Icons.home,
            color: Color.fromARGB(255, 22, 80, 65),
          ),
        ),
        BottomNavigationBarItem(
          label: "Categories",
          icon: Icon(
            Icons.category_outlined,
            color: Color.fromARGB(255, 22, 80, 65),
          ),
        ),
        BottomNavigationBarItem(
          label: "Wishlist",
          icon: Icon(
            Icons.favorite,
            color: Color.fromARGB(255, 22, 80, 65),
          ),
        ),
        BottomNavigationBarItem(
          label: "Account",
          icon: Icon(
            Icons.person_outline,
            color: Color.fromARGB(255, 22, 80, 65),
          ),
        ),
      ],
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushNamed(context, Routes.home);
            break;
          case 1:
            Navigator.pushNamed(context, Routes.categories);
            break;
          case 2:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Favourite()),
            );
            break;
          case 3:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Buy()),
            );
            break;
          default:
            break;
        }
      },
    );
  }
}
