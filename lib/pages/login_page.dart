import 'package:flutter/material.dart';
import 'package:mm_social/pages/bottom_nav_page.dart';
import 'package:mm_social/pages/chat_page.dart';
import 'package:mm_social/resources/colors.dart';
import 'package:mm_social/resources/dimens.dart';
import 'package:mm_social/widgets/auth_button_view.dart';
import 'package:mm_social/widgets/auth_form_view.dart';
import 'package:mm_social/widgets/sign_in_title_view.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SECONDARY_COLOR,
      appBar: AppBar(
        backgroundColor: SECONDARY_COLOR,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.close,
          ),
        ),
      ),
      body: Container(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: MARGIN_LARGE),
                  SignInTitleView(title: "Log in via email address"),
                  SizedBox(height: MARGIN_XXLARGE),
                  LogInFormSectionView(),
                  SizedBox(height: MARGIN_XXLARGE * 3),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: MARGIN_XXLARGE),
                child: AuthButtonView(
                  label: "Accept and Continue",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BottomNavPage(),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LogInFormSectionView extends StatelessWidget {
  const LogInFormSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AuthFormView(
          label: "Email",
          hintText: "Enter email",
          isEmail: true,
        ),
        SizedBox(height: MARGIN_MEDIUM_3),
        AuthFormView(
          label: "Password",
          hintText: "Enter password",
          isPassword: true,
        ),
      ],
    );
  }
}
