import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:io';
import 'dart:async';

import 'package:flutter/services.dart';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:function_test/models/myAudio.dart';
import 'package:function_test/models/playingControls.dart';
import 'package:function_test/widgets/songSelector.dart';

class MusicPlayerScreen extends StatefulWidget{
  _MusicPlayerScreenState createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {

  final audios = <MyAudio>[
    MyAudio(
        name: "Online",
        audio: Audio.network("https://files.freemusicarchive.org/storage-freemusicarchive-org/music/Music_for_Video/springtide/Sounds_strange_weird_but_unmistakably_romantic_Vol1/springtide_-_03_-_We_Are_Heading_to_the_East.mp3"),
        imageUrl: "https://image.shutterstock.com/image-vector/pop-music-text-art-colorful-600w-515538502.jpg"),
    MyAudio(
        name: "12월 24일",
        audio: Audio("audios/1224.mp3"),
        imageUrl:
            "https://static.radio.fr/images/broadcasts/cb/ef/2075/c300.png"),
    MyAudio(
        name: "Blueming",
        audio: Audio("audios/Blueming.mp3"),
        imageUrl:
            "https://images-na.ssl-images-amazon.com/images/I/81M1U6GPKEL._SL1500_.jpg"),
    MyAudio(
        name: "마음",
        audio: Audio("audios/Heart.mp3"),
        imageUrl: "https://i.ytimg.com/vi/nVZNy0ybegI/maxresdefault.jpg"),
    MyAudio(
        name: "하울의 움직이는 성",
        audio: Audio("audios/MoveCath.mp3"),
        imageUrl:
            "https://beyoudancestudio.ch/wp-content/uploads/2019/01/apprendre-danser.hiphop-1.jpg"),
    MyAudio(
        name: "이누야샤",
        audio: Audio("audios/Inuyasha.mp3"),
        imageUrl: "https://image.shutterstock.com/image-vector/pop-music-text-art-colorful-600w-515538502.jpg"),
    MyAudio(
        name: "이누야샤 - 파일",
        audio: Audio.file("audios/Inuyasha.mp3"),
        imageUrl: "https://image.shutterstock.com/image-vector/pop-music-text-art-colorful-600w-515538502.jpg"),
  ];

  final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();
  final List<StreamSubscription> _subscriptions = [];

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
  Future<String> get _audioPath async {
    final directory = await _localPath;
    return (directory + '/flutter_assets');
  }
  Future<List<FileSystemEntity>> _audiolist() async {
    final directory = await _audioPath;

    Directory dir = new Directory('audios');
    
    List<FileSystemEntity> _files;
    List<FileSystemEntity> _song = [];
    List<String> _songPath;

    _files = dir.listSync();
    for(FileSystemEntity entity in _files){
      String path = entity.path;
      if(path.endsWith('.mp3')){
        _song.add(entity);
      }
    }
    return _song;
  }

  @override
  void initState() {
    
    // _audiolist().then((List<FileSystemEntity> songs) {
    //   for(int i=0; i<songs.length; i++){
    //     print(songs[i].path);
    //   }
    // });

    

    _subscriptions.add(_assetsAudioPlayer.playlistFinished.listen((data){
      print('finish : $data');
    }));
    _subscriptions.add(_assetsAudioPlayer.playlistAudioFinished.listen((data){
      print('playlistAudioFinished : $data');
    }));
    _subscriptions.add(_assetsAudioPlayer.current.listen((data){
      print('current : $data');
    }));
    _subscriptions.add(_assetsAudioPlayer.onReadyToPlay.listen((data){
      print('onReadyToPlay : $data');
    }));
    super.initState();
  }
  @override void dispose() {
    _assetsAudioPlayer.dispose();
    super.dispose();
  }

  MyAudio find(List<MyAudio> source, String fromPath) {
    return source.firstWhere((element) => element.audio.path == fromPath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      body: SafeArea(
        child:Padding(
          padding: const EdgeInsets.only(bottom:48.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Stack(
                fit: StackFit.passthrough,
                children: <Widget>[
                  StreamBuilder(
                    stream: _assetsAudioPlayer.current,
                    builder: (BuildContext context, AsyncSnapshot<Playing> snapshot) {
                      final Playing playing = snapshot.data;
                      if(playing != null) {
                        final myAudio = find(this.audios, playing.audio.assetAudioPath);
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Neumorphic(
                            boxShape: NeumorphicBoxShape.circle(), 
                            style: NeumorphicStyle(depth: 8, 
                              surfaceIntensity: 1, 
                              shape: NeumorphicShape.concave), 
                            child :Image.network(
                              myAudio.imageUrl,
                              height: 150,
                              width: 150,
                              fit: BoxFit.contain
                            )
                          )
                        );
                      }
                      return SizedBox();
                    },
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: NeumorphicButton(
                      boxShape: NeumorphicBoxShape.circle(),
                      padding: EdgeInsets.all(18),
                      margin: EdgeInsets.all(18),
                      onClick: () {
                        AssetsAudioPlayer.playAndForget(Audio("audios/1224.mp3"));
                      },
                      child:Icon(
                        Icons.add_alert,
                        color: Colors.grey[800],
                      )
                    )
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 20,
              ),
              StreamBuilder(
                stream: _assetsAudioPlayer.current,
                builder: (context, snapshot){
                  if(!snapshot.hasData) {
                    return SizedBox();
                  }
                  final Playing playing = snapshot.data;
                  return Column(
                    children: <Widget>[
                      StreamBuilder(
                        stream: _assetsAudioPlayer.isLooping,
                        builder: (context, snapshotLooping) {
                          final isLooping = snapshotLooping.data;
                          return StreamBuilder(
                            stream: _assetsAudioPlayer.isPlaying,
                            initialData: false,
                            builder: (context, snapshotPlaying) {
                              final isPlaying = snapshotPlaying.data;
                              return PlayingControls(
                                isLooping: isLooping,
                                isPlaying: isPlaying,
                                isPlaylist:
                                  playing.playlist.audios.length > 1,
                                toggleLoop: () {
                                  _assetsAudioPlayer.toggleLoop();
                                },
                                onPlay: () {
                                  _assetsAudioPlayer.playOrPause();
                                },
                                onNext: () {
                                  _assetsAudioPlayer.next();
                                },
                                onPrevious: () {
                                  _assetsAudioPlayer.previous();
                                },
                              );
                            });
                        }),
                        // StreamBuilder(
                        //   stream: _assetsAudioPlayer.realtimePlayingInfos,
                        //   builder: (context, snapshot) {
                        //     if(!snapshot.hasData)
                        //       return SizedBox();

                        //     final RealtimePlayingInfos info = snapshot.data;
                        //     return PositionsS
                        //   }
                        // ),
                    ],
                  );
                },
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: StreamBuilder(
                  stream: _assetsAudioPlayer.current,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    final Playing playing = snapshot.data;
                    return SongSelector(audios: this.audios, onPlaylistSelected: (myAudios) {
                      _assetsAudioPlayer.open(Playlist(audios: myAudios.map((e) => e.audio).toList()));
                    }, onSelected: (myAudios) {
                      _assetsAudioPlayer.open(myAudios.audio, autoStart: false, respectSilentMode: true);
                    },
                    playing: playing,);
                  },
                )
              ),
            ],
          ),
        )
        
      ),
    );
  }
}