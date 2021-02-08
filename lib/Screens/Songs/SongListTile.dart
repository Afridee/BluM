import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

class SongListTile extends StatelessWidget {

  final SongInfo songInfo;

  const SongListTile({Key key, this.songInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
    );
  }
}
