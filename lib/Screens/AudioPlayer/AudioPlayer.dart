import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wave/config.dart';
import 'package:musicplayer/Controllers/AudioPlayer.dart';
import 'package:wave/wave.dart';
import '../../constants.dart';

class AudioPlayer extends StatelessWidget {
  final audioPlayerController = Get.put(AudioPlayerController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    audioPlayerController.initializeStreams();
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Color(0xff1f2128)),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 220,
              width: 220,
              child: ClipOval(
                child: GetBuilder<AudioPlayerController>(
                  builder: (apc) {
                    return CachedNetworkImage(
                        imageUrl:
                        apc.currentSong.albumArtwork.toString(),
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) =>
                            Image.asset(
                              'assets/images/image_1.jfif',
                              fit: BoxFit.cover,
                            ));
                  },
                ),
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 10,
                sigmaY: 10
              ),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(45),
                        topLeft: Radius.circular(45)),
                    color: Color(0xff1f2128).withOpacity(0.7)),
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0,left: 20,right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: Icon(Icons.arrow_back_ios),
                              color: Colors.white.withOpacity(0.7),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: Icon(Icons.more_horiz),
                              color: Colors.white.withOpacity(0.7),
                              onPressed: () {},
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 50.0),
                        child: Container(
                          height: 250,
                          width: 250,
                          child: ClipOval(
                            child: GetBuilder<AudioPlayerController>(
                              builder: (apc) {
                                return CachedNetworkImage(
                                    imageUrl:
                                    apc.currentSong.albumArtwork.toString(),
                                    fit: BoxFit.cover,
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                          'assets/images/image_1.jfif',
                                          fit: BoxFit.cover,
                                        ));
                              },
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: GetBuilder<AudioPlayerController>(
                          builder: (apc) {
                            return Text(
                              apc.currentSong.title.toString(),
                              style: song_title_style_3,
                              textAlign: TextAlign.center,
                            );
                          },
                        ),
                      ),
                      GetBuilder<AudioPlayerController>(builder: (apc) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            apc.currentSong.artist.toString(),
                            style: Artist_title_style_1,
                            textAlign: TextAlign.center,
                          ),
                        );
                      }),
                      GetBuilder<AudioPlayerController>(builder: (apc) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              activeTrackColor: Color(0xff6F2CFF),
                              inactiveTrackColor: Color(0xff6F2CFF).withOpacity(0.3),
                              trackShape: RectangularSliderTrackShape(),
                              trackHeight: 6.0,
                              thumbColor: Color(0xff6F2CFF),
                              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 7.0),
                              overlayColor: Color(0xff6F2CFF).withAlpha(32),
                              overlayShape: RoundSliderOverlayShape(overlayRadius: 20.0),
                            ),
                            child: Slider(
                              min: 0,
                              max: 100,
                              value: apc.dragPercentage,
                              onChanged: (value) {
                                audioPlayerController.changeDragPercantage(value);
                              },
                            ),
                          ),
                        );
                      }),
                      Padding(
                        padding: EdgeInsets.only(left: 25, right: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GetBuilder<AudioPlayerController>(builder: (apc) {
                              return Text(
                                apc.currentSongPosition.toString(),
                                style: seek_style,
                              );
                            }),
                            GetBuilder<AudioPlayerController>(builder: (apc) {
                              return Text(
                                apc.currentSongDuration.toString(),
                                style: seek_style,
                              );
                            }),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 40, left: 25, right: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              iconSize: 20,
                              icon: Icon(Icons.shuffle),
                              color: Colors.white,
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: Icon(Icons.skip_previous),
                              iconSize: 40,
                              color: Colors.white.withOpacity(0.7),
                              onPressed: () {},
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Color(0xff6F2CFF),
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xff6F2CFF).withOpacity(0.3),
                                      spreadRadius: 3,
                                      blurRadius: 8,
                                      offset: Offset(0, 3), // changes position of shadow
                                    ),
                                  ]
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: IconButton(
                                  icon: Icon(Icons.play_arrow),
                                  color: Colors.white,
                                  iconSize: 35,
                                  onPressed: () {},
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.skip_next),
                              iconSize: 40,
                              color: Colors.white.withOpacity(0.7),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: Icon(Icons.repeat),
                              color: Colors.white,
                              iconSize: 20,
                              onPressed: () {},
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
        Positioned(
          bottom: 0,
          child: Container(
            height: 60,
            width: MediaQuery.of(context).size.width,
            child: WaveWidget(
              isLoop: true,
              waveFrequency: 4,
              config: CustomConfig(
                gradients: [
                  [Color(0xff6F2CFF).withOpacity(0.07), Color(0xff6F2CFF).withOpacity(0.07)],
                  [Color(0xff6F2CFF).withOpacity(0.07), Color(0xff6F2CFF).withOpacity(0.07)],
                  [Color(0xff6F2CFF).withOpacity(0.07), Color(0xff6F2CFF).withOpacity(0.07)],
                  [Color(0xff6F2CFF).withOpacity(0.07), Color(0xff6F2CFF).withOpacity(0.07)]
                ],
                durations: [1000, 2000, 3000, 4000],
                heightPercentages: [0.20, 0.23, 0.25, 0.30],
                blur: MaskFilter.blur(BlurStyle.solid, 10),
                gradientBegin: Alignment.bottomLeft,
                gradientEnd: Alignment.topRight,
              ),
              waveAmplitude: 0,
              size: Size(
                double.infinity,
                60,
              ),
            ),
          ),
        ),
          ],
        ),
      ),
    );
  }
}
