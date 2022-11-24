import 'package:flutter/material.dart';
import 'package:mm_social/dummy/dummy_data.dart';
import 'package:mm_social/resources/dimens.dart';

class CountryItemView extends StatelessWidget {

  final String countryName;


  CountryItemView({required this.countryName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: MARGIN_CARD_MEDIUM_2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            countryName,
            style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 0.7),
            ),
          ),
          Text(
            dummyCountryMap[countryName] ?? "",
            style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 0.7),
            ),
          ),
        ],
      ),
    );
  }
}
