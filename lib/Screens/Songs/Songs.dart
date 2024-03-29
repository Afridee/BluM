import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musicplayer/Screens/Songs/SongList.dart';

class Songs extends StatefulWidget {
  @override
  _SongsState createState() => _SongsState();
}

class _SongsState extends State<Songs> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Color(0xff192462),
      child: Center(
        child: SongList(),
      ),
    );
  }
}
