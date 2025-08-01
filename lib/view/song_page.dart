import 'package:flutter/material.dart';
import 'package:music_player/components/neu_box.dart';
import 'package:music_player/controller/playlist_controller.dart';
import 'package:provider/provider.dart';

class SongPage extends StatelessWidget {
  const SongPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistController>(
      builder: (context, value, child) {
        // Get The playlist
        final playlist = value.playlist;

        // Get The current song
        final currentSong = playlist[value.currentSongIndex ?? 0];

        return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          // App Bar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Back Button
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios_new_rounded),
              ),
              // Title
              Text("P L A Y L I S T"),
              // Menu
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.menu_rounded),
              ),

            ],
          ),
          SizedBox(height: 40),
          // Album Network
          NeuBox(
            child: Column(
              children: [
                // Image
                ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(currentSong.albumArtImagePath),
              ),

              // Song and Artist Name
              Padding(
                padding: EdgeInsets.all(25), 
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Song Name Artist Name
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(currentSong.songName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                      Text(currentSong.artistName, style: Theme.of(context).textTheme.bodyMedium,),
                    ]
                  ),
                  Row(
                    children: [
                      // Heart Icon
                      IconButton(onPressed: (){}, icon: Icon(Icons.favorite,color: Colors.red))
                    ],
                  )
                ],
              ))
              ],
            )
          ),
          // Song Duration Progress 
          Padding(padding: EdgeInsetsGeometry.all(25),
          child: Column(
            children: [
              Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Start Time
              Text(value.currentDuration.toString().split(".")[0]),

              // Shuffle Icon
              IconButton(onPressed: (){}, icon: Icon(Icons.shuffle_rounded)),

              IconButton(onPressed: (){}, icon: Icon(Icons.repeat_rounded)),

              // End Time
              Text(value.totalDuration.toString().split(".")[0]),
            ],
          ),
          SliderTheme(
          data: SliderTheme.of(context).copyWith(
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 0),
          ),
          child: Slider(
            min: 0,
            max: value.totalDuration.inSeconds.toDouble(),
            activeColor: Colors.green,
            inactiveColor: Colors.grey,
            value: value.currentDuration.inSeconds.toDouble(),
            onChanged: (double double){},
            onChangeEnd: (double double){
              value.seek(Duration(seconds: value.currentDuration.inSeconds));
            }
            ))
            
          ],
        )),
          // Song Controls
          Row(
            children: [
              // Skip Previous
              Expanded(
                child: GestureDetector(
                onTap: value.playNextSong,
                child: NeuBox(child: Icon(Icons.skip_previous_rounded)),
              )),
              SizedBox(width: 20),
              // Play Pause
              Expanded(
                flex: 2,
                child: GestureDetector(
                onTap: value.pauseOrResume,
                child: NeuBox(child: Icon(value.isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded)),
              )),
              SizedBox(width: 20),
              // Skip forward
              Expanded(
                child: GestureDetector(
                onTap: value.playNextSong,
                child: NeuBox(child: Icon(Icons.skip_next_rounded)),
              )),
            ],
          )
        ],
      ))
    ));
  });
  }
}