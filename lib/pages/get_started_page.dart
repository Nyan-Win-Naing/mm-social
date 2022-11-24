import 'package:flutter/material.dart';
import 'package:mm_social/pages/login_page.dart';
import 'package:mm_social/pages/sign_up_page.dart';
import 'package:mm_social/resources/colors.dart';
import 'package:mm_social/resources/dimens.dart';

class GetStartedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SECONDARY_COLOR,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: GetStartedImageAndTextSectionView(),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(
                left: MARGIN_MEDIUM,
                bottom: MARGIN_MEDIUM_2,
              ),
              child: GetStartedButtonView(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.only(
                right: MARGIN_MEDIUM,
                bottom: MARGIN_MEDIUM_2,
              ),
              child: GetStartedButtonView(
                isSignIn: false,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignUpPage(),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class GetStartedButtonView extends StatelessWidget {
  bool isSignIn;
  final Function onTap;

  GetStartedButtonView({required this.onTap, this.isSignIn = true});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: MARGIN_MEDIUM_3,
          vertical: MARGIN_MEDIUM_2,
        ),
        decoration: BoxDecoration(
          color: isSignIn ? ADD_NEW_POST_BUTTON_COLOR : Colors.white,
          borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
        ),
        child: Text(
          isSignIn ? "SIGN IN" : "SIGN UP",
          style: TextStyle(
            color: isSignIn ? Colors.white : PRIMARY_COLOR,
            fontSize: TEXT_REGULAR_2X,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class GetStartedImageAndTextSectionView extends StatelessWidget {
  const GetStartedImageAndTextSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(MARGIN_MEDIUM_2),
            child: Image.asset(
              "assets/get_started_image.png",
              width: double.infinity,
            ),
          ),
        ),
        SizedBox(height: MARGIN_MEDIUM_2),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM),
          child: Text(
            "Welcome from MM Social !",
            style: TextStyle(
                color: Colors.white,
                fontSize: TEXT_REGULAR_2X,
                fontWeight: FontWeight.w700),
          ),
        ),
        SizedBox(height: MARGIN_MEDIUM),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM),
          child: Text(
            "Enjoy With US And Connect Your Friends!",
            style: TextStyle(
              color: CONTACT_PHONE_NUMBER_COLOR,
              fontSize: TEXT_REGULAR_2X - 1,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
