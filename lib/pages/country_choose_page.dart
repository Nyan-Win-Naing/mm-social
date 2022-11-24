import 'package:flutter/material.dart';
import 'package:mm_social/dummy/dummy_data.dart';
import 'package:mm_social/resources/colors.dart';
import 'package:mm_social/resources/dimens.dart';
import 'package:mm_social/viewitems/country_item_view.dart';

class CountryChoosePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> countryNameList = dummyCountryMap.keys.toList();

    return Scaffold(
      backgroundColor: SECONDARY_COLOR,
      appBar: AppBar(
        backgroundColor: SECONDARY_COLOR,
        centerTitle: true,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.close,
          ),
        ),
        title: Text(
          "Choose Country",
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: ListView.separated(
            padding: EdgeInsets.symmetric(
                horizontal: MARGIN_MEDIUM, vertical: MARGIN_MEDIUM),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: countryNameList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pop(context, countryNameList[index]);
                },
                child: CountryItemView(countryName: countryNameList[index]),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Container(
                color: Color.fromRGBO(0, 0, 0, 0.3),
                height: 1,
              );
            },
          ),
        ),
      ),
    );
  }
}
