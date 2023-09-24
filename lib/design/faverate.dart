import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:on_audio_query/on_audio_query.dart';
import 'package:song_m_app/all_song/fav_music_tile.dart';
import 'package:song_m_app/functions/favorite_funtion.dart';
import 'package:song_m_app/search/search_page.dart';
import 'package:song_m_app/setteing/setting.dart';


class Favorite extends StatelessWidget {
  const Favorite({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: setting(),
     
      backgroundColor: const Color.fromARGB(114, 41, 2, 56),
      body: Center(
        child: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/main_bg.jpg'), fit: BoxFit.cover),
          ),
          child: Stack(children: [
            Column(
              children: [
                SizedBox(height: 30,),
              
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          Image.asset(
                            'assets/logo blcak.png',
                            width: 50,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Image.asset(
                            'assets/2222m_app.png',
                            width: 100,
                          )
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
                  child: Text(
                    'Favorite',
                    style: GoogleFonts.share(
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                        color: const Color.fromARGB(255, 139, 136, 136)),
                  ),
                ),
                   Expanded(
                     child: SizedBox(
                              child: ValueListenableBuilder(
                                  valueListenable: Favorite_Database.favoritesongs,
                                  builder: (context, List<SongModel> favoritedata,
                                      Widget? child) {
                                    if (favoritedata.isEmpty) {
                                      return const Center(
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 300),
                                          child: Text(
                                            'No songs in favourites',
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white70,
                                            ),
                                          ),
                                        ),
                                      );
                                    } else {
                                      final temp = favoritedata.reversed.toList();
                                      favoritedata = temp.toSet().toList();
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Favtile(songmodel: favoritedata)
                                      );
                                    }
                                  })),
                   )
              
              ],
            ),

            //   ),
            // ),
          ]),
        ),
      ),
    );
  }
}
