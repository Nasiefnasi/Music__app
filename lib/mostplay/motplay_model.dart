// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

import 'package:on_audio_query/on_audio_query.dart';
import 'package:song_m_app/functions/most&recplay/mostplay.dart';
import 'package:song_m_app/functions/most&recplay/recplay_function.dart';

class mostplay extends StatefulWidget {
  const mostplay({super.key});

  @override
  State<mostplay> createState() => _mostplayState();
}

class _mostplayState extends State<mostplay> {
  @override
  void initState() {
    initializes();

    super.initState();
  }

  Future initializes() async {
    await GetRecentlyPlayed.getRecentlysongs();
  }

  List mostplay = [];
  final OnAudioQuery _audioQuery = OnAudioQuery();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Getmostlyplayed.getmostlysongs(),
      builder: (context, item) {
        return ValueListenableBuilder(
          valueListenable: Getmostlyplayed.mostiyNotifer,
          builder: (context, value, child) {
            if (value.isEmpty && mostplay.isEmpty) {
              // ignore: prefer_const_constructors
              return Center(
                  child: const Text(
                'no song in your storage',
                style: TextStyle(color: Colors.white),
              ));
            } else {
              mostplay = value.reversed.toSet().toList();

              return FutureBuilder(
                  future: _audioQuery.querySongs(
                      sortType: null,
                      orderType: OrderType.ASC_OR_SMALLER,
                      uriType: UriType.INTERNAL,
                      ignoreCase: true),
                  builder: (context, item) {
                    if (item.data == null) {
                      const CircularProgressIndicator();
                    } else if (mostplay.isEmpty) {
                      return const Text('no songs');
                    }
                    return ListView.builder(
                        // physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: mostplay.length,
                        itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                color: const Color.fromARGB(145, 71, 71, 71),
                                child: ListTile(
                                  leading: QueryArtworkWidget(
                                    id: mostplay[index].id,
                                    type: ArtworkType.AUDIO,
                                    artworkHeight: 60,
                                    artworkWidth: 60,
                                    nullArtworkWidget: Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                            color: Colors.white10,
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        child: Image.asset(
                                          'assets/7ec111864f7539dce5362ccf235b61a4.png',
                                          fit: BoxFit.cover,
                                        )
                                        //  const Icon(
                                        //   Icons.music_note,
                                        //   color: Colors.white60,
                                        // ),
                                        ),
                                    artworkBorder: BorderRadius.circular(10),
                                    artworkFit: BoxFit.cover,
                                  ),
                                  title: Text(mostplay[index].displayNameWOExt,
                                      maxLines: 1,
                                      style: const TextStyle(
                                          color: Colors.white70)),
                                  subtitle: Text(
                                    mostplay[index].artist!,
                                    style:
                                        const TextStyle(color: Colors.white70),
                                    maxLines: 1,
                                  ),
                                ),
                              ),
                            )

                        //   ),
                        // ),
                        );
                  });
            }
          },
        );
      },
    );
  }
}
