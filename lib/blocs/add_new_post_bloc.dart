import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:mm_social/data/models/social_model.dart';
import 'package:mm_social/data/models/social_model_impl.dart';
import 'package:mm_social/data/vos/feed_vo.dart';

class AddNewPostBloc extends ChangeNotifier {
  /// State
  bool _disposed = false;
  String newPostDescription = "";
  bool isAddNewPostError = false;
  bool isLoading = false;
  /// File
  File? chosenImageFile;
  File? chosenVideoFile;
  bool isChosenFileIsImage = false;
  /// For Edit Mode
  bool isInEditMode = false;
  String postImageUrl = "";
  String postVideoUrl = "";
  String userName = "";
  String profilePicture = "";
  FeedVO? feedVo;

  /// Model
  final SocialModel _model = SocialModelImpl();

  AddNewPostBloc({int? feedId}) {
    if(feedId != null) {
      isInEditMode = true;
      _prepopulateDataForEditMode(feedId);
    } else {
      _prepopulateDataForAddNewPost();
    }
  }

  void onNewPostTextChanged(String newPostDescription) {
    this.newPostDescription = newPostDescription;
  }

  Future onTapAddNewPost() {
    if(newPostDescription.isEmpty) {
      isAddNewPostError = true;
      notifyListeners();
      return Future.error("Error");
    } else {
      isLoading = true;
      notifyListeners();
      isAddNewPostError = false;
      if(isInEditMode) {
        return _editFeedPost().then((value) {
          isLoading = false;
          notifyListeners();
        });
      } else {
        return _createNewFeedPost().then((value) {
          isLoading = false;
          notifyListeners();
        });
      }
    }
  }

  Future<dynamic> _editFeedPost() {
    feedVo?.description = newPostDescription;
    feedVo?.postImage = postImageUrl;
    feedVo?.postVideo = postVideoUrl;
    if(feedVo != null) {
      return _model.editPost(feedVo!, chosenImageFile, chosenVideoFile);
    } else {
      return Future.error("Error");
    }
  }

  Future<void> _createNewFeedPost() {
    return _model.addNewPost(newPostDescription, chosenImageFile, chosenVideoFile);
  }

  void onFileChosen(File file) {
    // chosenImageFile = file;
    // // print("Chosen File is =====> ${file.path}");
    // checkChosenFile();
    // notifyListeners();

    String fileType = file.path.split(".").last ?? "";
    // print("Chosen File Type is ======> $fileType");
    if(fileType == "jpg" || fileType == "png" || fileType == "gif" || fileType == "jpeg") {
      chosenImageFile = file;
      notifyListeners();
    } else {
      chosenVideoFile = file;
      notifyListeners();
    }
  }

  // void checkChosenFile() {
  //   String fileType = chosenImageFile?.path.split(".").last ?? "";
  //   // print("Chosen File Type is ======> $fileType");
  //   if(fileType == "jpg" || fileType == "png" || fileType == "gif" || fileType == "jpeg") {
  //     isChosenFileIsImage = true;
  //     notifyListeners();
  //   } else {
  //     isChosenFileIsImage = false;
  //     notifyListeners();
  //   }
  // }

  void onTapDeleteFile() {
    chosenImageFile = null;
    chosenVideoFile = null;
    postImageUrl = "";
    postVideoUrl = "";
    notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if(!_disposed) {
      super.notifyListeners();
    }
  }

  void _prepopulateDataForEditMode(int feedId) {
    _model.getFeedById(feedId).listen((feed) {
      userName = feed.userName ?? "";
      profilePicture = feed.profilePicture ?? "";
      newPostDescription = feed.description ?? "";
      postImageUrl = feed.postImage ?? "";
      postVideoUrl = feed.postVideo ?? "";
      feedVo = feed;
      notifyListeners();
    });
  }

  void _prepopulateDataForAddNewPost() {
    userName = "Nyan Win Naing";
    profilePicture = "https://i.pinimg.com/736x/8b/15/81/8b1581d6b4827e604c6f5fbe8defc3cb.jpg";
    notifyListeners();
  }
}