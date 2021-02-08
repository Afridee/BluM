import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicplayer/Controllers/AudioQuerying.dart';
import 'package:musicplayer/Screens/Songs/SongListTile.dart';

class SongList extends StatefulWidget {
  @override
  _SongListState createState() => _SongListState();
}

class _SongListState extends State<SongList> {

  AudioQuerying audioQuerying;

  @override
  void initState() {
    audioQuerying = Get.put(AudioQuerying());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AudioQuerying>(builder: (aq){
          return ListView.builder(
            itemCount: aq.songs.length,
            itemBuilder: (context, index){
              return SongListTile(songInfo : aq.songs[index]);
            },
          );
      }
    );
  }
}
