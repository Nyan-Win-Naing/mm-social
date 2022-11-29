import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:mm_social/resources/dimens.dart';

class LoadingView extends StatelessWidget {

  final Indicator indicator;


  LoadingView({this.indicator = Indicator.audioEqualizer});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black26,
      child: Center(
        child: SizedBox(
          width: MARGIN_XXLARGE,
          height: MARGIN_XXLARGE,
          child: LoadingIndicator(
            indicatorType: indicator,
            colors: [Colors.white],
            strokeWidth: 2,
            backgroundColor: Colors.transparent,
            pathBackgroundColor: Colors.black,
          ),
        ),
      ),
    );
  }
}
