

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:song_m_app/functions/most&recplay/mostplay.dart';
import 'package:song_m_app/functions/most&recplay/recplay_function.dart';
import 'package:song_m_app/mostplay/Most_Play.dart';
import 'package:song_m_app/recently/recently_play.dart';
import 'package:song_m_app/setteing/setting.dart';


// ignore: camel_case_types
class history_listt extends StatefulWidget {
  const history_listt({super.key});

  @override
  State<history_listt> createState() => _history_listtState();
}

class _history_listtState extends State<history_listt> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        drawer: const setting(),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(169, 84, 36, 116),
          centerTitle: true,
          // ignore: prefer_const_constructors
          title: Text('HISTORY'),
          actions: [
            Builder(builder: (context) {
              return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: const Icon(
                    Icons.settings,
                    color: Colors.white,
                    size: 25,
                  ));
            }),
          ],
          leading: IconButton(
              onPressed: () {
                //  @override
                //                void initState() {
                //   getmostlysongs();
                //   // TODO: implement initState
                //   super.initState();
                // }

                getmostlysongs();

                // Navigator.of(context).pop(context);
              },
              icon: const Icon(
                Icons.restore,
                color: Colors.white,
                size: 25,
              )),
          // automaticallyImplyLeading: false,
          bottom: const TabBar(tabs: [
            Tab(
              text: 'Most Play',
            ),
            Tab(
              text: 'Recently Play',
            )
          ]),
        ),
        body: TabBarView(children: [Most_Play(), RecentlyScreen()]),
      ),
    );
  }
}

Future<void> getmostlysongs() async {
  final mostplayDB = await Hive.box('mostsongNotifier');
  mostplayDB.clear();
  final recentplyDB = Hive.box('recentsongNotifier');
  recentplyDB.clear();

  GetRecentlyPlayed.recentNotifier.value.clear();
  Getmostlyplayed.mostiyNotifer.value.clear();
}
