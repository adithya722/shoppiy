

import 'package:flutter/material.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //     backgroundColor: Colors.white,
      //     leading: Builder(
      //       builder: (BuildContext context) {
      //         return IconButton(
      //           icon: const Icon(
      //             Icons.menu,
      //             color: Color.fromARGB(
      //                 255, 100, 47, 24), // Change Custom Drawer Icon Color
      //           ),
      //           onPressed: () {
      //             Scaffold.of(context).openDrawer();
      //           },
      //           tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
      //         );
      //       },
      //     ),
      //     title: Row(
      //       mainAxisAlignment: MainAxisAlignment.start,
      //       children: [
      //         Container(
      //           padding: const EdgeInsets.all(5.0),
      //           child: Text(
      //             'Categories',
      //             style: TextStyle(color: Color.fromARGB(255, 78, 46, 35)),
      //           ),
      //         ),
      //       ],
      //     )),
      // drawer: Drawer(
      //   child: ListView(
      //     padding: EdgeInsets.only(top: 170),
      //     children: [
      //       ListTile(
      //         leading: const Icon(Icons.woman_outlined),
      //         title: const Text(
      //           'fashion',
      //           style: TextStyle(
      //             fontSize: 16,
      //             color: Color.fromARGB(255, 64, 3, 45),
      //           ),
      //         ),
      //         onTap: () {
      //           Navigator.pushNamed(context, Routes.fashion);
      //         },
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.masks_outlined),
      //         title: const Text(
      //           'Makeup',
      //           style: TextStyle(
      //             fontSize: 16,
      //             color: Color.fromARGB(255, 64, 42, 3),
      //           ),
      //         ),
      //         onTap: () {
      //           Navigator.pushNamed(context, Routes.makeup);
      //         },
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.phone_android_rounded),
      //         title: const Text(
      //           'mobiles',
      //           style: TextStyle(
      //             fontSize: 16,
      //             color: Color.fromARGB(255, 64, 42, 3),
      //           ),
      //         ),
      //         onTap: () {
      //           Navigator.pushNamed(context, Routes.mobile);
      //         },
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.home),
      //         title: const Text(
      //           'homeappliance',
      //           style: TextStyle(
      //             fontSize: 16,
      //             color: Color.fromARGB(255, 64, 42, 3),
      //           ),
      //         ),
      //         onTap: () {
      //           Navigator.pushNamed(context, Routes.homeappliances);
      //         },
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.food_bank_outlined),
      //         title: const Text(
      //           'snacks',
      //           style: TextStyle(
      //             fontSize: 16,
      //             color: Color.fromARGB(255, 64, 42, 3),
      //           ),
      //         ),
      //         onTap: () {
      //           Navigator.pushNamed(context, Routes.snacks);
      //         },
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
