import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:mm_social/blocs/add_new_post_bloc.dart';
import 'package:mm_social/resources/colors.dart';
import 'package:mm_social/resources/dimens.dart';
import 'package:mm_social/widgets/loading_view.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

const kAnimationDuration = Duration(milliseconds: 200);

class AddNewPostPage extends StatefulWidget {

  final int? feedId;


  AddNewPostPage({this.feedId});

  @override
  State<AddNewPostPage> createState() => _AddNewPostPageState();
}

class _AddNewPostPageState extends State<AddNewPostPage> {
  FlickManager? flickManager;

  bool isOpenBottomSheet = false;

  @override
  void dispose() {
    flickManager?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final avatarRadius = screenHeight / 30;

    return ChangeNotifierProvider(
      create: (context) => AddNewPostBloc(feedId: widget.feedId),
      child: Selector<AddNewPostBloc, bool>(
        selector: (context, bloc) => bloc.isLoading,
        builder: (context, isLoading, child) => Stack(
          children: [
            Scaffold(
              backgroundColor: SECONDARY_COLOR,
              appBar: AppBar(
                backgroundColor: PRIMARY_COLOR,
                centerTitle: true,
                elevation: 2.0,
                title: Text(
                  "Create Post",
                ),
                leading: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.close,
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 10, right: MARGIN_MEDIUM),
                    child: Consumer<AddNewPostBloc>(
                      builder: (context, bloc, child) => TextButton(
                        onPressed: () {
                          bloc.onTapAddNewPost().then((value) {
                            Navigator.pop(context);
                          });
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                ADD_NEW_POST_BUTTON_COLOR)),
                        child: Text(
                          "Post",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              body: Container(
                child: Consumer<AddNewPostBloc>(
                  builder: (context, bloc, child) => Stack(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: MARGIN_MEDIUM_2),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: MARGIN_MEDIUM),
                              child: PosterProfileSectionView(
                                avatarRadius: avatarRadius,
                                profileImage: bloc.profilePicture,
                                name: bloc.userName,
                              ),
                            ),
                            SizedBox(height: MARGIN_MEDIUM),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: MARGIN_MEDIUM),
                              child: AddNewPostTextFieldView(
                                onChanged: (value) {
                                  bloc.onNewPostTextChanged(value);
                                },
                                prepopulateDescription: bloc.newPostDescription,
                              ),
                            ),
                            (bloc.isAddNewPostError)
                                ? Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: MARGIN_MEDIUM),
                                    child: Text(
                                      "Text must not be empty.",
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: TEXT_SMALL,
                                      ),
                                    ),
                                  )
                                : Container(),
                            SizedBox(height: MARGIN_MEDIUM),
                            (bloc.chosenImageFile != null ||
                                    bloc.chosenVideoFile != null)
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: MARGIN_MEDIUM),
                                    child: (bloc.chosenImageFile != null)
                                        ? Stack(
                                            children: [
                                              Image.file(
                                                bloc.chosenImageFile ??
                                                    File(""),
                                                width: double.infinity,
                                                height: 200,
                                                fit: BoxFit.cover,
                                              ),
                                              Align(
                                                alignment: Alignment.topRight,
                                                child:
                                                    RemoveFileView(bloc: bloc),
                                              ),
                                            ],
                                          )
                                        : Builder(
                                          builder: (context) {
                                            flickManager = FlickManager(
                                              videoPlayerController:
                                              VideoPlayerController
                                                  .file(
                                                bloc.chosenVideoFile ??
                                                    File(""),
                                              ),
                                              autoPlay: false,
                                            );
                                            return Container(
                                                height: 200,
                                                child: Stack(
                                                  children: [
                                                    FlickVideoPlayer(
                                                      flickManager: flickManager ?? FlickManager(videoPlayerController: VideoPlayerController.network("")),
                                                    ),
                                                    Align(
                                                      alignment: Alignment.topRight,
                                                      child: RemoveFileView(
                                                          bloc: bloc),
                                                    ),
                                                  ],
                                                ),
                                              );
                                          }
                                        ),
                                  )
                                : (bloc.postImageUrl.isNotEmpty ||
                                        bloc.postVideoUrl.isNotEmpty)
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: MARGIN_MEDIUM),
                                        child: (bloc.postImageUrl.isNotEmpty)
                                            ? Stack(
                                                children: [
                                                  Image.network(
                                                    bloc.postImageUrl,
                                                    width: double.infinity,
                                                    height: 200,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: RemoveFileView(
                                                        bloc: bloc),
                                                  ),
                                                ],
                                              )
                                            : Builder(
                                              builder: (context) {
                                                flickManager = FlickManager(
                                                  videoPlayerController:
                                                  VideoPlayerController
                                                      .network(
                                                    bloc.postVideoUrl,
                                                  ),
                                                  autoPlay: false,
                                                );
                                                return Container(
                                                    height: 200,
                                                    child: Stack(
                                                      children: [
                                                        FlickVideoPlayer(
                                                          flickManager: flickManager!,
                                                        ),
                                                        Align(
                                                          alignment:
                                                              Alignment.topRight,
                                                          child: RemoveFileView(
                                                              bloc: bloc),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                              }
                                            ),
                                      )
                                    : Container(),
                            SizedBox(height: MARGIN_XXLARGE),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: AnimatedSize(
                          duration: kAnimationDuration,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: MARGIN_MEDIUM,
                                vertical: MARGIN_SMALL),
                            decoration: BoxDecoration(
                              color: PRIMARY_COLOR,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(MARGIN_MEDIUM_2),
                                topRight: Radius.circular(MARGIN_MEDIUM_2),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.1),
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: Offset(0, -3),
                                ),
                              ],
                            ),
                            child: (!isOpenBottomSheet)
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isOpenBottomSheet =
                                                !isOpenBottomSheet;
                                          });
                                        },
                                        child: Icon(
                                          Icons.arrow_drop_up_outlined,
                                          color: CONTACT_PHONE_NUMBER_COLOR,
                                          size: MARGIN_XLARGE,
                                        ),
                                      ),
                                    ],
                                  )
                                : Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                isOpenBottomSheet =
                                                    !isOpenBottomSheet;
                                              });
                                            },
                                            child: Icon(
                                              Icons.arrow_drop_down_outlined,
                                              color: CONTACT_PHONE_NUMBER_COLOR,
                                              size: MARGIN_XLARGE,
                                            ),
                                          ),
                                        ],
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          final FilePickerResult? result =
                                              await FilePicker.platform
                                                  .pickFiles();
                                          if (result != null) {
                                            File file = File(
                                                result.files.single.path ?? "");
                                            bloc.onFileChosen(file);
                                          }
                                        },
                                        child: AddNewPostFunctionItemView(
                                          iconData: Icons.insert_photo_outlined,
                                          color: Colors.green,
                                          label: "Photo / Video",
                                        ),
                                      ),
                                      SizedBox(height: MARGIN_SMALL),
                                      AddNewPostFunctionItemView(
                                          iconData: Icons.tag_rounded,
                                          color: Colors.blue,
                                          label: "Tag people"),
                                      SizedBox(height: MARGIN_SMALL),
                                      AddNewPostFunctionItemView(
                                          iconData: Icons.tag_faces_sharp,
                                          color: Colors.yellow,
                                          label: "Feeling / activity"),
                                      SizedBox(height: MARGIN_SMALL),
                                      AddNewPostFunctionItemView(
                                          iconData: Icons.location_on,
                                          color: Colors.redAccent,
                                          label: "Photo / Video"),
                                      SizedBox(height: MARGIN_SMALL),
                                      AddNewPostFunctionItemView(
                                          iconData: Icons.video_call,
                                          color: Colors.red,
                                          label: "Photo / Video"),
                                    ],
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
              visible: isLoading,
              child: LoadingView(),
            ),
          ],
        ),
      ),
    );
  }
}

