import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mm_social/resources/colors.dart';
import 'package:mm_social/resources/dimens.dart';

class AuthFormView extends StatelessWidget {
  String label;
  String hintText;
  bool isNumber;
  bool isPassword;
  final bool isEmail;
  final Function(String) onChanged;


  AuthFormView({
    required this.label,
    required this.hintText,
    this.isNumber = false,
    this.isPassword = false,
    this.isEmail = false,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM),
      child: TextField(
        style: TextStyle(
          color: Color.fromRGBO(255, 255, 255, 0.7),
          fontSize: TEXT_REGULAR,
        ),
        onChanged: (value) {
          onChanged(value);
        },
        keyboardType: isNumber ? TextInputType.phone : isEmail ? TextInputType.emailAddress : null,
        obscureText: isPassword,
        decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(255, 255, 255, 0.3)),
            ),
            contentPadding: EdgeInsets.only(bottom: MARGIN_MEDIUM_2 - 1),
            isDense: true,
            prefixIcon: Padding(
              padding: const EdgeInsets.only(bottom: MARGIN_MEDIUM_2 - 1),
              child: Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: TEXT_REGULAR_2X,
                ),
              ),
            ),
            prefixIconConstraints: BoxConstraints(minWidth: 100, minHeight: 0),
            hintText: hintText,
            hintStyle: TextStyle(
              color: TEXT_FIELD_HINT_TEXT_COLOR,
              fontSize: TEXT_REGULAR_2X,
            )),
      ),
    );
  }
}
