import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:mm_social/data/models/authentication_model.dart';
import 'package:mm_social/data/models/authentication_model_impl.dart';
import 'package:mm_social/data/models/social_model.dart';
import 'package:mm_social/data/models/social_model_impl.dart';
import 'package:mm_social/data/vos/message_vo.dart';
import 'package:mm_social/data/vos/user_vo.dart';
import 'package:mm_social/dummy/dummy_data.dart';

class ConversationBloc extends ChangeNotifier {
  /// States
  bool _disposed = false;
  File? chosenImageFile;
  File? chosenVideoFile;
  String message = "";
  UserVO? friendUser;
  UserVO? loggedInUser;
  List<MessageVO>? messages;
  bool isLoading = false;

  /// Model
  SocialModel _model = SocialModelImpl();
  AuthenticationModel _mAuthenticationModel = AuthenticationModelImpl();

  ConversationBloc({required UserVO? friendUser}) {
    this.friendUser = friendUser;
    loggedInUser = _mAuthenticationModel.getLoggedInUser();
    _model.getMessages(this.friendUser?.id ?? "").listen((messageList) {
      messages = messageList;
      notifyListeners();
    });
  }

  void _showLoading() {
    isLoading = true;
    notifyListeners();
  }

  void _hideLoading() {
    isLoading = false;
    notifyListeners();
  }

  void onFileChosen(File file) {
    String fileType = file.path.split(".").last ?? "";
    print("File Path is ${file.path}");
    print("File Type is $fileType");
    if (fileType == "jpg" ||
        fileType == "png" ||
        fileType == "gif" ||
        fileType == "jpeg") {
      chosenImageFile = file;
      notifyListeners();
    } else {
      chosenVideoFile = file;
      notifyListeners();
    }
  }

  void onMessageChanged(String text) {
    message = text;
  }

  void onTapDeleteFile() {
    chosenImageFile = null;
    chosenVideoFile = null;
    notifyListeners();
  }

  Future<void> onTapSubmit() {
    _showLoading();
    String myMessage = message;
    File? myImage = chosenImageFile;
    File? myVideo = chosenVideoFile;
    message = "";
    chosenImageFile = null;
    chosenVideoFile = null;
    notifyListeners();
    return _model.sendMessage(
      friendId: friendUser?.id ?? "",
      message: myMessage,
      imageFile: myImage,
      videoFile: myVideo,
    ).whenComplete(() {
      _hideLoading();
    });
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }
}