class RemoveFileView extends StatelessWidget {
  final AddNewPostBloc bloc;

  RemoveFileView({required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: MARGIN_MEDIUM, right: MARGIN_MEDIUM),
      child: GestureDetector(
        onTap: () {
          bloc.onTapDeleteFile();
        },
        child: Icon(
          Icons.close,
          color: Colors.grey,
        ),
      ),
    );
  }
}

class AddNewPostFunctionItemView extends StatelessWidget {
  final IconData iconData;
  final Color color;
  final String label;

  AddNewPostFunctionItemView(
      {required this.iconData, required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        iconData,
        color: color,
        size: MARGIN_XLARGE,
      ),
      title: Transform.translate(
        offset: Offset(-10, 0),
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class AddNewPostTextFieldView extends StatelessWidget {
  Function(String) onChanged;
  final String prepopulateDescription;

  AddNewPostTextFieldView(
      {required this.onChanged, required this.prepopulateDescription});

  @override
  Widget build(BuildContext context) {
    final textEditingController = TextEditingController(text: prepopulateDescription);

    return TextField(
      maxLines: null,
      controller: textEditingController..selection = TextSelection.fromPosition(TextPosition(offset: textEditingController.text.length)),
      style: TextStyle(
        color: Colors.white,
      ),
      onChanged: (value) {
        onChanged(value);
      },
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: "What's on your mind?",
        hintStyle: TextStyle(
          color: CONTACT_PHONE_NUMBER_COLOR,
        ),
      ),
    );
  }
}

class PosterProfileSectionView extends StatelessWidget {
  const PosterProfileSectionView({
    Key? key,
    required this.avatarRadius,
    required this.profileImage,
    required this.name,
  }) : super(key: key);

  final double avatarRadius;
  final String profileImage;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: avatarRadius,
          backgroundImage: NetworkImage(
            (profileImage.isEmpty) ? "https://180dc.org/wp-content/uploads/2017/11/profile-placeholder.png" : profileImage,
          ),
        ),
        SizedBox(width: MARGIN_MEDIUM),
        Text(
          name,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: TEXT_REGULAR_2X,
          ),
        ),
      ],
    );
  }
}
