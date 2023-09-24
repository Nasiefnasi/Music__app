import 'package:flutter/material.dart';

import 'package:on_audio_query/on_audio_query.dart';
import 'package:song_m_app/box_design/Now_Play_demo.dart';
import 'package:song_m_app/control/control.dart';

class Playercontroler extends StatefulWidget {
  const Playercontroler(
      {super.key,
      required this.count,
      required this.firstsong,
      required this.lastsong,
      required this.songModel});
  final int count;
  final bool firstsong;
  final bool lastsong;
  final SongModel songModel;

  @override
  State<Playercontroler> createState() => _PlayercontrolerState();
}

class _PlayercontrolerState extends State<Playercontroler> {
  bool isplaying = true;
  bool isrepeat = false;
  bool shuffle = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        widget.firstsong
            ? Expanded(
                child: New_Box(
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          GetAllSongController.currentIndexes--;
                          if (GetAllSongController.currentIndexes < 0) {
                            GetAllSongController.currentIndexes =
                                widget.songModel.size;
                          }
                        });
                      },
                      icon: const Icon(
                        Icons.skip_previous,
                        size: 30,
                        color: Colors.black,
                      )),
                ),
              )
            : Expanded(
                child: New_Box(
                  child: IconButton(
                      onPressed: () {
                        if (GetAllSongController.audioPlayer.hasPrevious) {
                          GetAllSongController.audioPlayer.seekToPrevious();
                        }
                      },
                      icon: const Icon(
                        Icons.skip_previous,
                        size: 30,
                        color: Colors.black,
                      )),
                ),
              ),
     
        Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: New_Box(
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
                      color: Colors.black,
                      size: 30,
                    )),
              ),
            )),
        
        widget.lastsong
            ? const Expanded(
                child: New_Box(
                    child: IconButton(
                        onPressed: null,
                        icon: Icon(
                          Icons.skip_next,
                          size: 30,
                          color: Colors.black,
                        ))))
            : Expanded(
                child: New_Box(
                  child: IconButton(
                      onPressed: () {
                        if (GetAllSongController.audioPlayer.hasNext) {
                          GetAllSongController.audioPlayer.seekToNext();
                        }
                      },
                      icon: const Icon(
                        Icons.skip_next,
                        color: Colors.black,
                        size: 30,
                      )),
                ),
              )
      ],
    );
  }
}
