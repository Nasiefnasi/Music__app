
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:song_m_app/design/splea.dart';
import 'package:song_m_app/hive/model.dart';
import 'package:song_m_app/hive_model/model_allsong.dart';
import 'package:song_m_app/provide/provides.dart';
import 'package:song_m_app/provider/provider.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
      if (!Hive.isAdapterRegistered(PlayermodelAdapter().typeId)) {
    Hive.registerAdapter(PlayermodelAdapter());}
    if (!Hive.isAdapterRegistered(saveDballsongAdapter().typeId)) {
    Hive.registerAdapter(saveDballsongAdapter());}
     await Hive.initFlutter();
    await Hive.openBox<saveDballsong >('songs');
    await Hive.openBox<int>('FavoriteDB');
    await Hive.openBox<Playermodel >('playlistDb');
 runApp(MultiProvider(providers: [
  ChangeNotifierProvider(create: (context) => mianscreenNotifer(),),
   ChangeNotifierProvider(
          create: (context) => Songmodelprovider(),)], child: const MyApp()));
 
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.transparent,
     
      home: splash(),
    );
  }
}

