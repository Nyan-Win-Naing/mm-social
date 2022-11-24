import 'package:flutter/material.dart';
import 'package:mm_social/resources/colors.dart';
import 'package:mm_social/resources/dimens.dart';
import 'package:mm_social/widgets/auth_button_view.dart';
import 'package:mm_social/widgets/auth_form_view.dart';

class EmailFormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SECONDARY_COLOR,
      appBar: AppBar(
        backgroundColor: SECONDARY_COLOR,
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.close,
          ),
        ),
        title: Text(
          "Email Address",
        ),
      ),
      body: Container(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: MARGIN_XLARGE * 2),
              child: AuthFormView(
                label: "Email",
                hintText: "Enter email",
                isEmail: true,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: MARGIN_XXLARGE),
                child: AuthButtonView(
                  label: "Sign Up",
                  onTap: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
