import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musicplayer/Models/songModelForPlaylist.dart';
import 'AudioQuerying.dart';

class AudioPlayerController extends GetxController{

  ///LoopMode:
  LoopMode loopMode = LoopMode.off;

  ///shuffled?:
  bool shuffled = false;

  ///initializing Audioplayer:
  final AudioPlayer player =  AudioPlayer();

  ///Audio querying:
  AudioQuerying audioQuerying = Get.put(AudioQuerying());

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

  ///Stream that tells loopmode:
  StreamSubscription loopModeStream;

  ///Stream shuffleMode:
  StreamSubscription shuffleModeEnabledStream;

  ///the current song that is being played:
  SongModelForPLayList currentSong = new  SongModelForPLayList();

  AnimationController playPauseAnimationController;


  ///A function to change milliseconds into hh:mm:ss
  changeMillisecondsToTime(Duration d) => d.toString().split('.').first.padLeft(8, "0");

  ///playPauseToggle:
  playPauseToggle(){
    player.playing ? player.pause() : player.play();
  }



  ///function for changing drag percentage:
  changeDragPercantage(double current){
    dragPercentage = current;
    player.seek(Duration(milliseconds: ((player.duration.inMilliseconds/100)*current).toInt()));
    update();
  }


  ///A function that initializes all the stream:
  initializeStreams() async{

    player.playerStateStream.listen((state) {
      state.playing ? playPauseAnimationController.forward() : playPauseAnimationController.reverse();
    });

    playerdurationStream = player.durationStream.listen((event) {
      currentSongDuration = changeMillisecondsToTime(Duration(milliseconds: event.inMilliseconds));
      update();
    });

    playerpositionStream = player.positionStream.listen((event) {
      currentSongPosition = changeMillisecondsToTime(Duration(milliseconds: event.inMilliseconds));
      double _dragPercentage = (event.inMilliseconds / player.duration.inMilliseconds) * 100;
      if(_dragPercentage<=100){
        dragPercentage = _dragPercentage;
      }else{
        dragPercentage = 100;
      }
      update();
    });


    streamOfCurrentSong = player.currentIndexStream.listen((event) {
       currentSong = currentSongList[event];
       update();
    });

    loopModeStream = player.loopModeStream.listen((event) {
       loopMode = event;
       update();
    });

    shuffleModeEnabledStream = player.shuffleModeEnabledStream.listen((event) {
       shuffled = event;
       update();
    });
  }

  ///Sets Audio source(for playlist):
  setAudioSourceForPlayList({@required List<SongModelForPLayList> songList}) async{

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

  ///Sets Audio source(for songs):
  setAudioSourceForSongs({SongInfo song}) async{

    int startFromIndex = audioQuerying.songs.indexOf(song);

    final Box<String> AlbumArtworkBox = Hive.box<String>("AlbumArtworkBox");

    currentSongList.clear();

    audioQuerying.songs.forEach((songInfo) {
      currentSongList.add(
          SongModelForPLayList(
              album: songInfo.album,
              albumArtwork: AlbumArtworkBox.get(songInfo.album),
              title: songInfo.title,
              artist: songInfo.artist,
              duration: songInfo.duration,
              composer: songInfo.composer,
              albumId: songInfo.albumId,
              artistId: songInfo.artistId,
              filePath: songInfo.filePath,
              fileSize: songInfo.fileSize,
              isMusic: songInfo.isMusic
          )
      );
    });

    update();

    List<AudioSource> sourceChildren = new List<AudioSource>();

    currentSongList.forEach((element) {
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
      initialIndex: startFromIndex, // default
      // Playback will be prepared to start from position zero.
      initialPosition: Duration.zero, // default
    );

    player.play();
  }

  ///loopToggling:
  loopToggle() async{
    if(loopMode == LoopMode.off){
      await player.setLoopMode(LoopMode.all);
    }
    else if(loopMode == LoopMode.all){
      await player.setLoopMode(LoopMode.one);
    }
    else if(loopMode == LoopMode.one){
      await player.setLoopMode(LoopMode.off);
    }
  }

  ///Shuffle Mode Toggling:
  shuffleToggle() async{
    await player.setShuffleModeEnabled(!player.shuffleModeEnabled);
  }

}