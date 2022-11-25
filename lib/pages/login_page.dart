import 'package:flutter/material.dart';
import 'package:mm_social/blocs/login_bloc.dart';
import 'package:mm_social/pages/bottom_nav_page.dart';
import 'package:mm_social/pages/chat_page.dart';
import 'package:mm_social/resources/colors.dart';
import 'package:mm_social/resources/dimens.dart';
import 'package:mm_social/widgets/auth_button_view.dart';
import 'package:mm_social/widgets/auth_form_view.dart';
import 'package:mm_social/widgets/loading_view.dart';
import 'package:mm_social/widgets/sign_in_title_view.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginBloc(),
      child: Selector<LoginBloc, bool>(
        selector: (context, bloc) => bloc.isLoading,
        builder: (context, isLoading, child) => Stack(
          children: [
            Scaffold(
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
                      child: Consumer<LoginBloc>(
                        builder: (context, bloc, child) => Padding(
                          padding: EdgeInsets.only(bottom: MARGIN_XXLARGE),
                          child: AuthButtonView(
                            label: "Accept and Continue",
                            onTap: () {
                              if (bloc.isButtonEnable) {
                                bloc.onTapLogin().then((value) {
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
                    ),
                  ],
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

class LogInFormSectionView extends StatelessWidget {
  const LogInFormSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginBloc>(
      builder: (context, bloc, child) => Column(
        children: [
          AuthFormView(
            label: "Email",
            hintText: "Enter email",
            isEmail: true,
            onChanged: (value) {
              bloc.onEmailChanged(value);
            },
          ),
          SizedBox(height: MARGIN_MEDIUM_3),
          AuthFormView(
            label: "Password",
            hintText: "Enter password",
            isPassword: true,
            onChanged: (value) {
              bloc.onPasswordChanged(value);
            },
          ),
        ],
      ),
    );
  }
}
