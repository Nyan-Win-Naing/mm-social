import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mm_social/blocs/conversation_bloc.dart';
import 'package:mm_social/dummy/dummy_data.dart';
import 'package:mm_social/dummy/dummy_message_vo.dart';
import 'package:mm_social/resources/colors.dart';
import 'package:mm_social/resources/dimens.dart';
import 'package:mm_social/viewitems/conversation_function_item_view.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

const kAnimationDuration = Duration(milliseconds: 200);

class ConversationPage extends StatefulWidget {
  @override
  State<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  bool isFocus = false;
  bool isOpenedFunctionBar = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final avatarRadius = screenHeight / 35;

    return ChangeNotifierProvider(
      create: (context) => ConversationBloc(),
      child: Scaffold(
        backgroundColor: SECONDARY_COLOR,
        appBar: AppBar(
          backgroundColor: PRIMARY_COLOR,
          centerTitle: true,
          elevation: 2.0,
          leadingWidth: 100,
          title: Text(
            "Nuno Rocha",
          ),
          leading: Padding(
            padding: const EdgeInsets.only(left: MARGIN_MEDIUM),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_back_ios,
                  ),
                  Text(
                    "MMSocial",
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 0.7),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: MARGIN_MEDIUM_2),
              child: Icon(
                Icons.person_outline_rounded,
              ),
            ),
          ],
        ),
        body: Container(
          child: Consumer<ConversationBloc>(
            builder: (context, bloc, child) => Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.separated(
                        padding: EdgeInsets.symmetric(
                            vertical: MARGIN_MEDIUM_2,
                            horizontal: MARGIN_MEDIUM),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: messageList.length,
                        itemBuilder: (context, index) {
                          return (messageList[index].isMe == false)
                              ? OtherMessageView(
                                  avatarRadius: avatarRadius,
                                  dummyMessageVo: messageList[index],
                                )
                              : MyMessageView(
                                  dummyMessageVo: messageList[index]);
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(height: MARGIN_MEDIUM_2);
                        },
                      ),
                      isOpenedFunctionBar
                          ? SizedBox(height: MARGIN_XXLARGE * 5)
                          : SizedBox(height: MARGIN_XXLARGE + MARGIN_MEDIUM),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: AnimatedSize(
                    duration: kAnimationDuration,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ImageAndViewPreviewView(),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: MARGIN_MEDIUM,
                              vertical: MARGIN_MEDIUM),
                          decoration: BoxDecoration(
                            color: PRIMARY_COLOR,
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.3),
                                spreadRadius: 3,
                                blurRadius: 3,
                                offset: Offset(0, -1),
                              )
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MicroPhoneIconView(),
                              ChatTextFieldView(
                                onTapTextField: () {
                                  setState(() {
                                    isOpenedFunctionBar = false;
                                  });
                                },
                              ),
                              GestureDetector(
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  setState(() {
                                    isOpenedFunctionBar = !isOpenedFunctionBar;
                                  });
                                },
                                child: AddMediaButtonView(
                                    isOpenedFunctionBar: isOpenedFunctionBar),
                              ),
                            ],
                          ),
                        ),
                        isOpenedFunctionBar
                            ? Container(
                                color: SECONDARY_COLOR,
                                child: GridView.builder(
                                  itemCount: conversationFunctionList.length,
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    childAspectRatio: 1,
                                  ),
                                  itemBuilder: (context, index) {
                                    return Center(
                                      child: GestureDetector(
                                        onTap: () async {
                                          if (index == 0) {
                                            await _onChooseMedia(bloc);
                                          } else if(index == 1) {
                                            final ImagePicker _picker = ImagePicker();
                                            final XFile? image = await _picker.pickImage(source: ImageSource.camera);
                                            if(image != null) {
                                              bloc.onFileChosen(File(image.path));
                                            }
                                          }
                                        },
                                        child: ConversationFunctionItemView(
                                            functionVo:
                                                conversationFunctionList[
                                                    index]),
                                      ),
                                    );
                                  },
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onChooseMedia(ConversationBloc bloc) async {
    final FilePickerResult? result =
        await FilePicker.platform
            .pickFiles();
    if (result != null) {
      File file = File(
          result.files.single.path ??
              "");
      bloc.onFileChosen(file);
    }
  }
}

class ImageAndViewPreviewView extends StatefulWidget {
  @override
  State<ImageAndViewPreviewView> createState() =>
      _ImageAndViewPreviewViewState();
}

class _ImageAndViewPreviewViewState extends State<ImageAndViewPreviewView> {
  FlickManager? flickManager;

