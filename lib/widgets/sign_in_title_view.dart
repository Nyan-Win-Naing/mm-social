import 'package:flutter/material.dart';
import 'package:mm_social/resources/dimens.dart';

class SignInTitleView extends StatelessWidget {
  final String title;


  SignInTitleView({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.white,
        fontSize: TEXT_REGULAR_3X,
      ),
    );
  }
}