import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_music/views/albums/album.dart';
import 'package:local_music/views/all_songs.dart';
import 'package:local_music/views/home_tab/home_tab.dart';

import 'video_tab/video_tab.dart';

class BottomNavScreen extends ConsumerStatefulWidget {
  const BottomNavScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends ConsumerState<BottomNavScreen> {
  
  var _bottomNavIndex = 0;
  
  final iconList = <IconData>[
    Icons.home,
    Icons.music_video,
    Icons.album,
    Icons.settings,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const [
        HomePage(),
        VideoTab(),
        AlbumView(),
        HomeTab(),
      ][_bottomNavIndex],
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: iconList,
        activeColor: Colors.black,
        inactiveColor: Colors.grey,
        activeIndex: _bottomNavIndex,
        gapLocation: GapLocation.none,
        notchSmoothness: NotchSmoothness.sharpEdge,
        onTap: (index) => setState(() => _bottomNavIndex = index),
          //other params
      ),

    );
  }
}