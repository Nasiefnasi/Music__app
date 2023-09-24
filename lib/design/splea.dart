// ignore_for_file: camel_case_types

import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:song_m_app/bottom%20nav/bottom_nav.dart';
import 'package:song_m_app/bottom nav/bottom_nav.dart';
import 'package:song_m_app/design/Home_page.dart';
import 'package:song_m_app/design/mainscree.dart';
import 'package:song_m_app/provide/provides.dart';
// import 'package:m_app/bottom%20nav/bottom_nav.dart';

class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Mainpage(),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          alignment: Alignment.center,
          // fit: StackFit.loose,
          children: [
            Image.asset(
              'assets/bg image.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Container(
              height: 150,
              width: 150,
              // ignore: sort_child_properties_last
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Image.asset(
                  'assets/Club Logo.png',
                ),
              ),
              // color: Colors.white,

              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(34),
                  ),
                  color: Color.fromARGB(255, 255, 254, 255),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 43, 41, 41),
                      blurRadius: 20,
                    )
                  ]),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 150),
                  child: Image.asset(
                    'assets/2222m_app.png',
                    width: 200,
                  ),
                ),
                const CircularProgressIndicator(
                  color: Colors.yellow,
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            )
          ]),
    );
  }
}
