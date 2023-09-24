// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:song_m_app/all_song/fav_music_tile.dart';

import 'package:on_audio_query/on_audio_query.dart';
import 'package:song_m_app/bottom%20nav/bottom_nav.dart';

class search_page extends StatefulWidget {
  const search_page({super.key});

  @override
  State<search_page> createState() => _search_pageState();
}

final OnAudioQuery _audioQuery = OnAudioQuery();
List<SongModel> totalSongs = [];
List<SongModel> displayresult = [];
TextEditingController _textcontroler = TextEditingController();

class _search_pageState extends State<search_page> {
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    fetchallsong();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.transparent,
        child: Container(
          color: const Color.fromARGB(230, 24, 24, 24),
          // ignore: prefer_const_literals_to_create_immutables
          child: Column(children: [
            const SizedBox(
              height: 30,
            ),
            const CircleAvatar(
              backgroundImage: AssetImage('assets/pexels-photo-3746156.webp'),
              radius: 80,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'MUHAMMAD NASIEF',
              style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 220, 213, 213),
                  fontWeight: FontWeight.bold),
            ),
            const Text(
              'nasinasief@gmail.com',
              style: TextStyle(
                  fontSize: 15,
                  color: Color.fromARGB(255, 149, 146, 146),
                  fontWeight: FontWeight.w400),
            ),
            const ListTile(
              // tileColor: Color.fromARGB(255, 85, 82, 82),
              title: Text(
                'About Playme',
                style: TextStyle(fontSize: 18, color: Colors.white38),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_outlined,
                color: Colors.white54,
              ),
            ),
            const ListTile(
              // tileColor: Color.fromARGB(255, 85, 82, 82),
              title: Text(
                'terms  and condition',
                style: TextStyle(fontSize: 18, color: Colors.white38),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_outlined,
                color: Colors.white54,
              ),
            ),
            const ListTile(
              // tileColor: Color.fromARGB(255, 85, 82, 82),
              title: Text(
                'privacy and policy',
                style: TextStyle(fontSize: 18, color: Colors.white38),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_outlined,
                color: Colors.white54,
              ),
            ),
            const ListTile(
              // tileColor: Color.fromARGB(255, 85, 82, 82),
              title: Text(
                'share  playMe',
                style: TextStyle(fontSize: 18, color: Colors.white38),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_outlined,
                color: Colors.white54,
              ),
            ),
          ]),
        ),
      ),
      backgroundColor: const Color.fromARGB(114, 41, 2, 56),
      body: SafeArea(
        child: Center(
          child: Container(
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/main_bg.jpg'), fit: BoxFit.cover),
            ),
            child: Column(
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
                              // Navigator.of(context).push(MaterialPageRoute(
                              //   builder: (context) => const Bottom_nav(),
                              // ));
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                          Image.asset(
                            'assets/logo blcak.png',
                            width: 50,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
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
                      })
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Search',
                        style: GoogleFonts.share(
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                            color: const Color.fromARGB(255, 139, 136, 136)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20)),
                          color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: CircleAvatar(
                          child: Image.asset('assets/logo blcak.png'),
                        ),
                      ),
                    ),
                    Container(
                      width: 260,
                      height: 40,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: TextField(
                          controller: _textcontroler,
                          onChanged: (value) => searchresult(value),
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(),
                            hintText: 'search your favorites songs....',
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            filled: true,
                            fillColor: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                          color: Colors.white),
                      child: !_textcontroler.text.isEmpty
                          ? InkWell(
                              onTap: () => setState(() {
                                _textcontroler.text = '';
                              }),
                              child: const Icon(
                                Icons.clear,
                                size: 35,
                                color: Colors.red,
                              ),
                            )
                          : const Icon(
                              Icons.search,
                              size: 35,
                              color: Colors.black,
                            ),
                    ),
                  ],
                ),
                displayresult.isEmpty
                    ? const Center(
                        child: Text(
                          'No Searched Songs',
                          style: TextStyle(color: Colors.white70, fontSize: 20),
                        ),
                      )
                    //           :  Expanded(
                    //    child: Padding(
                    //      padding: const EdgeInsets.all(8.0),
                    //      child: All_songlist(),
                    //    ),
                    //  ),
                    : Expanded(
                        child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child:
                        //  Allmusiclisttile(songmodel: displayresult),
                        Favtile(songmodel: displayresult),
                      )),
                const SizedBox(
                  height: 55,
                  width: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> fetchallsong() async {
    totalSongs = await _audioQuery.querySongs(
      sortType: null,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );
  }

  searchresult(String text) {
    List<SongModel> result = [];
    if (text.isEmpty) {
      return result = [];
    } else {
      result = totalSongs
          .where((element) => element.displayName
              .toUpperCase()
              .toLowerCase()
              .contains(text.toLowerCase()))
          .toList();
    }
    setState(() {
      displayresult = result;
    });
  }
}
