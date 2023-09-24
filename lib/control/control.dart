import 'package:just_audio/just_audio.dart';
import 'package:song_m_app/hive_model/model_allsong.dart';

import 'package:on_audio_query/on_audio_query.dart';


class GetAllSongController {
  static AudioPlayer audioPlayer = AudioPlayer();
  static List<SongModel> songscopy = [];
  static List<saveDballsong> songsDBcopy = [];
  static List<SongModel> playingsong = [];
  static int currentIndexes = -1;
  static ConcatenatingAudioSource createSongList(List<SongModel> elements) {
    List<AudioSource> songList = [];
    playingsong = elements;
    for (var element in elements) {
      songList.add(
        AudioSource.uri(
          Uri.parse(element.uri!),
        ),
      );
    }
    return ConcatenatingAudioSource(children: songList);
  }
}
 