import 'package:flutter/material.dart';

import 'package:on_audio_query/on_audio_query.dart';
import 'package:song_m_app/functions/most&recplay/recplay_function.dart';

// ignore: camel_case_types
class recentmod extends StatefulWidget {
  const recentmod({super.key});

  @override
  State<recentmod> createState() => _recentmodState();
}

// ignore: camel_case_types
class _recentmodState extends State<recentmod> {
  @override
  void initState() {
    initializes();

    super.initState();
  }

  Future initializes() async {
    await GetRecentlyPlayed.getRecentlysongs();
  }
 
  List recentlist = [];
  final OnAudioQuery _audioQuery = OnAudioQuery();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: GetRecentlyPlayed.getRecentlysongs(),
      builder: (context, item) {
        return ValueListenableBuilder(
          valueListenable: GetRecentlyPlayed.recentNotifier,
          builder: (context, value, child) {
            if (value.isEmpty) {
              return const Center(
                child: Text(
                  'no song in your storage',
                  style: TextStyle(color: Colors.white),
                ),
              );
            } else {
              recentlist.clear();
              recentlist = value.reversed.toList();
              
            

              return FutureBuilder(
                  future: _audioQuery.querySongs(
                      sortType: null,
                      orderType: OrderType.ASC_OR_SMALLER,
                      uriType: UriType.INTERNAL,
                      ignoreCase: true),
                  builder: (context, item) {
                    if (item.data == null) {
                      const CircularProgressIndicator();
                    } else if (item.data!.isEmpty) {
                      return const Text('no songs');
                    }
                    return ListView.builder(
                      // physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: recentlist.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          color: const Color.fromARGB(145, 71, 71, 71),
                          child: ListTile(
                            leading: QueryArtworkWidget(
                              id: recentlist[index].id,
                              type: ArtworkType.AUDIO,
                              artworkHeight: 60,
                              artworkWidth: 60,
                              nullArtworkWidget: Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                    color: Colors.white10,
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Image.asset(
                                  'assets/7ec111864f7539dce5362ccf235b61a4.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              artworkBorder: BorderRadius.circular(10),
                              artworkFit: BoxFit.cover,
                            ),
                            title: Text(recentlist[index].displayNameWOExt,
                                maxLines: 1,
                                style: const TextStyle(color: Colors.white70)),
                            subtitle: Text(
                              recentlist[index].artist!,
                              style: const TextStyle(color: Colors.white70),
                              maxLines: 1,
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            }
          },
        );
      },
    );
  }
}
