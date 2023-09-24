// // ignore_for_file: camel_case_types

// import 'package:flutter/material.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';
// import 'package:song_m_app/design/Home_page.dart';
// import 'package:song_m_app/playlist_page.dart/plat_list_page.dart';
// import 'package:song_m_app/design/faverate.dart';
// import 'package:song_m_app/design/History.dart ';


// class Bottom_nav extends StatefulWidget {
//   const Bottom_nav({super.key});

//   @override
//   State<Bottom_nav> createState() => _Bottom_navState();
// }

// class _Bottom_navState extends State<Bottom_nav> {
//   int _currentIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       body: Stack(
//         children: [
//           _pages[_currentIndex],
//           // Positioned(
//           //     bottom: 0,
//           //     left: 0,
//           //     right: 10,
//           //     child: Column(
//           //       children: [
//           //         GetAllSongController.audioPlayer.currentIndex != null
//           //             ? const Miniplayers()
//           //             : Container()
//           //       ],
//           //     )),
//         ],
//       ),
//       bottomNavigationBar: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Padding(
//             padding:  EdgeInsets.all(10),
//             child: Container(
//               decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [
//                       Color.fromARGB(255, 69, 2, 93),
//                       Color.fromARGB(255, 126, 3, 208)
//                     ],
//                     begin: Alignment.bottomLeft,
//                     end: Alignment.topLeft,
//                     tileMode: TileMode.clamp,
//                   ),
//                   borderRadius: BorderRadius.all(Radius.circular(18))),
//               child: GNav(

//                   // _currentIndex:_currentIndex,
//                   onTabChange: (newIndex) {
//                     setState(() {
//                       _currentIndex = newIndex;
//                     });
//                   },
//                   gap: 3,
//                   // backgroundColor: const Color.fromARGB(0, 255, 193, 7),
//                   activeColor: Colors.white,
//                   tabBackgroundColor: const Color.fromARGB(31, 250, 250, 250),
//                   color: Colors.black,
//                   iconSize: 21,
//                   textSize: 10,
//                   tabs: [
//                     GButton(
//                       onPressed: () {
//                         // Navigator.of(context).push(MaterialPageRoute(builder:(context) =>  home(),));
//                       },
//                       icon: Icons.home,
//                       text: 'HOME',
//                     ),
//                     GButton(
//                       onPressed: () {
//                         // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const All_songs()));
//                       },
//                       icon: Icons.library_music_rounded,
//                       text: 'MUSICS',
//                     ),
//                     GButton(
//                       onPressed: () {
//                         // Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Favorite(),));
//                       },
//                       icon: Icons.favorite,
//                       text: 'FAVORITE',
//                     ),
//                     GButton(
//                       onPressed: () {
//                         // Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const history_listt()));
//                       },
//                       icon: Icons.history_sharp,
//                       text: 'HISTORY',
//                     ),
//                   ]),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   final _pages = [
//      Home(),
//      Home(),
//      Home(),
//      Home(),
//     // All_songs(),
   

//     // const Favorite(),
//     // const history_listt(),
//   ];
// }
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Bottomnavigation extends StatelessWidget {
  Bottomnavigation({super.key, required this.ontap, required this.icon});
  final void Function() ontap;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: SizedBox(
        width: 50,
        height: 59,
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}