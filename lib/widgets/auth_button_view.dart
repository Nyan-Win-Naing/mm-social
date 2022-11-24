import 'package:flutter/material.dart';
import 'package:mm_social/pages/privacy_policy_page.dart';
import 'package:mm_social/resources/colors.dart';
import 'package:mm_social/resources/dimens.dart';

class AuthButtonView extends StatelessWidget {

  final String label;
  final Function onTap;


  AuthButtonView({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        padding:
        EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_3, vertical: 14),
        decoration: BoxDecoration(
          color: ADD_NEW_POST_BUTTON_COLOR,
          borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: TEXT_REGULAR_2X,
          ),
        ),
      ),
    );
  }
}