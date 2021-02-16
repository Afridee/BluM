import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const TextStyle song_title_style_1 = TextStyle(
    fontFamily: 'Nunito',
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 13
);

const TextStyle song_title_style_2 = TextStyle(
    fontFamily: 'Nunito',
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 25
);

const TextStyle song_title_style_3 = TextStyle(
    fontFamily: 'Nunito',
    color: Color(0xff303641),
    fontWeight: FontWeight.bold,
    fontSize: 30
);

const TextStyle Artist_title_style_1 = TextStyle(
    color: Colors.grey,
    fontWeight: FontWeight.bold,
    fontSize: 20
);

const TextStyle seek_style = TextStyle(
        fontSize: 12,
        color: Colors.black,
        fontWeight: FontWeight.bold
);

const TextStyle duration_style_1 = TextStyle(
    fontFamily: 'Nunito',
    color: Colors.white,
    fontSize: 10
);

/// tablist, shoud not be more than 5:
List<Widget> Tabs = [
  Tab(
    child: Container(
      child: Text(
        'Songs',
        style: TextStyle(color: Colors.white, fontSize: 18.0),
      ),
    ),
  ),
  Tab(
    child: Container(
      child: Text(
        'Playlists',
        style: TextStyle(color: Colors.white, fontSize: 18.0),
      ),
    ),
  ),
  Tab(
    child: Container(
      child: Text(
        'Artists',
        style: TextStyle(color: Colors.white, fontSize: 18.0),
      ),
    ),
  ),
  Tab(
    child: Container(
      child: Text(
        'Albums',
        style: TextStyle(color: Colors.white, fontSize: 18.0),
      ),
    ),
  ),
  Tab(
    child: Container(
      child: Text(
        'Genres',
        style: TextStyle(color: Colors.white, fontSize: 18.0),
      ),
    ),
  ),
];