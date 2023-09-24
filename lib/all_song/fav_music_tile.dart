import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:on_audio_query/on_audio_query.dart';
import 'package:song_m_app/all_song/all_Song.dart';
import 'package:song_m_app/control/control.dart';
import 'package:song_m_app/functions/favorite_funtion.dart';
import 'package:song_m_app/functions/most&recplay/recplay_function.dart';
import 'package:song_m_app/hive/model.dart';
import 'package:song_m_app/play%20Now%20controler/Now_play.dart';
import 'package:song_m_app/playlist_page.dart/plat_list_page.dart';

// ignore: must_be_immutable
class Favtile extends StatefulWidget {
  Favtile({super.key, required this.songmodel});
  List<SongModel> songmodel = [];

  @override
  State<Favtile> createState() => _FavtileState();
}

class _FavtileState extends State<Favtile> {
  List<SongModel> songs = [];
  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of< faverateprovider>(context);
    return SizedBox(
      height: 500,
      child: ListView.builder(
        shrinkWrap: true,
        itemBuilder: ((context, index) {
          songs.addAll(startsong);
          return SizedBox(
              height: 70,
              width: 30,
              child: Card(
                elevation: 5,
                margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 12.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                color: const Color.fromARGB(139, 80, 79, 79),
                child: ListTile(
                  onTap: () {
                    GetRecentlyPlayed.addRecentlyplayed(
                        widget.songmodel[index].id);
                       GetAllSongController.audioPlayer.setAudioSource(
                        GetAllSongController.createSongList(startsong),
                           initialIndex: index);
                    // context
                       //     .read<Songmodelprovider>()
                    //     .setid(widget.songmodel[index].id);

                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Now_Play(
                              songModel: startsong,
                              // count: widget.songmodel.length
                            )));
                    GetAllSongController.audioPlayer.play();
                       },
                  title: Expanded(
                    flex: 3,
                    child: Text(
                      widget.songmodel[index].displayNameWOExt,
                      maxLines: 1,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
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
                            color: Colors.white10,
                               borderRadius: BorderRadius.circular(10.0)),
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
                            backgroundColor: Color.fromARGB(255, 54, 1, 92),
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
                                        builder: (context, List<SongModel> data,
                                            child) {
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
                                                    widget.songmodel[index].id);
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
                                                              color:
                                                                  Colors.black),
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
                                            leading: Favorite_Database.isFavor(
                                                    startsong[index])
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
                      icon: Icon(
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
                                  side: const BorderSide(color: Colors.white)),
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
          actions: [
            TextButton(
                onPressed: () {
                  newplaylist(context, formkey);
                },
                child: const Text(
                  'New Playlist',
                  style: TextStyle(color: Colors.white, fontFamily: 'poppins'),
                )),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'cancel',
                  style: TextStyle(color: Colors.white, fontFamily: 'poppins'),
                ))
          ],
          // actions: [
          //   TextButton(
          //       onPressed: () {
          //         // newplaylist(context, formkey);
          //         newplaylist(context, __formkey);
          //       },
          //       child: const Text(
          //         'New Playlist',
          //         style: TextStyle(color: Colors.white, fontFamily: 'poppins'),
          //       )),
          //   TextButton(
          //       onPressed: () {
          //         Navigator.pop(context);
          //       },
          //       child: const Text(
          //         'cancel',
          //         style: TextStyle(color: Colors.white, fontFamily: 'poppins'),
          //       ))
          // ],
        );
      });
}

void songaddtoplaylist(
    SongModel data, datas, String name, BuildContext context) {
  if (!datas.isvalule(data.id)) {
    datas.add(data.id);
    final snake1 = SnackBar(
        duration: const Duration(seconds: 1),
        backgroundColor: const Color.fromARGB(222, 38, 46, 67),
        content: Center(
            child: Text(
          'Playlist Add To $name',
          style: const TextStyle(color: Colors.white60),
        )));
    ScaffoldMessenger.of(context).showSnackBar(snake1);
  } else {
    final snake2 = SnackBar(
        duration: const Duration(seconds: 1),
        backgroundColor: Colors.red,
        content: Center(child: Text('Song Alredy Added In $name')));
    ScaffoldMessenger.of(context).showSnackBar(snake2);
  }
}

Future newplaylist(BuildContext context, formKey) {
  return showDialog(
    context: context,
    builder: (ctx) => SimpleDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      backgroundColor: const Color.fromARGB(255, 52, 6, 105),
      children: [
        const SimpleDialogOption(
          child: Text(
            'New to Playlist',
            style: TextStyle(
                fontFamily: 'poppins',
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 18,
                fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        SimpleDialogOption(
          child: Form(
            key: formKey,
            child: TextFormField(
              textAlign: TextAlign.center,
              // controller: nameController,
              maxLength: 15,
              decoration: InputDecoration(
                  counterStyle: const TextStyle(
                      color: Colors.white, fontFamily: 'poppins'),
                  fillColor: Colors.white.withOpacity(0.7),
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10)),
                  contentPadding: const EdgeInsets.only(left: 15, top: 5)),
              style: const TextStyle(
                  fontFamily: 'poppins',
                  color: Color.fromARGB(255, 0, 0, 0),
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
                // nameController.clear();---------------------
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                    fontFamily: 'poppins',
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  // saveButtonPressed(context);---------------------------
                }
              },
              child: const Text(
                'Create',
                style: TextStyle(
                    fontFamily: 'poppins',
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
