import 'package:flutter/material.dart';

import 'package:on_audio_query/on_audio_query.dart';
import 'package:song_m_app/control/control.dart';
import 'package:song_m_app/play%20Now%20controler/Now_play.dart';
// import 'package:on_audio_query/on_audio_query.dart';
import 'package:text_scroll/text_scroll.dart';

class Miniplayers extends StatefulWidget {
  const Miniplayers({
    super.key,
  });

  @override
  State<Miniplayers> createState() => _MiniplayersState();
}
// final List<SongModel > songmodel=[];

bool firstsong = false;
bool isplaying = true;
bool isPlaying = false;

class _MiniplayersState extends State<Miniplayers> {
  int currentIindex = 0;
  @override
  void initState() {
    GetAllSongController.audioPlayer.currentIndexStream.listen((index) {
      if (index == null && mounted) {
        setState(() {
          index == 0 ? firstsong = true : firstsong = false;
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return Now_Play(songModel: GetAllSongController.playingsong);

            // );
          },
        ));
      },
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: EdgeInsets.only(left: screenWidth * .03),
          child: Container(
            height: screenHight * 0.065,
            width: screenWidth * 0.9,
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 87, 4, 156),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 150,
                        child: StreamBuilder<bool>(
                          stream:
                              GetAllSongController.audioPlayer.playingStream,
                          builder: (context, snapshot) {
                            bool? playingstage = snapshot.data;
                            if (playingstage != null && playingstage) {
                              return TextScroll(
                                GetAllSongController
                                    .playingsong[GetAllSongController
                                        .audioPlayer.currentIndex!]
                                    .displayNameWOExt,
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.white60),
                              );
                            } else {
                              return Text(
// widget.songModel[currentindex]
//                                           .displayNameWOExt,

                                GetAllSongController
                                    .playingsong[GetAllSongController
                                        .audioPlayer.currentIndex!]
                                    .displayName,
                                // .playingsong[GetAllSongController
                                //     .audioPlayer.currentIndex!]
                                // .displayNameWOExt,
                                style: const TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    color: Colors.white60),
                              );
                            }
                          },
                        ),
                      ),
                      Wrap(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                                radius: 18,
                                child: QueryArtworkWidget(
                                  id: GetAllSongController
                                      .playingsong[GetAllSongController
                                          .audioPlayer.currentIndex!]
                                      .id,
                                  type: ArtworkType.AUDIO,
                                  artworkHeight: 60,
                                  artworkWidth: 60,
                                  // nullArtworkWidget: CircleAvatar(child: Image,),
                                )),
                          )
                        ],
                      ),
                      firstsong
                          ? IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.skip_previous,
                                color: Colors.white54,
                              ))
                          : IconButton(
                              onPressed: () {
                                if (GetAllSongController
                                    .audioPlayer.hasPrevious) {
                                  GetAllSongController.audioPlayer
                                      .seekToPrevious();
                                }
                              },
                              icon: const Icon(
                                Icons.skip_previous,
                                color: Colors.white,
                              )),
                      CircleAvatar(
                        backgroundColor:
                            const Color.fromARGB(255, 99, 211, 245),
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                isplaying = !isplaying;
                              });
                              if (GetAllSongController.audioPlayer.playing) {
                                GetAllSongController.audioPlayer.pause();
                              } else {
                                GetAllSongController.audioPlayer.play();
                              }
                            },
                            icon: Icon(
                              isplaying ? Icons.pause : Icons.play_arrow,
                              color: const Color.fromARGB(194, 210, 9, 9),
                            )),
                      ),
                      IconButton(
                          onPressed: () {
                            if (GetAllSongController.audioPlayer.hasNext) {
                              GetAllSongController.audioPlayer.seekToNext();
                            }
                          },
                          icon:
                              const Icon(Icons.skip_next, color: Colors.white))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
