import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:get/get.dart';
import 'package:musicplayer/Controllers/AudioQuerying.dart';

class SongListTile extends StatelessWidget {

  final SongInfo songInfo;


  const SongListTile({Key key, this.songInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final audioQuerying = Get.put(AudioQuerying());

    return ListTile(
      leading: Container(
        height: 50,
        width: 50,
        child: ClipOval(
          child: Image.asset(
            'assets/images/image_1.jfif',
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(songInfo.title),
      subtitle: Text(audioQuerying.changeMillisecondsToTime(Duration(milliseconds: int.parse(songInfo.duration)))),
    );
  }
}