  @override
  void dispose() {
    flickManager?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ConversationBloc>(
      builder: (context, bloc, child) => (bloc.chosenImageFile != null ||
              bloc.chosenVideoFile != null)
          ? Container(
              color: SECONDARY_COLOR,
              padding: EdgeInsets.symmetric(
                  horizontal: MARGIN_MEDIUM, vertical: MARGIN_MEDIUM),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  (bloc.chosenImageFile != null)
                      ? Image.file(
                          bloc.chosenImageFile ?? File(""),
                          width: 150,
                          fit: BoxFit.cover,
                        )
                      : Builder(
                          builder: (context) {
                            flickManager = FlickManager(
                              videoPlayerController: VideoPlayerController.file(
                                bloc.chosenVideoFile ?? File(""),
                              ),
                              autoPlay: false,
                            );
                            return Container(
                              height: 120,
                              child: FlickVideoPlayer(
                                flickManager: flickManager!,
                              ),
                            );
                          },
                        ),
                  GestureDetector(
                    onTap: () {
                      bloc.onTapDeleteFile();
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            )
          : Container(),
    );
  }
}

class MyMessageView extends StatelessWidget {
  const MyMessageView({
    Key? key,
    required this.dummyMessageVo,
  }) : super(key: key);

  final DummyMessageVO dummyMessageVo;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 1.8 / 3),
          padding: EdgeInsets.symmetric(
              horizontal: MARGIN_CARD_MEDIUM_2, vertical: MARGIN_MEDIUM),
          decoration: BoxDecoration(
            color: ADD_NEW_POST_BUTTON_COLOR,
            borderRadius: BorderRadius.circular(MARGIN_MEDIUM_2),
          ),
          child: Text(
            dummyMessageVo.message ?? "",
            style: TextStyle(color: Colors.white, height: 1.3),
          ),
        ),
      ],
    );
  }
}

class OtherMessageView extends StatelessWidget {
  const OtherMessageView({
    Key? key,
    required this.avatarRadius,
    required this.dummyMessageVo,
  }) : super(key: key);

  final double avatarRadius;
  final DummyMessageVO dummyMessageVo;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CircleAvatar(
          radius: avatarRadius,
          backgroundImage: NetworkImage(
            "https://www.mnp.ca/-/media/foundation/integrations/personnel/2020/12/16/13/57/personnel-image-4483.jpg?h=800&w=600&hash=9D5E5FCBEE00EB562DCD8AC8FDA8433D",
          ),
        ),
        SizedBox(width: MARGIN_MEDIUM),
        Container(
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 1.8 / 3),
          padding: EdgeInsets.symmetric(
              horizontal: MARGIN_CARD_MEDIUM_2, vertical: MARGIN_MEDIUM),
          decoration: BoxDecoration(
            color: PRIMARY_COLOR,
            borderRadius: BorderRadius.circular(MARGIN_MEDIUM_2),
          ),
          child: Text(
            dummyMessageVo.message ?? "",
            style: TextStyle(
              color: Colors.white,
              height: 1.3,
            ),
          ),
        ),
      ],
    );
  }
}

class AddMediaButtonView extends StatelessWidget {
  final bool isOpenedFunctionBar;

  AddMediaButtonView({required this.isOpenedFunctionBar});

  @override
  Widget build(BuildContext context) {
    return Icon(
      isOpenedFunctionBar ? Icons.close : Icons.add,
      size: MARGIN_XLARGE,
      color: CONTACT_PHONE_NUMBER_COLOR,
    );
  }
}

class ChatTextFieldView extends StatelessWidget {
  const ChatTextFieldView({
    Key? key,
    required this.onTapTextField,
  }) : super(key: key);

  final Function onTapTextField;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 2.2 / 3,
      child: TextField(
        textInputAction: TextInputAction.send,
        maxLines: 5,
        minLines: 1,
        style: TextStyle(
          color: PRIMARY_COLOR,
        ),
        onTap: () {
          onTapTextField();
        },
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
              horizontal: MARGIN_MEDIUM, vertical: MARGIN_MEDIUM),
          suffixIcon: IconButton(
            onPressed: () {
              print(MediaQuery.of(context).viewInsets.bottom);
            },
            icon: const Icon(
              Icons.emoji_emotions,
              size: MARGIN_LARGE,
              color: Colors.grey,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: PRIMARY_COLOR,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: PRIMARY_COLOR,
            ),
          ),
          hintText: "Message...",
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}

class MicroPhoneIconView extends StatelessWidget {
  const MicroPhoneIconView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.mic_none_outlined,
      size: MARGIN_XLARGE,
      color: CONTACT_PHONE_NUMBER_COLOR,
    );
  }
}
