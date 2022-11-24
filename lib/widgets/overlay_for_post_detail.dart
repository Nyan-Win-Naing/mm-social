import 'dart:ui';

import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:mm_social/data/vos/feed_vo.dart';
import 'package:mm_social/resources/colors.dart';
import 'package:mm_social/resources/dimens.dart';
import 'package:video_player/video_player.dart';

late OverlayEntry overlayEntryForPostDetail;

void insertOverlayForPostDetail(BuildContext context, FeedVO? feed) {
  overlayEntryForPostDetail = OverlayEntry(
    builder: (context) {
      return GestureDetector(
        onTap: () {
          overlayEntryForPostDetail.remove();
        },
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 10.0),
          child: Scaffold(
            backgroundColor: Color.fromRGBO(0, 0, 0, 0.8),
            body: Padding(
              padding: const EdgeInsets.only(top: MARGIN_XXLARGE),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: MARGIN_CARD_MEDIUM_2),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UsernameSectionView(username: feed?.userName ?? ""),
                        SizedBox(height: MARGIN_MEDIUM_2),
                        PostDescriptionSectionView(
                            description: feed?.description ?? ""),
                        SizedBox(height: MARGIN_MEDIUM_2),
                        Visibility(
                          visible: (feed?.postImage ?? "").isNotEmpty,
                          child:
                              ImageSectionView(imageUrl: feed?.postImage ?? ""),
                        ),
                        Visibility(
                          visible: (feed?.postVideo ?? "").isNotEmpty,
                          child:
                              VideoSectionView(videoUrl: feed?.postVideo ?? ""),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );

  Overlay.of(context)?.insert(overlayEntryForPostDetail);
}

class ImageSectionView extends StatelessWidget {
  final String imageUrl;

  ImageSectionView({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(MARGIN_CARD_MEDIUM_2),
      child: Image.network(
        imageUrl,
        height: 200,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}

class VideoSectionView extends StatefulWidget {
  final String videoUrl;

  VideoSectionView({required this.videoUrl});

  @override
  State<VideoSectionView> createState() => _VideoSectionViewState();
}

class _VideoSectionViewState extends State<VideoSectionView> {
  late FlickManager flickManager;

  @override
  void initState() {
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(widget.videoUrl),
      autoPlay: false,
    );
    super.initState();
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(MARGIN_CARD_MEDIUM_2),
        child: FlickVideoPlayer(flickManager: flickManager),
      ),
    );
  }
}

class PostDescriptionSectionView extends StatelessWidget {
  final String description;

  PostDescriptionSectionView({required this.description});

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      style: TextStyle(
        color: CONTACT_PHONE_NUMBER_COLOR,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class UsernameSectionView extends StatelessWidget {
  final String username;

  UsernameSectionView({required this.username});

  @override
  Widget build(BuildContext context) {
    return Text(
      username,
      style: TextStyle(
        color: Colors.white,
        fontSize: TEXT_REGULAR_2X,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
