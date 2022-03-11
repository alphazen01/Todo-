import 'package:flutter/material.dart';
import 'package:todo/screens/home.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home:HomeScreen()
    )
  );
}

