import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:song_m_app/control/control.dart';

class mianscreenNotifer extends ChangeNotifier {
  int _pageIndex = 0;
  int get pageIndex => _pageIndex;
  set pageIndex(int newindex) {
    _pageIndex = newindex;
    notifyListeners();
  }

  // @override
  // void initState() {
  //   super.initState();
  //   _Permissionr();
  // }

  playsongs(String uri) async {
    try {
      await GetAllSongController.audioPlayer
          .setAudioSource(AudioSource.uri(Uri.parse(uri)));

      await GetAllSongController.audioPlayer.play();
    } on Exception {
      log("error parse*************************************************************************************************************************");
    }
  }

  // ignore: non_constant_identifier_names
  _Permissionr() async {
    bool status = await _audioQuery.permissionsStatus();
    if (!status) {
      await _audioQuery.permissionsRequest();
    }

    Permission.storage.request();
  }

  final _audioQuery = OnAudioQuery();
  final AudioPlayer audiooPlayer = AudioPlayer();
}
