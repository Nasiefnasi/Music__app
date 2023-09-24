import 'package:flutter/material.dart';
import 'package:song_m_app/mostplay/motplay_model.dart';


// ignore: camel_case_types
class Most_Play extends StatelessWidget {
  const Most_Play({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        // playlist4VN (2:68)
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 2,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/main_bg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // ignore: prefer_const_literals_to_create_immutables
            children: [const Expanded(child: mostplay())],
          )),
        ),
      ),
    );
  }
}
