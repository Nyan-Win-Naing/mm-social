import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mm_social/blocs/sign_up_bloc.dart';
import 'package:mm_social/pages/country_choose_page.dart';
import 'package:mm_social/pages/privacy_policy_page.dart';
import 'package:mm_social/resources/colors.dart';
import 'package:mm_social/resources/dimens.dart';
import 'package:mm_social/widgets/auth_button_view.dart';
import 'package:mm_social/widgets/auth_form_view.dart';
import 'package:mm_social/widgets/sign_in_title_view.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignUpBloc(),
      child: Scaffold(
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: MARGIN_LARGE),
                SignInTitleView(title: "Sign up by email address"),
                SizedBox(height: MARGIN_LARGE),
                RegisterSectionView(),
                SizedBox(height: MARGIN_XXLARGE),
                AcceptTermAndPolicySectionView(),
                SizedBox(height: MARGIN_LARGE),
                AuthButtonView(
                  label: "Accept and Continue",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PrivacyPolicyPage(),
                      ),
                    ).then((value) => print("Value is $value"));
                  },
                ),
                SizedBox(height: MARGIN_XXLARGE * 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AcceptTermAndPolicySectionView extends StatefulWidget {
  @override
  State<AcceptTermAndPolicySectionView> createState() =>
      _AcceptTermAndPolicySectionViewState();
}

class _AcceptTermAndPolicySectionViewState
    extends State<AcceptTermAndPolicySectionView> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: MARGIN_XLARGE),
          child: Row(
            children: [
              Theme(
                data: ThemeData(
                  unselectedWidgetColor: Colors.grey,
                ),
                child: Checkbox(
                  value: isChecked,
                  visualDensity: VisualDensity(horizontal: -4),
                  shape: CircleBorder(),
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value!;
                    });
                  },
                ),
              ),
              Flexible(
                child: Text(
                  "I have read and accept the <<MM Social - Terms of Service>>",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: TEXT_SMALL,
                    height: 1.3,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: MARGIN_LARGE),
          child: Text(
            "The information collected on this page is only used for account registeration.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              fontSize: TEXT_SMALL,
              height: 1.3,
            ),
          ),
        ),
      ],
    );
  }
}

class RegisterSectionView extends StatelessWidget {
  const RegisterSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfilePickerView(),
        SizedBox(height: MARGIN_XLARGE * 2),
        AuthFormView(
          label: "Name",
          hintText: "John Appleseed",
        ),
        SizedBox(height: MARGIN_MEDIUM),
        CountryAndRegionChooseView(
          onChooseCountry: () {

          },
        ),
        SizedBox(height: MARGIN_MEDIUM_3),
        AuthFormView(
          label: "Phone",
          hintText: "Enter mobile number",
          isNumber: true,
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

class CountryAndRegionChooseView extends StatefulWidget {

  final Function onChooseCountry;


  CountryAndRegionChooseView({required this.onChooseCountry});

  @override
  State<CountryAndRegionChooseView> createState() => _CountryAndRegionChooseViewState();
}

class _CountryAndRegionChooseViewState extends State<CountryAndRegionChooseView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 100,
                child: Text(
                  "Country/\nRegion",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: TEXT_REGULAR_2X,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  widget.onChooseCountry();
                },
                child: Text(
                  "United States (+1)",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: TEXT_REGULAR_2X,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: MARGIN_CARD_MEDIUM_2),
          Container(
            height: 1,
            color: Color.fromRGBO(255, 255, 255, 0.5),
          ),
        ],
      ),
    );
  }
}

class ProfilePickerView extends StatelessWidget {
  const ProfilePickerView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpBloc>(
      builder: (context, bloc, child) {
        print("Consumer Sign Up Bloc is ${bloc.hashCode}");
        return (bloc.chosenImageFile == null)
            ? GestureDetector(
                onTap: () {
                  SignUpBloc bloc =
                      Provider.of<SignUpBloc>(context, listen: false);
                  // print("Sign Up Bloc is ${bloc.hashCode}");
                  showBottomSheet(context, bloc);
                },
                child: Container(
                  width: 80,
                  height: 80,
                  color: Color.fromRGBO(221, 221, 221, 1.0),
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                  ),
                ),
              )
            : Container(
                width: 80,
                height: 80,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.file(
                        bloc.chosenImageFile ?? File(""),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {
                          bloc.onTapDeleteImage();
                        },
                        child: Icon(
                          Icons.close,
                          color: CONTACT_PHONE_NUMBER_COLOR,
                        ),
                      ),
                    ),
                  ],
                ),
              );
      },
    );
  }

  void showBottomSheet(BuildContext context, SignUpBloc bloc) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(MARGIN_MEDIUM_2),
          topRight: Radius.circular(MARGIN_MEDIUM_2),
        ),
      ),
      backgroundColor: PRIMARY_COLOR,
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () async {
                await pickImage(bloc, isFromGallery: false);
              },
              child: ListTile(
                dense: true,
                contentPadding: EdgeInsets.only(
                    top: MARGIN_MEDIUM,
                    bottom: MARGIN_MEDIUM,
                    left: MARGIN_MEDIUM_2),
                title: Text(
                  "Choose from Camera",
                  style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 0.7),
                    fontSize: TEXT_REGULAR_2X,
                  ),
                ),
              ),
            ),
            Divider(color: CONTACT_PHONE_NUMBER_COLOR, height: 0),
            GestureDetector(
              onTap: () async {
                await pickImage(bloc);
              },
              child: ListTile(
                dense: true,
                contentPadding: EdgeInsets.only(
                    top: MARGIN_MEDIUM,
                    bottom: MARGIN_MEDIUM,
                    left: MARGIN_MEDIUM_2),
                title: Text(
                  "Choose from Gallery",
                  style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 0.7),
                    fontSize: TEXT_REGULAR_2X,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> pickImage(SignUpBloc bloc, {bool isFromGallery = true}) async {
    final ImagePicker _picker = ImagePicker();

    /// Pick an Image
    final XFile? image = await _picker.pickImage(
        source: isFromGallery ? ImageSource.gallery : ImageSource.camera);
    if (image != null) {
      bloc.onImageChosen(File(image.path));
    }
  }
}
