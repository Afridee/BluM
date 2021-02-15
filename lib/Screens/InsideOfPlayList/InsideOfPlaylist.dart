import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:musicplayer/Models/songModelForPlaylist.dart';
import 'package:musicplayer/Screens/InsideOfPlayList/PlayListSongListTile.dart';


class InsideOfPlayList extends StatefulWidget {

  final Map playList;

  const InsideOfPlayList({Key key,@required this.playList}) : super(key: key);

  @override
  _InsideOfPlayListState createState() => _InsideOfPlayListState();
}

class _InsideOfPlayListState extends State<InsideOfPlayList> {
  @override
  Widget build(BuildContext context) {

    Box<List<dynamic>> PlaylistBox = Hive.box<List<dynamic>>("PlaylistBox");

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Color(0xff192462),
        child: Center(
          child: ValueListenableBuilder(
          valueListenable: PlaylistBox.listenable(),
          builder: (context, Box<List<dynamic>> PlaylistBox, _){
            return ListView.builder(
              itemCount: PlaylistBox.get(widget.playList.keys.first).length,
              itemBuilder: (context, index){
                return PlayListSongListTile(songInfo: SongModelForPLayList.fromJson(PlaylistBox.get(widget.playList.keys.first)[index]));
              },
            );
        }),
        ),
      ),
    );
  }
}

