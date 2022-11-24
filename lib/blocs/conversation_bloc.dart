import 'dart:io';

import 'package:flutter/foundation.dart';

class ConversationBloc extends ChangeNotifier {
  /// States
  bool _disposed = false;
  File? chosenImageFile;
  File? chosenVideoFile;

  void onFileChosen(File file) {
    String fileType = file.path.split(".").last ?? "";
    print("File Path is ${file.path}");
    print("File Type is $fileType");
    if(fileType == "jpg" || fileType == "png" || fileType == "gif" || fileType == "jpeg") {
      chosenImageFile = file;
      notifyListeners();
    } else {
      chosenVideoFile = file;
      notifyListeners();
    }
  }

  void onTapDeleteFile() {
    chosenImageFile = null;
    chosenVideoFile = null;
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
}