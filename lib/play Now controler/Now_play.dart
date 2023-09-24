// ignore_for_file: camel_case_types


// import 'dart:ffi';

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';


import 'package:on_audio_query/on_audio_query.dart';
import 'package:song_m_app/bottom%20nav/bottom_nav.dart';
import 'package:song_m_app/box_design/Now_Play_demo.dart';
import 'package:song_m_app/control/control.dart';
import 'package:song_m_app/functions/favorite_funtion.dart';
import 'package:song_m_app/play%20Now%20controler/Player_Controler.dart';
import 'package:song_m_app/functions/favorite_funtion.dart';

class Now_Play extends StatefulWidget {
  final List<SongModel> songModel;
  final int count;

  const Now_Play({
    super.key,
    required this.songModel,
    this.count = 0,
  });

  @override
  State<Now_Play> createState() => _Now_PlayState();
}

class _Now_PlayState extends State<Now_Play> {
  late StreamSubscription<Duration> _positionSubcripton;
  Duration _duration = const Duration();
  Duration _position = const Duration();
  int large = 0;
  int currentindex = 0;

  bool firstsong = false;
  bool lastsong = false;
  bool shuffle = false;

  @override
  void initState() {
    GetAllSongController.audioPlayer.currentIndexStream.listen((ind) {
      if (ind != null) {
        GetAllSongController.currentIndexes = ind;
        if (mounted) {
          setState(() {
            large = widget.count - 1;
            currentindex = ind;
            ind == 0 ? firstsong == true : firstsong == false;
            ind == large ? lastsong = true : lastsong = false;
          });
        }
      }
    });

    super.initState();
    playsong() ;
  }

  playsong() {
    GetAllSongController.audioPlayer.play();
    GetAllSongController.audioPlayer.durationStream.listen((D) {
      _duration = D!;
    });
    _positionSubcripton =
        GetAllSongController.audioPlayer.positionStream.listen((P) {
      setState(() {
        _position = P;
      });
    });
  }

  ChangeToSecond(int seconds) {
    Duration duration = Duration(seconds: seconds);
    GetAllSongController.audioPlayer.seek(duration);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: ListView(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: New_Box(
                          child: IconButton(
                              onPressed: () {
                                // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const Bottom_nav(),), (route) => false);
                              },
                              icon: const Icon(Icons.arrow_back))),
                    ),
                    const Text(
                      ' P   L   A   Y   N   O   W ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: New_Box(
                          child: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.settings))),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                New_Box(
                  child: Column(
                    children: [
                      // ArtworkWidget(widget: widget, currentindex: currentindex),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: QueryArtworkWidget(
                            keepOldArtwork: true,
                            id: widget.songModel[currentindex].id,
                            type: ArtworkType.AUDIO,
                            artworkWidth: 340,
                            artworkHeight: 250,
                            artworkFit: BoxFit.cover,
                            artworkBorder: const BorderRadius.all(
                              Radius.circular(2),
                            ),
                            nullArtworkWidget: Container(
                                height: 250,
                                width: 250,
                                decoration: const BoxDecoration(
                                    color: Colors.white10,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                                child: const Icon(
                                  Icons.music_note_rounded,
                                  size: 120,
                                  color: Colors.amber,
                                )),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 200,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      //  widget.songModel[currentindex].artist
                                      //                   .toString() ==
                                      //               "unknown"
                                      //           ? "Unknown Artist"
                                      //           : widget
                                      //               .songModel[currentindex].artist
                                      //               .toString(),
                                      //       overflow: TextOverflow.fade,
                                      //       maxLines: 1,
                                      //       softWrap: false,
                                      widget.songModel[currentindex]
                                          .displayNameWOExt,
                                      // overflow: TextOverflow.fade,
                                      maxLines: 1,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      widget.songModel[currentindex].artist
                                                  .toString() ==
                                              "unknown"
                                          ? "Unknown Artist"
                                          : widget
                                              .songModel[currentindex].artist
                                              .toString(),
                                      overflow: TextOverflow.fade,
                                      maxLines: 1,
                                      softWrap: false,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.grey.shade700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (Favorite_Database.isFavor(
                                        widget.songModel[currentindex])) {
                                      Favorite_Database.delete(
                                          widget.songModel[currentindex].id);

                                      // ScaffoldMessenger.of(context);

                                    } else {
                                      Favorite_Database.add(
                                          widget.songModel[currentindex]);
                                      // ScaffoldMessenger.of(context);

                                    }
                                  });

                                  Favorite_Database.favoritesongs
                                      .notifyListeners();
                                },
                                icon: Favorite_Database.isFavor(
                                        widget.songModel[currentindex])
                                    ? const Icon(
                                        Icons.favorite_sharp,
                                        color: Colors.red,
                                        size: 30,
                                      )
                                    : const Icon(
                                        Icons.favorite_border_sharp,
                                        color: Colors.white,
                                        size: 30,
                                      ))
                            // IconButton(
                            //     onPressed: () {},
                            //     icon: Icon(
                            //       Icons.favorite,
                            //       color: Colors.red,
                            //     ))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      _position.toString().split('.')[0],
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          shuffle == false
                              ? GetAllSongController.audioPlayer
                                  .setShuffleModeEnabled(true)
                              : GetAllSongController.audioPlayer
                                  .setShuffleModeEnabled(false);
                        });
                      },
                      icon: StreamBuilder<bool>(
                        stream: GetAllSongController
                            .audioPlayer.shuffleModeEnabledStream,
                        builder: (context, snapshot) {
                          shuffle = snapshot.data ?? false;
                          if (shuffle) {
                            return const Icon(
                              Icons.shuffle_on_outlined,
                              color: Colors.amber,
                            );
                          } else {
                            return const Icon(
                              Icons.shuffle_sharp,
                              color: Colors.black,
                            );
                          }
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        GetAllSongController.audioPlayer.loopMode ==
                                LoopMode.one
                            ? GetAllSongController.audioPlayer
                                .setLoopMode(LoopMode.all)
                            : GetAllSongController.audioPlayer
                                .setLoopMode(LoopMode.one);
                      },
                      icon: StreamBuilder<LoopMode>(
                        stream: GetAllSongController.audioPlayer.loopModeStream,
                        builder: (context, snapshot) {
                          // shuffle=snapshot.data ?? false;
                          final loopmode = snapshot.data;
                          if (LoopMode.one == loopmode) {
                            return const Icon(
                              Icons.repeat_on_outlined,
                              color: Colors.amber,
                            );
                          } else {
                            return const Icon(
                              Icons.repeat,
                              color: Colors.black,
                            );
                          }
                        },
                      ),
                    ),
                    Text(_duration.toString().split('.')[0])
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                New_Box(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                        //  LinearPercentIndicator(
                        //   lineHeight: 10,
                        //   percent: Duration(microseconds: 0)
                        //   .inSeconds.toDouble(),

                        //   progressColor: Color.fromARGB(255, 63, 4, 114),
                        //   barRadius: Radius.circular(30),
                        //   backgroundColor: Colors.transparent,
                        // ),
                        Slider(
                      min: const Duration(microseconds: 0).inSeconds.toDouble(),
                      value: _position.inSeconds.toDouble(),
                      max: _duration.inSeconds.toDouble(),
                      onChanged: (value) {
                        setState(() {
                          ChangeToSecond(value.toInt());
                          value = value;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Playercontroler(
                    count: widget.count,
                    firstsong: firstsong,
                    lastsong: lastsong,
                    songModel: widget.songModel[currentindex])
                //
              ],
            ),
          ),
        ));
  }
}
