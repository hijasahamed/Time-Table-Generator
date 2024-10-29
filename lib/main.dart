import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:time_table/firebase/firebase_options.dart';
import 'package:time_table/view/home_screen/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize =MediaQuery.of(context).size;
    return MaterialApp(
      title: 'Time Table',
      debugShowCheckedModeBanner: false,      
      home: HomeScreen(screenSize: screenSize),
    );
  }
}