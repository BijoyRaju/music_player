import 'package:flutter/material.dart';
import 'package:music_player/components/neu_box.dart';
import 'package:music_player/components/my_drawer.dart';
import 'package:music_player/controller/playlist_controller.dart';
import 'package:music_player/models/song.dart';
import 'package:music_player/view/song_page.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  late final dynamic playListController;

  @override
  void initState() {
    playListController = Provider.of<PlaylistController>(context,listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text("P L A Y L I S T"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),drawer: MyDrawer(),
      body:
       
      Consumer<PlaylistController>(
        builder: (context, value, child) {
          final List<Song> playlist = value.playlist;
          return ListView.builder(
            itemCount: value.playlist.length,
            itemBuilder: (context,index){
              final Song song = playlist[index];
              return Padding(padding: EdgeInsets.all(10),
              child: NeuBox(child: 
              ListTile(
                leading: Image.asset(song.albumArtImagePath),
                title: Text(song.songName),
                subtitle: Text(song.artistName),
                onTap: () {
                  goToSong(index);
                }
              )));
            },
          );
        },
      ),
    );
  }

  // Go to Song Page
    void goToSong(int index){
      playListController.currentSongIndex = index;
      Navigator.push(context, MaterialPageRoute(builder: (context) => SongPage()));
    }
}