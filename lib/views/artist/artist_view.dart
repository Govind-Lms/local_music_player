import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_music/const/style.dart';

import 'package:local_music/views/artist/components/onclick_artist.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ArtistView extends ConsumerStatefulWidget {
  final ArtistModel artistModel;
  const ArtistView({super.key, required this.artistModel});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ArtistViewState();
}

class _ArtistViewState extends ConsumerState<ArtistView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 300.0,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              widget.artistModel.artist,
              style: Style().songTitleStyle.copyWith(color: Colors.black),
            ),
            background: QueryArtworkWidget(
              id: widget.artistModel.id,
              type: ArtworkType.ARTIST,
              artworkBorder: BorderRadius.zero,
              artworkWidth: MediaQuery.of(context).size.width,
              artworkHeight: 300.0,
              size: 1024,
              quality: 100,
            ),
          ),
        ),
        const SliverToBoxAdapter(child: ArtistSongs()),
        
      ],
    ));
  }
}
