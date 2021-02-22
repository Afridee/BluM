import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musicplayer/Models/songModelForPlaylist.dart';

class AudioPlayerController extends GetxController{

  ///initializing Audioplayer:
  final AudioPlayer player =  AudioPlayer();

  ///Drag Percantage:
  double dragPercentage = 0.0;

  ///Represents list of currentsongs:
  List<SongModelForPLayList> currentSongList = new List<SongModelForPLayList>();

  ///Stream that gives the index of current song:
  StreamSubscription streamOfCurrentSong;

  ///Stream that gives the index of current song:
  StreamSubscription playerdurationStream;

  ///CurrentSongDuration:
  String currentSongDuration = "00:00:00";

  ///CurrentSongPosition
  String currentSongPosition = "00:00:00";

  ///Stream that gives the index of current song:
  StreamSubscription playerpositionStream;

  ///the current song that is being played:
  SongModelForPLayList currentSong = new  SongModelForPLayList();


  ///A function to change milliseconds into hh:mm:ss
  changeMillisecondsToTime(Duration d) => d.toString().split('.').first.padLeft(8, "0");

  ///function for changing drag percentage:
  changeDragPercantage(double current){
    dragPercentage = current;
    update();
  }


  ///A function that initializes all the stream:
  initializeStreams() async{

    playerdurationStream = player.durationStream.listen((event) {
      currentSongDuration = changeMillisecondsToTime(Duration(milliseconds: event.inMilliseconds));
      update();
    });

    playerpositionStream = player.positionStream.listen((event) {
      currentSongPosition = changeMillisecondsToTime(Duration(milliseconds: event.inMilliseconds));
      update();
    });


    streamOfCurrentSong = player.currentIndexStream.listen((event) {
       currentSong = currentSongList[event];
       update();
    });
  }

  ///Sets Audio source:
  setAudioSource({@required List<SongModelForPLayList> songList}) async{

    currentSongList = songList;
    update();

    List<AudioSource> sourceChildren = new List<AudioSource>();

    songList.forEach((element) { 
      sourceChildren.add(AudioSource.uri(Uri.parse(element.filePath)));
    });

    await player.setAudioSource(
      ConcatenatingAudioSource(
        // Start loading next item just before reaching it.
        useLazyPreparation: true, // default
        // Customise the shuffle algorithm.
        shuffleOrder: DefaultShuffleOrder(), // default
        // Specify the items in the playlist.
        children: sourceChildren,
      ),
      // Playback will be prepared to start from track1.mp3
      initialIndex: 0, // default
      // Playback will be prepared to start from position zero.
      initialPosition: Duration.zero, // default
    );

    player.play();
  }

}