import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'Screens/Home.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Directory Document = await getApplicationDocumentsDirectory();
  Hive.init(Document.path);
  await Hive.openBox<String>('AlbumArtworkBox');
  await Hive.openBox<String>('ArtistArtBox');
  await Hive.openBox<List<dynamic>>('PlaylistBox');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

