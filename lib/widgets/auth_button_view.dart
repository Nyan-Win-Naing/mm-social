import 'package:flutter/material.dart';
import 'package:mm_social/pages/privacy_policy_page.dart';
import 'package:mm_social/resources/colors.dart';
import 'package:mm_social/resources/dimens.dart';

class AuthButtonView extends StatelessWidget {

  final String label;
  final Function onTap;
  final bool isButtonEnable;


  AuthButtonView({required this.label, required this.onTap, required this.isButtonEnable});

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
          color: isButtonEnable ? ADD_NEW_POST_BUTTON_COLOR : Color.fromRGBO(43, 43, 43, 1.0),
          borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isButtonEnable ? Colors.white : Color.fromRGBO(85, 85, 85, 1.0),
            fontSize: TEXT_REGULAR_2X,
          ),
        ),
      ),
    );
  }
}