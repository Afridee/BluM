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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        onPressed: (){

        },
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Icon(Icons.add, color: Colors.white, size: 40,),
          decoration: BoxDecoration(
            color: Color(0xff6F2CFF),
            borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Color(0xff6F2CFF).withOpacity(0.3),
                  spreadRadius: 3,
                  blurRadius: 8,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ]
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
          color: Color(0xff1f2128),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(55)),
                  color: Colors.white,
                ),
                height: MediaQuery.of(context).size.height-200,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(55)),
                  color: Colors.white,
                ),
                height: MediaQuery.of(context).size.height-200,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: MediaQuery.of(context).size.height-250,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
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
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40.0,left: 20,right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    color: Color(0xff6F2CFF),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.more_horiz),
                    color: Color(0xff6F2CFF),
                    onPressed: () {},
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

