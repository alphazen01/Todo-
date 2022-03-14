import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo/screens/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
      Duration(seconds: 5),
       ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>HomeScreen()))
      );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Todo!",
                 style: TextStyle(
                  color: Colors.white,
                  fontSize: 44,
                  fontWeight: FontWeight.bold,
                ),
              ),
              CircularProgressIndicator(
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}