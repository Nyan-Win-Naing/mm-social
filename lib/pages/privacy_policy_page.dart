import 'package:flutter/material.dart';
import 'package:mm_social/dummy/dummy_message_vo.dart';
import 'package:mm_social/pages/email_form_page.dart';
import 'package:mm_social/resources/colors.dart';
import 'package:mm_social/resources/dimens.dart';
import 'package:mm_social/resources/strings.dart';
import 'package:mm_social/widgets/auth_button_view.dart';

class PrivacyPolicyPage extends StatefulWidget {
  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  bool isChecked = false;

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
            Navigator.pop(context, DummyMessageVO(message: "Wow........", isMe: false));
          },
          child: Icon(
            Icons.close,
          ),
        ),
        title: Text(
          "Privacy & Policy",
        ),
      ),
      body: Container(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: MARGIN_MEDIUM_2,
                    left: MARGIN_MEDIUM,
                    right: MARGIN_MEDIUM,
                    bottom: MARGIN_XXLARGE * 3),
                child: Text(
                  PRIVACY_POLICY,
                  style: TextStyle(
                    color: CONTACT_PHONE_NUMBER_COLOR,
                    fontSize: TEXT_REGULAR,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.only(
                    left: MARGIN_XXLARGE,
                    right: MARGIN_XXLARGE,
                    top: MARGIN_MEDIUM,
                    bottom: MARGIN_MEDIUM_2),
                decoration: BoxDecoration(
                  color: PRIMARY_COLOR,
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.1),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: Offset(0, -3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
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
                            "Accept the Privacy & Policy of this application",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: CONTACT_PHONE_NUMBER_COLOR),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MARGIN_MEDIUM),
                    AuthButtonView(
                      label: "Continue",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EmailFormPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
