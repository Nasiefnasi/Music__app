// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:song_m_app/functions/playlistdatabase.dart';
import 'package:song_m_app/hive/model.dart';
import 'package:song_m_app/playlist_page.dart/New_list_.dart';
import 'package:song_m_app/search/search_page.dart';
import 'package:song_m_app/setteing/setting.dart';



class All_songs extends StatefulWidget {
  @override
  State<All_songs> createState() => _All_songsState();
}
final GlobalKey<FormState> formkey =GlobalKey<FormState>();
final playlistnamecontroller = TextEditingController();

class _All_songsState extends State<All_songs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const setting(),
     
      backgroundColor: const Color.fromARGB(114, 41, 2, 56),
      body: Center(
        child: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/main_bg.jpg'), fit: BoxFit.cover),
          ),
          child: SafeArea(
            child: Stack(children: [
              Column(
                children: [
                   Padding(
                     padding: const EdgeInsets.all(10.0),
                     child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Wrap(
                              alignment: WrapAlignment.center,
                              children: [
                                // IconButton(
                                //     onPressed: () {
                                //      Navigator.pop(context);
                                //     },
                                //     icon: Icon(Icons.arrow_back)),
                                // Image.asset(
                                //   'assets/logo blcak.png',
                                //   width: 50,
                                // ),
          
                                Image.asset(
                                  'assets/2222m_app.png',
                                  width: 100,
                                )
                              ],
                            ),
                          ),
                          Builder(builder: (context) {
                            return IconButton(
                                onPressed: () {
                                  Scaffold.of(context).openDrawer();
                                },
                                icon: Icon(
                                  Icons.settings,
                                  color: Colors.white,
                                  size: 30,
                                ));
                          }),
                       ],
                     ),
                   ),
                     GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => search_page(),
                        ));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    bottomLeft: Radius.circular(20)),
                                color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: CircleAvatar(
                                child: Image.asset('assets/logo blcak.png'),
                              ),
                            ),
                          ),
                          Container(
                            width: 260,
                            height: 40,
                            color: Colors.white,
                            child: Center(
                                child: Text('search your favorites songs...')),
                            //const Padding(
                            //   padding: EdgeInsets.only(left: 8.0),
                            //   child:
                            // TextField(
                            //   decoration: InputDecoration(
                            //     contentPadding: EdgeInsets.symmetric(),
                            //     hintText: 'search your favorites songs....',
                            //     border: OutlineInputBorder(
                            //         borderSide: BorderSide.none),
                            //     filled: true,
                            //     fillColor: Color.fromARGB(255, 255, 255, 255),
                            //   ),
                            // ),
                            // ),
                          ),
                          Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20)),
                                color: Colors.white),
                            child: const Icon(Icons.search),
                          ),
                        ],
                      ),
                    ),
                  // SizedBox(height:80,),
                  
          
          
          
               
                  Text(
                          'Play list',
                          style: GoogleFonts.share(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Color.fromARGB(255, 139, 136, 136)),
                        ),
                   
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: ValueListenableBuilder(
                          valueListenable:
                              Hive.box<Playermodel>('playlistDb').listenable(),
                          builder: (BuildContext context,
                              Box<Playermodel> musiclist, Widget? child) {
                            if (musiclist.isEmpty) {
                              return const Padding(
                                padding: EdgeInsets.only(top: 300, left: 120),
                                child: Text(
                                  'Add playlist',
                                  style: TextStyle(
                                      color: Colors.white70, fontSize: 25),
                                ),
                              );
                            } else {
                              return ListView.builder(
                                itemCount: musiclist.length,
                                itemBuilder: (context, index) {
                                  final data = musiclist.values.toList()[index];
                                  return Slidable(
                                    endActionPane: ActionPane(
                                      motion: const ScrollMotion(),
                                      children: [
                                        SlidableAction(
                                          spacing: 0,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(100)),
                                          onPressed: (context) {
                                            DeletePlaylist(
                                                context, musiclist, index);
                                          },
                                          icon: Icons.delete_sweep,
                                          foregroundColor: Colors.white,
                                          backgroundColor: Colors.transparent,
                                        ),
                                        SlidableAction(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(100)),
                                          onPressed: (context) {
                                            EditPlaylistName(
                                                context, data, index);
                                          },
                                          icon: Icons.edit,
                                          foregroundColor: Colors.white,
                                          backgroundColor: Colors.transparent,
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            
                                            color: Color.fromARGB(255, 71, 1, 111),
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            border: Border.all(
                                                color: Color.fromARGB(255, 255, 255, 255))),
                                        child: ListTile(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    Playlisttoaddsong(
                                                        sindex: index,
                                                        playlist: data),
                                              ),
                                            );
                                          },
                                          leading: const Icon(
                                            Icons.library_music_outlined,
                                            color: Colors.amber,
                                          ),
                                          title: Text(
                                            data.name,
                                            textAlign: TextAlign.left,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                            ),
                                          ),
                                          trailing: IconButton(
                                            tooltip: 'Drag Left',
                                            icon: const Icon(
                                              Icons.arrow_circle_left_rounded,
                                              color: Colors.amber,
                                            ),
                                            onPressed: () {},
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  )
          
                ],
              ),
            ]),
          ),
        ),
      ),
      floatingActionButton:FloatingActionButton(backgroundColor: Colors.white,
          onPressed: () {},
          child: IconButton(
              onPressed: () {
                 newplaylist(context, _formKey);
              },
              icon: const Icon(
                Icons.add,
                color: Colors.black,
              )), )

    );
    
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

