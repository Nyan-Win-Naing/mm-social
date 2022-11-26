import 'package:flutter/material.dart';
import 'package:mm_social/pages/qr_scanner_page.dart';
import 'package:mm_social/resources/colors.dart';
import 'package:mm_social/resources/dimens.dart';
import 'package:qr_flutter/qr_flutter.dart';

class InviteFriendPage extends StatelessWidget {

  final String qrCode;


  InviteFriendPage({required this.qrCode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SECONDARY_COLOR,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: PRIMARY_COLOR,
        centerTitle: true,
        elevation: 2.0,
        title: Text(
          "Invite Friends",
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      body: Container(
        child: Center(
          child: QRCodeSectionView(qrCode: qrCode),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QRScannerPage(scannerId: qrCode),
            ),
          );
        },
        backgroundColor: ADD_NEW_POST_BUTTON_COLOR,
        child: Icon(
          Icons.qr_code_scanner,
        ),
      ),
    );
  }
}

class QRCodeSectionView extends StatelessWidget {

  final String qrCode;


  QRCodeSectionView({required this.qrCode});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Invite More Friends with QR Code",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: TEXT_REGULAR_3X,
          ),
        ),
        SizedBox(height: MARGIN_MEDIUM_3),
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: MARGIN_MEDIUM_2, vertical: MARGIN_MEDIUM_2),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(MARGIN_MEDIUM_2),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 7), // changes position of shadow
              ),
            ],
          ),
          child: QrImage(
            data: qrCode,
            version: QrVersions.auto,
            size: 200.0,
          ),
        ),
      ],
    );
  }
}
