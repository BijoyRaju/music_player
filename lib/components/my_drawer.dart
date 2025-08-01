import 'package:flutter/material.dart';
import 'package:music_player/view/settings.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          DrawerHeader(
            child: Center(
              child: Icon(Icons.music_note,size: 40,color: Theme.of(context).colorScheme.inversePrimary),
            ),
          ),

          // Home
          Padding(
            padding: EdgeInsets.only(left: 25,top: 25),
            child: ListTile(
              title: Text("Home",style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),),
              onTap: () {
                Navigator.pop(context);
              },
              leading: Icon(Icons.home,color: Theme.of(context).colorScheme.inversePrimary),
            )),

          // Settings
          Padding(
            padding: EdgeInsets.only(left: 25,top: 25),
            child: ListTile(title: Text("Settings",style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => Settings()));
            },
            leading: Icon(Icons.settings,color: Theme.of(context).colorScheme.inversePrimary),
            ),),
        ],
      )
    );
  }
}