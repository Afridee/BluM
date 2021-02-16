import 'dart:ui';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_slider/music_slider.dart';

import '../../constants.dart';

class AudioPlayer extends StatefulWidget {

  @override
  _AudioPlayerState createState() => _AudioPlayerState();
}

class _AudioPlayerState extends State<AudioPlayer> {


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Container(
        color: Color(0xff192462),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back_ios),
                          color: Colors.white,
                          onPressed: (){

                          },
                        ),
                        Text('SongName',
                        style: song_title_style_2,
                        ),
                        IconButton(
                          icon: Icon(Icons.more_horiz),
                          color: Colors.white,
                          onPressed: (){
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.only(topRight: Radius.circular(45), topLeft:  Radius.circular(45)),
                 color: Colors.white
               ),
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 70.0),
                        child: Container(
                          height: 220,
                          width: 220,
                          child: ClipOval(
                            child: CachedNetworkImage(
                                imageUrl: 'hhh',
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) => Image.asset(
                                  'assets/images/image_1.jfif',
                                  fit: BoxFit.cover,
                                )
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: Text('Girls like you', style: song_title_style_3, textAlign: TextAlign.center,),
                      ),
                      Text('Levi Ackerman', style: Artist_title_style_1, textAlign: TextAlign.center,),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              '00:00:45',
                              style: seek_style,
                            ),
                            MusicSlider(
                              width: 200,
                              emptyColors: [Colors.grey.withOpacity(0.5)],
                              fillColors: [
                                Colors.blue,
                              ],
                              controller:  MusicSliderController(initialValue: 0.5),
                              animateWaveByTime: true,
                              height: 40,
                              division: 50,
                              wave: (x, t, a) => a * cos(x * 0.5) * sin(x * 0.3),
                            ),
                            Text(
                              '00:00:45',
                              style: seek_style,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              icon: Icon(Icons.shuffle),
                              onPressed: (){

                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.skip_previous),
                              onPressed: (){

                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.play_circle_filled),
                              iconSize: 70,
                              onPressed: (){

                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.skip_next),
                              onPressed: (){

                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.repeat),
                              onPressed: (){

                              },
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
