import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';
part 'model_allsong.g.dart';



@HiveType(typeId: 2)
class saveDballsong{
  @HiveField(0)
  int id;
  @HiveField(1)
  String data;
  @HiveField(2)
  String uri;
  @HiveField(3)
  String displayName;
  @HiveField(4)
  String displayNameWOExt;
  @HiveField(5)
  String artist;
  @HiveField(6)
  int artistId;

   saveDballsong({
    required this.id,
    required this.data,
    required this.uri,
    required this.displayName,
    required this.displayNameWOExt,
    required this.artist,
    required this.artistId,
  });

}