import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:on_audio_query/on_audio_query.dart';
import 'package:song_m_app/control/control.dart';
import 'package:song_m_app/hive/model.dart';
import 'package:song_m_app/play%20Now%20controler/Now_play.dart';
import 'package:song_m_app/playlist_page.dart/playlistsongdisplayscreen.dart';

class Playlisttoaddsong extends StatefulWidget {
  const Playlisttoaddsong(
      {super.key, required this.sindex, required this.playlist});
  final int sindex;
  final Playermodel playlist;

  @override
  State<Playlisttoaddsong> createState() => _PlaylisttoaddsongState();
}

class _PlaylisttoaddsongState extends State<Playlisttoaddsong> {
  @override
  Widget build(BuildContext context) {
    late List<SongModel> songplaylist;
    return Scaffold(
      backgroundColor: Color.fromARGB(39, 49, 27, 146),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(163, 54, 1, 51),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white60,
            )),
        title: Text(
          widget.playlist.name,
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/main_bg.jpg'), fit: BoxFit.cover),
          ),
          child: Column(children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(12),
              child: ValueListenableBuilder(
                valueListenable:
                    Hive.box<Playermodel>('playlistDb').listenable(),
                builder: (context, Box<Playermodel> song, Widget? child) {
                  songplaylist =
                      listplaylist(song.values.toList()[widget.sindex].songid);
                  return songplaylist.isEmpty
                      ? const Center(
                          child: Text(
                            'Add Songs',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white60),
                          ),
                        )
                      : ListView.builder(
                          itemCount: songplaylist.length,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              color: Color.fromARGB(183, 60, 59, 59),
                              child: ListTile(
                                leading: QueryArtworkWidget(
                                  type: ArtworkType.AUDIO,
                                  id: songplaylist[index].id,
                                  artworkHeight: 60,
                                  artworkWidth: 60,
                                  nullArtworkWidget: Container(
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                          color: Colors.white10,
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      child: const Icon(
                                        Icons.music_note,
                                        color: Colors.amber,
                                      )),
                                  artworkBorder: BorderRadius.circular(10),
                                  artworkFit: BoxFit.cover,
                                ),
                                title: Text(songplaylist[index].title,
                                    maxLines: 1,
                                    style:
                                        const TextStyle(color: Colors.white70)),
                                subtitle: Text(
                                  songplaylist[index].artist!,
                                  style: const TextStyle(color: Colors.white70),
                                  maxLines: 1,
                                ),
                                trailing: IconButton(
                                    onPressed: () {
                                      widget.playlist
                                          .deletedata(songplaylist[index].id);
                                      const removesongplaylistsnake = SnackBar(
                                          backgroundColor:
                                              Colors.transparent,
                                          duration: Duration(seconds: 1),
                                          content: SimpleDialog(
                                            children: [
                                              Center(
                                                  child: Text(
                                                      'Music Removed In Playlist')),
                                            ],
                                          ));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                              removesongplaylistsnake);
                                    },
                                    icon: const Icon(Icons.delete_outline,
                                        color: Colors.amber)),
                                onTap: () {
                                  GetAllSongController.audioPlayer
                                      .setAudioSource(
                                          GetAllSongController.createSongList(
                                              songplaylist),
                                          initialIndex: index);
                                  // context
                                  //     .read<Songmodelprovider>()
                                  //     .setid(widget.songmodel[index].id);

                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => Now_Play(
                                          songModel: songplaylist,
                                          count: songplaylist.length)));
                                },
                              ),
                            ),
                          ),
                        );
                },
              ),
            ))
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Playlistsongdisplayscreen(
                        playlist: widget.playlist,
                      )));
        },
        label: const Text(
          'Add Songs',
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  List<SongModel> listplaylist(List<int> data) {
    List<SongModel> playsong = [];
    for (int i = 0; i < GetAllSongController.songscopy.length; i++) {
      for (int j = 0; j < data.length; j++) {
        if (GetAllSongController.songscopy[i].id == data[j]) {
          playsong.add(GetAllSongController.songscopy[i]);
        }
      }
    }

    return playsong;
  }
}
