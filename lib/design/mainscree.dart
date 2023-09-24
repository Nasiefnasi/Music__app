// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:song_m_app/all_song/all_Song.dart';
// import 'package:song_m_app/all_song/newallsong/allmusic.dart';
import 'package:song_m_app/bottom%20nav/bottom_nav.dart';
import 'package:song_m_app/design/History.dart';
import 'package:song_m_app/design/Home_page.dart';
import 'package:song_m_app/design/faverate.dart';
// import 'package:song_m_app/proiders/minaprovider.dart';
import 'package:song_m_app/provide/provides.dart';

class Mainpage extends StatelessWidget {
  Mainpage({super.key});
  List<Widget> pageList = const [
    Home(),
    Favorite(),
    // All_songlist(),
    All_songlist(),
    history_listt(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<mianscreenNotifer>(
      builder: (context, value, child) {
        return Scaffold(
            body: pageList[value.pageIndex],
            backgroundColor: Colors.transparent,
            bottomNavigationBar: SafeArea(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 65,
                margin: const EdgeInsets.all(12),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 69, 2, 93),
                        Color.fromARGB(255, 126, 3, 208)
                      ],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topLeft,
                      tileMode: TileMode.clamp,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Bottomnavigation(
                        ontap: () {
                          value.pageIndex = 0;
                        },
                        icon: value.pageIndex == 0
                            ? Icons.home
                            : Icons.home_outlined),
                    Bottomnavigation(
                        ontap: () {
                          value.pageIndex = 1;
                        },
                        icon: value.pageIndex == 1
                            ? Icons.favorite
                            : Icons.favorite_border),
                    Bottomnavigation(
                        ontap: () {
                          value.pageIndex = 2;
                        },
                        icon: value.pageIndex == 2
                            ? Icons.play_lesson_outlined
                            : Icons.play_lesson),
                    Bottomnavigation(
                        ontap: () {
                          value.pageIndex = 3;
                        },
                        icon: value.pageIndex == 3
                            ? Icons.history_outlined
                            : Icons.history_toggle_off_sharp),
                    // Bottomnavigation(
                    //     ontap: () {
                    //       value.pageIndex = 4;
                    //     },
                    //     icon: value.pageIndex == 4
                    //         ? Icons.person
                    //         : Icons.person_3_outlined),
                  ],
                ),
              ),
            )));
      },
    );
  }
}

// kk
