import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mm_social/blocs/email_form_bloc.dart';
import 'package:mm_social/pages/bottom_nav_page.dart';
import 'package:mm_social/pages/chat_page.dart';
import 'package:mm_social/resources/colors.dart';
import 'package:mm_social/resources/dimens.dart';
import 'package:mm_social/widgets/auth_button_view.dart';
import 'package:mm_social/widgets/auth_form_view.dart';
import 'package:mm_social/widgets/loading_view.dart';
import 'package:provider/provider.dart';

class EmailFormPage extends StatelessWidget {
  final String username;
  final String phoneNumber;
  final String password;
  final File? profileImage;

  EmailFormPage({
    required this.username,
    required this.phoneNumber,
    required this.password,
    required this.profileImage,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EmailFormBloc(
        username: username,
        phoneNumber: phoneNumber,
        password: password,
        profileImage: profileImage,
      ),
      child: Selector<EmailFormBloc, bool>(
        selector: (context, bloc) => bloc.isLoading,
        builder: (context, isLoading, child) => Stack(
          children: [
            Scaffold(
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
                child: Consumer<EmailFormBloc>(
                  builder: (context, bloc, child) => Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: MARGIN_XLARGE * 2),
                        child: AuthFormView(
                          label: "Email",
                          hintText: "Enter email",
                          isEmail: true,
                          onChanged: (value) {
                            bloc.onEmailChanged(value);
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(bottom: MARGIN_XXLARGE),
                          child: AuthButtonView(
                            label: "Sign Up",
                            onTap: () {
                              if (bloc.isButtonEnable) {
                                bloc.onTapRegister().then((value) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BottomNavPage(),
                                    ),
                                  );
                                }).catchError((error) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(error.toString())));
                                });
                              }
                            },
                            isButtonEnable: bloc.isButtonEnable,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
              visible: isLoading,
              child: LoadingView(),
            ),
          ],
        ),
      ),
    );
  }
}
