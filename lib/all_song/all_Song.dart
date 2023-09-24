
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:song_m_app/all_song/all_musiclisttile.dart';
import 'package:song_m_app/control/control.dart';
import 'package:song_m_app/functions/allsong_db_funtion.dart';
import 'package:song_m_app/functions/favorite_funtion.dart';
import 'package:song_m_app/hive_model/model_allsong.dart';



List<SongModel> startsong = [];

// ignore: camel_case_types
class All_songlist extends StatefulWidget {
  const All_songlist({super.key});

  @override
  State<All_songlist> createState() => _RomanticardState();
}

class _RomanticardState extends State<All_songlist> {
  @override
  void initState() {
    super.initState();
    _Permissionr();
  }

  // playsongs(String uri) async {
  //   try {
  //     await GetAllSongController.audioPlayer
  //         .setAudioSource(AudioSource.uri(Uri.parse(uri)));

  //     await GetAllSongController.audioPlayer.play();
  //   } on Exception {
  //     // log("error parse");
  //   }
  // }

  // ignore: non_constant_identifier_names
  _Permissionr()  {
    // bool status = await _audioQuery.permissionsStatus();
    // if (!status) {
    //   await _audioQuery.permissionsRequest();
    // }
    setState(() {
      Permission.storage.request();
    });
  }

  final _audioQuery = OnAudioQuery();
  final AudioPlayer audiooPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
    
      width: double.infinity,
      child: ListView(
        children: [
          FutureBuilder<List<SongModel>>(
            future: _audioQuery.querySongs(
              sortType: null,
              orderType: OrderType.ASC_OR_SMALLER,
              uriType: UriType.INTERNAL,
              ignoreCase: true,
            ),
            builder: (context, item) {
              if (item.data == null) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: Colors.amber,
                )
                );
              }
              if (item.data!.isEmpty) {
                return const Center(
                  child: Text(
                    'No data',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              } else {
                List<SongModel> songs = item.data!;
                final allsongDb = Hive.box<saveDballsong > ('songs');
                allsongDb.clear();
                // ignore: avoid_function_literals_in_foreach_calls
                songs.forEach(
                  (element) {
                    var value = saveDballsong(
                        id: element.id,
                        data: element.data,
                        uri: element.uri!,
                        displayName: element.displayName,
                        displayNameWOExt: element.displayNameWOExt,
                        artist: element.artist!,
                        artistId: element.artistId!);
                    songModelFunction.addAllsongs(value);
                  },
                );

                songModelFunction.getAllsings();
              }
              startsong = item.data!;
              Favorite_Database.isintialized(startsong);
              return Allmusiclisttile(
                songmodel: resulted,
              );
            },
          ),
        ],
      ),
    );
  }
}
