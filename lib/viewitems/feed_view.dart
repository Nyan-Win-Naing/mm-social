import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:mm_social/data/vos/feed_vo.dart';
import 'package:mm_social/resources/colors.dart';
import 'package:mm_social/resources/dimens.dart';
import 'package:mm_social/widgets/overlay_for_post_detail.dart';
import 'package:video_player/video_player.dart';

class FeedView extends StatelessWidget {
  final FeedVO? feed;
  final Function(int) onTapEdit;
  final Function(int) onTapDelete;

  FeedView(
      {required this.feed, required this.onTapEdit, required this.onTapDelete});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final avatarRadius = screenHeight / 30;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
          child: PosterInfoView(
            avatarRadius: avatarRadius,
            feed: feed,
            onTapEdit: () {
              onTapEdit(feed?.id ?? 0);
            },
            onTapDelete: () {
              onTapDelete(feed?.id ?? 0);
            },
          ),
        ),
        SizedBox(height: MARGIN_MEDIUM_2),
        Visibility(
          visible: (feed?.postImage ?? "").isNotEmpty,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
            child: GestureDetector(
              onTap: () {
                insertOverlayForPostDetail(context, feed);
              },
              child: PostImageSectionView(
                postImage: feed?.postImage ?? "",
              ),
            ),
          ),
        ),
        Visibility(
          visible: (feed?.postVideo ?? "").isNotEmpty,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
            child: PostVideoSectionView(postVideo: feed?.postVideo ?? ""),
          ),
        ),
        Visibility(
          visible: (feed?.postImage ?? "").isNotEmpty ||
              (feed?.postVideo ?? "").isNotEmpty,
          child: SizedBox(height: MARGIN_MEDIUM_2),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
          child: GestureDetector(
            onTap: () {
              insertOverlayForPostDetail(context, feed);
            },
            child: PostDescriptionSectionView(
                description: feed?.description ?? ""),
          ),
        ),
        SizedBox(height: MARGIN_MEDIUM_2),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
          child: PostInteractionSectionView(),
        ),
      ],
    );
  }
}

class PostInteractionSectionView extends StatelessWidget {
  const PostInteractionSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            PostInteractionIconView(iconData: Icons.favorite),
            SizedBox(width: MARGIN_MEDIUM),
            PostInteractionIconView(iconData: Icons.comment),
          ],
        ),
        PostInteractionIconView(iconData: Icons.share),
      ],
    );
  }
}

class PostInteractionIconView extends StatelessWidget {
  final IconData iconData;

  PostInteractionIconView({required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Icon(
      iconData,
      color: CONTACT_PHONE_NUMBER_COLOR,
      size: MARGIN_XLARGE,
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
        color: Color.fromRGBO(255, 255, 255, 0.7),
        fontSize: TEXT_13,
        height: 1.5,
      ),
    );
  }
}

class PostImageSectionView extends StatelessWidget {
  final String postImage;

  PostImageSectionView({required this.postImage});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(MARGIN_MEDIUM_2),
      child: Image.network(
        postImage,
        fit: BoxFit.cover,
        width: double.infinity,
        height: 200,
      ),
    );
  }
}

class PostVideoSectionView extends StatefulWidget {
  final String postVideo;

  PostVideoSectionView({required this.postVideo});

  @override
  State<PostVideoSectionView> createState() => _PostVideoSectionViewState();
}

class _PostVideoSectionViewState extends State<PostVideoSectionView> {
  FlickManager? flickManager;

  @override
  void dispose() {
    flickManager?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(widget.postVideo),
      autoPlay: false,
    );
    return ClipRRect(
      borderRadius: BorderRadius.circular(MARGIN_MEDIUM_2),
      child: FlickVideoPlayer(
        flickManager: flickManager!,
      ),
    );
  }
}

class PosterInfoView extends StatelessWidget {
  const PosterInfoView({
    Key? key,
    required this.avatarRadius,
    required this.feed,
    required this.onTapEdit,
    required this.onTapDelete,
  }) : super(key: key);

  final double avatarRadius;
  final FeedVO? feed;
  final Function onTapEdit;
  final Function onTapDelete;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: avatarRadius,
              backgroundImage: NetworkImage(
                feed?.profilePicture ?? "",
              ),
            ),
            SizedBox(width: MARGIN_MEDIUM),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  feed?.userName ?? "",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: TEXT_REGULAR_2X,
                  ),
                ),
                Text(
                  "2 mins ago",
                  style: TextStyle(
                    color: CONTACT_PHONE_NUMBER_COLOR,
                    fontSize: TEXT_SMALL,
                  ),
                ),
              ],
            )
          ],
        ),
        PopupMenuButton(
          icon: Icon(
            Icons.more_horiz,
            color: Colors.white,
          ),
          iconSize: MARGIN_LARGE,
          itemBuilder: (context) => [
            PopupMenuItem(
              child: Text("Edit"),
              value: 1,
              onTap: () {
                onTapEdit();
              },
            ),
            PopupMenuItem(
              child: Text("Delete"),
              value: 2,
              onTap: () {
                onTapDelete();
              },
            ),
          ],
        ),
      ],
    );
  }
}
