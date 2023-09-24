import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:song_m_app/all_song/all_Song.dart';
import 'package:song_m_app/search/search_page.dart';
import 'package:song_m_app/setteing/setting.dart';


class Romantics extends StatelessWidget {
  const Romantics({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const setting(),
      backgroundColor: const Color.fromARGB(114, 41, 2, 56),
      body: Center(
        child: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/main_bg.jpg'), fit: BoxFit.cover),
          ),
          child: Stack(children: [
            ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 40,
                              )),
                          Image.asset(
                            'assets/logo blcak.png',
                            width: 50,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Builder(builder: (context) {
                            return IconButton(
                                onPressed: () {
                                  Scaffold.of(context).openDrawer();
                                },
                                icon: const Icon(
                                  Icons.settings,
                                  color: Colors.white,
                                  size: 30,
                                ));
                          }),
                          Builder(builder: (context) {
                            return IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const search_page(),
                                  ));
                                },
                                icon: const Icon(
                                  Icons.search,
                                  color: Colors.white,
                                  size: 30,
                                ));
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Romantic',
                        style: GoogleFonts.share(
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                            color: const Color.fromARGB(255, 139, 136, 136)),
                      ),
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.all(8.0), child: All_songlist())
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
