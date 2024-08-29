import 'package:firebase/firebase_options.dart';

import 'package:firebase/roots.dart';
import 'package:firebase/screen.dart/m.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Demo());
}

class Demo extends StatelessWidget {
  const Demo({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(  providers: [     ChangeNotifierProvider(create: (_) => FavoriteProvider()),
 
    ],child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Root(),
      ),
    );
  }
}
