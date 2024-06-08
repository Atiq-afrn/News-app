import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Views/screen2.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    // final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
        body: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'Images/splash_pic.jpg',
            fit: BoxFit.cover,
            height: height * .5,
          ),
          const SizedBox(
            height: .04,
          ),
          Text(
            "Top headlines ",
            style: GoogleFonts.anton(
                letterSpacing: .6, color: Colors.grey.shade700),
          ),
          const SizedBox(
            height: .04,
          ),
          const SpinKitChasingDots(
            color: Colors.blue,
            size: 50,
          )
        ],
      ),
    ));
  }
}
