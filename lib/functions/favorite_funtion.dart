// ignore_for_file: camel_case_types

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

import 'package:on_audio_query/on_audio_query.dart';


class Favorite_Database {
  static bool isInitialized = false;  
  static final musicDB = Hive.box<int>('FavoriteDB');

  static ValueNotifier<List<SongModel>> favoritesongs = ValueNotifier([]);

  static isintialized(List<SongModel> songs) {
    favoritesongs.value.clear();
    for (SongModel song in songs) {
      if (isFavor(song)) {
        favoritesongs.value.add(song);
      }
    }
    isInitialized = true;
  }
  

  static   isFavor(SongModel song) {
    if (musicDB.values.contains(song.id)) {
      return true;
    }
    return false;
  }

  static add(SongModel song) async {
    musicDB.add(song.id);
    favoritesongs.value.add(song);
    Favorite_Database.favoritesongs.notifyListeners();
  }

  static delete(int id) async {
    int deletekey = 0;
    if (!musicDB.values.contains(id)) {
      return;
    }
    final Map<dynamic, int> favorMap = musicDB.toMap();
    favorMap.forEach((key, value) {
      if (value == id) {
        deletekey = key;
      }
    });
    musicDB.delete(deletekey);
    favoritesongs.value.removeWhere((song) => song.id == id);
  }
}