TextEditingController nameController = TextEditingController();

Future<dynamic> EditPlaylistName(
    BuildContext context, Playermodel data, int index) {
  nameController = TextEditingController(text: data.name);
  return showDialog(
    context: context,
    builder: (ctx) => SimpleDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      backgroundColor: Color.fromARGB(139, 52, 6, 105),
      children: [
        SimpleDialogOption(
          child: Text(
            "Edit Playlist '${data.name}'",
            style: const TextStyle(
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
            key: _formKey,
            child: TextFormField(
              textAlign: TextAlign.center,
              controller: nameController,
              maxLength: 15,
              decoration: InputDecoration(
                  counterStyle: const TextStyle(
                    color: Colors.white,
                  ),
                  fillColor: Colors.white.withOpacity(0.7),
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10)),
                  contentPadding: const EdgeInsets.only(left: 15, top: 5)),
              style: const TextStyle(
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
                Navigator.pop(ctx);
                nameController.clear();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                    color: Colors.purpleAccent,
                    fontSize: 13,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final name = nameController.text.trim();
                  if (name.isEmpty) {
                    return;
                  } else {
                    final playlistName = Playermodel(name: name, songid: []);
                    PlaylistDb.editList(index, playlistName);
                  }
                  nameController.clear();
                  Navigator.pop(ctx);
                }
              },
              child: const Text(
                'Update',
                style: TextStyle(
                    color: Colors.purpleAccent,
                    fontSize: 13,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Future<dynamic> DeletePlaylist(
    BuildContext context, Box<Playermodel> musicList, int index) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog( 
        shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(15))
),
        backgroundColor: Color.fromARGB(255, 74, 6, 151),
        title: const Text(
          'Delete Playlist',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        content: const Text('Are you sure you want to delete this playlist?',
            style: TextStyle(
              color: Colors.white,
            )),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No',
                style: TextStyle(
                  color: Colors.amber,
                )),
          ),
          TextButton(
            onPressed: () {
              musicList.deleteAt(index);
              Navigator.pop(context);
              const snackBar = SnackBar(
                backgroundColor: Colors.black,
                content: SimpleDialog(
                  children: 
                    [Center(
                      child: Text(
                        'Playlist is deleted',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                duration: Duration(milliseconds: 350),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            child: const Text('Yes',
                style: TextStyle(
                  color: Colors.amber,
                )),
          ),
        ],
      );
    },
  );
}

Future newplaylist(BuildContext context, _formKey) {
  return showDialog(
    context: context,
    builder: (ctx) => SimpleDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      backgroundColor: Colors.amber,
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
                  counterStyle: TextStyle(
                    color: Colors.white,
                  ),
                  fillColor: Colors.white.withOpacity(0.7),
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10)),
                  contentPadding: const EdgeInsets.only(left: 15, top: 5)),
              style: const TextStyle(
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
                nameController.clear();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
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

Future<void> saveButtonPressed(context) async {
  final name = nameController.text.trim();
  final music = Playermodel(name: name, songid: []);
  final datas = PlaylistDb.playlistDb.values.map((e) => e.name.trim()).toList();
  if (name.isEmpty) {
    return;
  } else if (datas.contains(music.name)) {
    const snackbar = SnackBar(
        duration: Duration(milliseconds: 750),
        backgroundColor: Color.fromARGB(0, 0, 0, 0),
        content: SimpleDialog(
          children: 
            [Text(
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
          children: 
            [Center(
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