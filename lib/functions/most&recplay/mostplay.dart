// ignore_for_file: unused_local_variable

import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:song_m_app/functions/allsong_db_funtion.dart';
import 'package:song_m_app/hive_model/model_allsong.dart';

class Getmostlyplayed {
  static ValueNotifier<List<saveDballsong>> mostiyNotifer = ValueNotifier([]);
  static List<dynamic> mostlyplayed = [];
  static Future<void> addMostlyplayed(item) async {
    final mostplyDB = await Hive.openBox('mostsongNotifier');
    mostiyNotifer.notifyListeners();
    await mostplyDB.add(item);
    getmostlysongs();
  }

  static Future<void> getmostlysongs() async {
    final mostplayDB = await Hive.openBox('mostsongNotifier');
    final mostlyplayed = await mostplayDB.values.toList();
    mostiyNotifer.notifyListeners();
    displayworkinmostlySong();
  }

  static Future<void> displayworkinmostlySong() async {
    final mostplyDB = await Hive.openBox('mostsongNotifier');
    final mostlysongitems = mostplyDB.values.toList();
    final song = mostplyDB.values.toList();
    mostiyNotifer.value.clear();
    mostlyplayed.clear();

    var temp = 0;
    for (int i = 0; i < mostlysongitems.length; i++) {
      for (int j = 0; j < song.length; j++) {
        if (mostlysongitems[i] == song[j]) {
          temp++;
        }
      }

      if (temp >= 3) {
        for (int u = 0; u < resulted.length; u++) {
          if (mostlysongitems[i] == resulted[u].id) {
            mostiyNotifer.value.add(resulted[u]);
            mostlyplayed.add(resulted[u]);
          }
        }
        temp = 0;
      }
    }
  }
}
