import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:song_m_app/all_song/all_Song.dart';
import 'package:song_m_app/box_design/Now_Play_demo.dart';
import 'package:song_m_app/control/control.dart';
import 'package:song_m_app/functions/favorite_funtion.dart';
import 'package:song_m_app/functions/most&recplay/mostplay.dart';
import 'package:song_m_app/functions/most&recplay/recplay_function.dart';
import 'package:song_m_app/functions/playlistdatabase.dart';
import 'package:song_m_app/hive/model.dart';
import 'package:song_m_app/hive_model/model_allsong.dart';
import 'package:song_m_app/play%20Now%20controler/Now_play.dart';

// ignore: must_be_immutable
class Allmusiclisttile extends StatefulWidget {
  Allmusiclisttile({super.key, required this.songmodel});
  List<saveDballsong> songmodel = [];
  @override
  State<Allmusiclisttile> createState() => _AllmusiclisttileState();
}

class _AllmusiclisttileState extends State<Allmusiclisttile> {
  TextEditingController nameController = TextEditingController();
  List<saveDballsong> songs = [];
  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of< faverateprovider>(context);
    return SizedBox(
      height:500,
      child: ListView.builder(
        shrinkWrap: true,
        itemBuilder: ((context, index) {
          songs.addAll(widget.songmodel);
          return SizedBox(
              
              child: Card(
                elevation: 5,
                margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 12.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                color: const Color.fromARGB(139, 80, 79, 79),
                child: ListTile(
                  onTap: () {
                    Getmostlyplayed.addMostlyplayed(widget.songmodel[index].id);
                    GetRecentlyPlayed.addRecentlyplayed(widget.songmodel[index].id);
                    GetAllSongController.audioPlayer.setAudioSource(
                        GetAllSongController.createSongList(startsong),
                        initialIndex: index);

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) { 
                          return Now_Play(
                            songModel: startsong,
                            count: widget.songmodel.length);
                            
                            }
                      ),
                    );
                   
                  },
                  title: Text(
                    widget.songmodel[index].displayNameWOExt,
                    maxLines: 1,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: QueryArtworkWidget(
                    id: widget.songmodel[index].id,
                    type: ArtworkType.AUDIO,
                    artworkHeight: 60,
                    artworkWidth: 60,
                    nullArtworkWidget: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(50, 255, 255, 255),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: const Icon(
                          Icons.music_note,
                          color: Colors.amber,
                        )),
                    artworkBorder: BorderRadius.circular(10),
                    artworkFit: BoxFit.cover,
                  ),
                  trailing: IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                            backgroundColor:
                                const Color.fromARGB(255, 54, 1, 92),
                            context: context,
                            builder: (context) {
                              return SizedBox(
                                height: 120,
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: const Icon(Icons.playlist_add,
                                          color: Colors.white),
                                      title: const Text(
                                        'Add playlist',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      onTap: () {
                                        showPlaylistdialog(
                                            context, startsong[index]);
                                      },
                                    ),
                                    ValueListenableBuilder(
                                        valueListenable:
                                            Favorite_Database.favoritesongs,
                                        builder: (context,
                                            List<SongModel> data, child) {
                                          return ListTile(
                                            title: Text(
                                              Favorite_Database.isFavor(
                                                      startsong[index])
                                                  ? 'Remove Favorites'
                                                  : 'Add Favorites',
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            onTap: () {
                                              if (Favorite_Database.isFavor(
                                                  startsong[index])) {
                                                Favorite_Database.delete(
                                                    widget
                                                        .songmodel[index].id);
                                                const remove = SnackBar(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  content: SimpleDialog(
                                                    backgroundColor:
                                                        Colors.amber,
                                                    children: [
                                                      Center(
                                                        child: Text(
                                                          'Song Removed ',
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: Colors
                                                                  .black),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  duration:
                                                      Duration(seconds: 3),
                                                );
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(remove);
                                              } else {
                                                Favorite_Database.add(
                                                    startsong[index]);
                                                const add = SnackBar(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  content: SimpleDialog(
                                                      backgroundColor:
                                                          Colors.amber,
                                                      children: [
                                                        Center(
                                                          child: Text(
                                                            'Song Added ',
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ),
                                                      ]),
                                                  duration:
                                                      Duration(seconds: 1),
                                                );
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(add);
                                              }
                                              Favorite_Database.favoritesongs
                                                  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                                                  .notifyListeners();

                                              Navigator.pop(context);
                                            },
                                            leading: Favorite_Database
                                                    .isFavor(startsong[index])
                                                ? const Icon(Icons.favorite,
                                                    color: Colors.red)
                                                : const Icon(
                                                    Icons
                                                        .favorite_border_outlined,
                                                    color: Color.fromARGB(
                                                        255, 214, 123, 116)),
                                          );
                                        }),
                                  ],
                                ),
                              );
                            });
                      },
                      icon: const Icon(
                        Icons.more_vert_sharp,
                        size: 25,
                        color: Colors.amber,
                      )),
                ),
              ));
        }),
        itemCount: widget.songmodel.length,
      ),
    );
  }

  final GlobalKey<FormState> __formkey = GlobalKey<FormState>();

  showPlaylistdialog(BuildContext context, SongModel songModel) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            backgroundColor: const Color.fromARGB(255, 52, 6, 105),
            title: const Text(
              "choose your playlist",
              style: TextStyle(color: Colors.white, fontFamily: 'poppins'),
            ),
            content: SizedBox(
              height: 200,
              width: double.maxFinite,
              child: ValueListenableBuilder(
                  valueListenable:
                      Hive.box<Playermodel>('playlistDb').listenable(),
                  builder: (BuildContext context, Box<Playermodel> musicList,
                      Widget? child) {
                    return Hive.box<Playermodel>('playlistDb').isEmpty
                        ? Center(
                            child: Stack(
                              children: const [
                                Positioned(
                                  right: 30,
                                  left: 30,
                                  bottom: 50,
                                  child: Center(
                                    child: Text('No Playlist found!',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        )),
                                  ),
                                )
                              ],
                            ),
                          )
                        : ListView.builder(
                            itemCount: musicList.length,
                            itemBuilder: (ctx, index) {
                              final data = musicList.values.toList()[index];

                              return Card(
                                color: const Color.fromARGB(255, 51, 2, 114),
                                shadowColor: Colors.purpleAccent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side:
                                        const BorderSide(color: Colors.white)),
                                child: ListTile(
                                  title: Text(
                                    data.name,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'poppins'),
                                  ),
                                  trailing: const Icon(
                                    Icons.playlist_add,
                                    color: Colors.white,
                                  ),
                                  onTap: () {
                                    songaddtoplaylist(
                                        songModel, data, data.name, ctx);
                                    Navigator.pop(ctx);
                                  },
                                ),
                              );
                            },
                          );
                  }),
            ),
            // actions: [
            //   TextButton(
            //       onPressed: () {
            //         newplaylistt(context, formkey);
            //       },
            //       child: const Text(
            //         'New Playlist',
            //         style:
            //             TextStyle(color: Colors.white, fontFamily: 'poppins'),
            //       )),
            //   TextButton(
            //       onPressed: () {
            //         Navigator.pop(context);
            //       },
            //       child: const Text(
            //         'cancel',
            //         style:
            //             TextStyle(color: Colors.white, fontFamily: 'poppins'),
            //       ))
            // ],
            actions: [
              TextButton(
                  onPressed: () {
                    // newplaylist(context, formkey);
                    newplaylistt(context, __formkey);
                  },
                  child: const Text(
                    'New Playlist',
                    style:
                        TextStyle(color: Colors.white, fontFamily: 'poppins'),
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'cancel',
                    style:
                        TextStyle(color: Colors.white, fontFamily: 'poppins'),
                  ))
            ],
          );
        });
  }

  void songaddtoplaylist(
      SongModel data, datas, String name, BuildContext context) {
    if (!datas.isvalule(data.id)) {
      datas.add(data.id);
      final snake1 = SnackBar(
          duration: const Duration(seconds: 1),
          backgroundColor: const Color.fromARGB(0, 0, 0, 0),
          content: SimpleDialog(
            children: [
              Center(
                  child: Text(
                'Playlist Add To $name',
                style: const TextStyle(color: Colors.black),
              )),
            ],
          ));
      ScaffoldMessenger.of(context).showSnackBar(snake1);
    } else {
      final snake2 = SnackBar(
          duration: const Duration(seconds: 1),
          backgroundColor: const Color.fromARGB(0, 0, 0, 0),
          content: SimpleDialog(
              children: [Center(child: Text('Song Alredy Added In $name'))]));
      ScaffoldMessenger.of(context).showSnackBar(snake2);
    }
  }

  Future newplaylistt(BuildContext context, _formKey) {
    return showDialog(
      context: context,
      builder: (ctx) => New_Box(
        child: SimpleDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          backgroundColor: Colors.white,
          children: [
            const SimpleDialogOption(
              child: Text(
                'New to Playlist',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            SimpleDialogOption(
              child: Form(
                key: _formKey,
                child: TextFormField(
                  textAlign: TextAlign.center,
                  controller: nameController,
                  maxLength: 15,
                  decoration: InputDecoration(
                      counterStyle: const TextStyle(
                        color: Colors.black,
                      ),
                      fillColor: Colors.black.withOpacity(0.7),
                      filled: true,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10)),
                      contentPadding: const EdgeInsets.only(left: 15, top: 5)),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter your playlist name";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.of(context).pop();
                    nameController.clear();
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                        color: Color.fromARGB(255, 63, 63, 63),
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SimpleDialogOption(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      saveButtonPressed(context);
                    }
                  },
                  child: const Text(
                    'Create',
                    style: TextStyle(
                        color: Color.fromARGB(255, 63, 63, 63),
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> saveButtonPressed(context) async {
    final name = nameController.text.trim();
    final music = Playermodel(name: name, songid: []);
    final datas =
        PlaylistDb.playlistDb.values.map((e) => e.name.trim()).toList();
    if (name.isEmpty) {
      return;
    } else if (datas.contains(music.name)) {
      const snackbar = SnackBar(
          duration: Duration(milliseconds: 750),
          backgroundColor: Color.fromARGB(0, 0, 0, 0),
          content: SimpleDialog(
            children: [
              Text(
                'Already exist',
                style: TextStyle(color: Colors.redAccent),
              ),
            ],
          ));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      Navigator.of(context).pop();
    } else {
      PlaylistDb.addPlaylist(music);
      const snackbar4 = SnackBar(
          duration: Duration(milliseconds: 750),
          backgroundColor: Color.fromARGB(0, 0, 0, 0),
          content: SimpleDialog(
            children: [
              Center(
                child: Text(
                  'playlist successfully',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ));
      ScaffoldMessenger.of(context).showSnackBar(snackbar4);
      Navigator.pop(context);
      nameController.clear();
    }
  }
}
