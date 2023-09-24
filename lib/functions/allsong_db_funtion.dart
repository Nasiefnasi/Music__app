// ignore_for_file: camel_case_types

import 'package:hive/hive.dart';

import 'package:song_m_app/hive_model/model_allsong.dart';

List<saveDballsong> resulted = [];

class songModelFunction {
  final allsongDb = Hive.box<saveDballsong>('songs');
  static addAllsongs(saveDballsong valu) {
     final allsongDb = Hive.box<saveDballsong>('songs');
      allsongDb.add(valu);
  }

  static getAllsings() {
    final allsongDb = Hive.box<saveDballsong>('songs');
    resulted = allsongDb.values.toList();
  }
}
