import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Models/AlbumModel.dart';

class AudioQuerying extends GetxController{

  FlutterAudioQuery audioQuery = FlutterAudioQuery();
  List<SongInfo> songs = new List<SongInfo>();
  List<PlaylistInfo> playlist = new List<PlaylistInfo>() ;
  List<ArtistInfo> artists = new List<ArtistInfo>();
  List<GenreInfo> genreList = new List<GenreInfo>();
  List<AlbumInfo> albumList = new List<AlbumInfo>();
  List<Map<String,String>> albumArtworks = new List<Map<String,String>>();

  AudioQuerying(){
    initialize();
  }

  initialize() async{

      audioQuery = FlutterAudioQuery();

      /// getting all songs available on device storage
      songs = await audioQuery.getSongs(sortType: SongSortType.DEFAULT);

      /// getting all playlist available
      playlist = await audioQuery.getPlaylists();

      /// returns all artists available
      artists = await audioQuery.getArtists();

      /// getting all genres available
      genreList = await audioQuery.getGenres();

      /// getting all albums available on device storage
      albumList = await audioQuery.getAlbums();

      /// getting all album artworks because the one from the plugin doesn't work
      initializeAlbumArtwork();

      update();
  }

  initializeAlbumArtwork(){
    albumList.forEach((element) async{
      var client = http.Client();
      final response = await client.post('http://ws.audioscrobbler.com/2.0/?method=album.getinfo&api_key=7cd3935946a144b1b49d6b30dd4a5a0d&artist=${element.artist}&album=${element.title}&format=json');
      if(jsonDecode(response.body)['message'] != "Album not found"){
        try{
          AlbumModel m = AlbumModel.fromJson(jsonDecode(response.body));
          albumArtworks.add({element.title : m.album.image.last.text});
        }catch(e){
          print('Error: ' + e.toString());
        }
      }
    });
  }

  changeMillisecondsToTime(Duration d) => d.toString().split('.').first.padLeft(8, "0");

}