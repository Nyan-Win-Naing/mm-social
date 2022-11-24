import 'dart:io';

import 'package:flutter/foundation.dart';

class SignUpBloc extends ChangeNotifier {
  /// States
  bool _disposed = false;
  File? chosenImageFile;

  void onImageChosen(File imageFile) {
    print("OnImageChosen Block works..........");
    chosenImageFile = imageFile;
    notifyListeners();
  }

  void onTapDeleteImage() {
    chosenImageFile = null;
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