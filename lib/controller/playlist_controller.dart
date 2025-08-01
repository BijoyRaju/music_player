import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_player/models/song.dart';

class PlaylistController extends ChangeNotifier {
  
  final List<Song> _playlist = [
    Song(
      songName: "Faded",
      artistName: "Alan Walker",
      albumArtImagePath: "assets/images/faded.png",
      audioPath: "faded.mp3"
    ),
    Song(
      songName: "Shape of You",
      artistName: "Ed Sheeran",
      albumArtImagePath: "assets/images/shape_of_you.png",
      audioPath: "shape_of_you.mp3"
    ),
    Song(
      songName: "Queen Of Hearts",
      artistName: "Starla Edney",
      albumArtImagePath: "assets/images/queen_of_hearts.jpg",
      audioPath: "queen_of_hearts.mp3"
    ),
    Song(
      songName: "Into Your Arms",
      artistName: "The Weeknd",
      albumArtImagePath: "assets/images/into_your_arms.jpg",
      audioPath: "into_your_arms.mp3"
    ),
  ];

  int? _currentSongIndex;

  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

  set currentSongIndex(int? index){
    _currentSongIndex = index;
    notifyListeners();
    if(index != null){
      play();
    }
  }

  final AudioPlayer _audioPlayer = AudioPlayer();

  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  PlaylistController() {
    listenToDuration();
  }

  bool _isPlaying = false;

  void play() async {
    final String filename = _playlist[_currentSongIndex!].audioPath;
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource('audio/$filename')); 
    _isPlaying = true;
    notifyListeners();
  }

  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  void pauseOrResume() {
    if (_isPlaying) {
      pause();
    } else {
      resume();
    }
  }

  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  void playNextSong() {
    if (_currentSongIndex != null && _currentSongIndex! < _playlist.length - 1) {
      currentSongIndex = _currentSongIndex! + 1;
    } else {
      currentSongIndex = 0;
    }
  }

  void playPreviousSong() {
    if (_currentDuration.inSeconds > 3) {
      seek(Duration.zero);
    } else {
      if (_currentSongIndex != null && _currentSongIndex! > 0) {
        currentSongIndex = _currentSongIndex! - 1;
      } else {
        currentSongIndex = _playlist.length - 1;
      }
    }
  }

  void listenToDuration() {
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });

    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });

    _audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
    });
  }
}
