// ignore_for_file: depend_on_referenced_packages, unused_local_variable

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:song_m_app/hive/model.dart';


class PlaylistDb {
  static ValueNotifier<List<Playermodel>> playlistNotifiier = ValueNotifier([]);
  static final playlistDb = Hive.box<Playermodel>('playlistDb');

  static Future<void> addPlaylist(Playermodel value) async {
    final playlistDb = Hive.box<Playermodel>('playlistDb');
    await playlistDb.add(value);
    playlistNotifiier.value.add(value);
  }

  static Future<void> getAllPlaylist() async {
    final playlistDb = Hive.box<Playermodel>('playlistDb');
    playlistNotifiier.value.clear();
    playlistNotifiier.notifyListeners();
  }

  static Future<void> deletePlaylist(int index) async {
    final playlistDb = Hive.box<Playermodel>('playlistDb');
    await playlistDb.deleteAt(index);
    getAllPlaylist();
  }

  static Future<void> editList(int index, Playermodel value) async {
    final playlistDb = Hive.box<Playermodel>('playlistDb');
    await playlistDb.putAt(index, value);
    getAllPlaylist();
  }
}
