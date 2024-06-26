import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_music/const/style.dart';
import 'package:local_music/views/home_tab/components/artist_widget.dart';
import 'package:local_music/views/home_tab/components/genre_widget.dart';
import 'package:local_music/views/home_tab/components/song_swiper.dart';

class HomeTab extends ConsumerStatefulWidget {
  const HomeTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeTabState();
}

class _HomeTabState extends ConsumerState<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Musica',style: Style().songTitleStyle,),
      ),
      body:  const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                
                ArtistWidget(),
                GenreWidget(),
                
                SwiperWidget()
                
              ],
            
            ),
          ),
    );
  }
}
