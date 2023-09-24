import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

import 'package:on_audio_query/on_audio_query.dart';
import 'package:song_m_app/functions/allsong_db_funtion.dart';
import 'package:song_m_app/hive_model/model_allsong.dart';

class GetRecentlyPlayed {
  static ValueNotifier<List<saveDballsong>> recentNotifier = ValueNotifier([]);
  static List<dynamic> recentlyplay = [];

  static Future<void> addRecentlyplayed(item) async {
    final recentplyDB = await Hive.openBox('recentsongNotifier');
    recentNotifier.notifyListeners();
    await recentplyDB.add(item);
    getRecentlysongs();
  }

  static Future<void> getRecentlysongs() async {
    final recentplyDB = await Hive.openBox('recentsongNotifier');
    final recentlyplay = await recentplyDB.values.toList();
    recentNotifier.notifyListeners();

    displayworkingRecentlySong();
  }

  static Future<void> displayworkingRecentlySong() async {
    final recentplyDB = await Hive.openBox('recentsongNotifier');
    final recentsongItems = recentplyDB.values.toSet().toList();
    recentNotifier.value.clear();
    recentlyplay.clear();
    for (int i = 0; i < recentsongItems.length; i++) {
      for (int j = 0; j < resulted.length; j++) {
        if ( resulted[j].id == recentsongItems[i] ) {
 recentNotifier.value.add(resulted[j]);
        recentlyplay.add(resulted[j]);
        }
       
      }
    }
  }
}
