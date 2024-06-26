// ignore_for_file: unused_result
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:local_music/const/style.dart';
import 'package:local_music/state_management/riverpod/video_provider.dart';
import 'package:local_music/views/video_tab/components/video_player.dart';

List<String> strings = [];

class VideoTab extends ConsumerStatefulWidget {
  const VideoTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VideoTabState();
}

class _VideoTabState extends ConsumerState<VideoTab> {
  // var controller = Get.find<PlayerController>();

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(videoDataProvider);

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Video',
            style: Style().songTitleStyle,
          ),
        ),
        body: data.when(
          data: (data) {
            return ListView.separated(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                final videoItem = data[index];
                strings.addAll([videoItem.path]);

                var byte = int.parse(videoItem.size);
                var size = byte / 1000000;

                print("LIST:::::::::$strings");

                return Slidable(
                  key: Key(videoItem.name),
                  endActionPane: ActionPane(
                    motion: const StretchMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (_) {
                          showOkAlertDialog(
                            context: context,
                            okLabel: 'OK',
                            message: '''Name : ${videoItem.name}\n
                                                        Path : ${videoItem.path}\n
                                                        Size : ${size.toStringAsFixed(2)} MB
                                                                        ''',
                            title: "Video Details",
                            style: AdaptiveStyle.iOS,
                          );
                        },
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        icon: Icons.details,
                        label: 'Details',
                      ),
                      SlidableAction(
                        onPressed: (_) {},
                        backgroundColor: const Color(0xFF21B7CA),
                        foregroundColor: Colors.white,
                        icon: Icons.share,
                        label: 'Share',
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Text(videoItem.name,
                        style: Style().artistStyle, maxLines: 1),
                    subtitle: Text("${size.toStringAsFixed(2)} MB"),
                    onTap: () {
                      ref.read(videoPathProvider.notifier).state =
                          videoItem.path;
                          print("videoPathProvider ${videoPathProvider.notifier}");
                      Get.to(
                        () => VideoPlayerScreen(videoItem: videoItem),
                      );
                      // transition: Transition.topLevel);
                    },
                    trailing: const Icon(Icons.play_arrow),
                    // leading: Container(),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
            );
            // return Text('Hi');
          },
          error: (error, __) => Text(error.toString()),
          loading: () => const Center(
            child: CupertinoActivityIndicator(),
          ),
        ));
  }
}
