// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:song_m_app/all_song/all_Song.dart';
import 'package:song_m_app/search/search_page.dart';
import 'package:song_m_app/setteing/setting.dart';


class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   drawer: setting(),
     
      backgroundColor: Color.fromARGB(114, 41, 2, 56),
      body: SafeArea(
        child: Center(
          child: Container(
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/main_bg.jpg'), fit: BoxFit.cover),
            ),
            child: Stack(children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            children: [
                             

                              Image.asset(
                                'assets/2222m_app.png',
                                width: 100,
                              )
                            ],
                          ),
                        ),
                        Builder(builder: (context) {
                          return IconButton(
                              onPressed: () {
                                Scaffold.of(context).openDrawer();       
                              },
                              icon: Icon(
                                Icons.settings,
                                color: Colors.white,
                                size: 30,
                              ));
                        }),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => search_page(),
                      ));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
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
                          child: Center(
                              child: Text('search your favorites songs...')),
                        
                        ),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(20)),
                              color: Colors.white),
                          child: const Icon(Icons.search),
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
                          'All Songs',
                          style: GoogleFonts.share(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Color.fromARGB(255, 139, 136, 136)),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: All_songlist(),
                    ),
                  )
                ],
              ),

              //   ),
              // ),
            ]),
          ),
        ),
      ),
    );
  }

}
