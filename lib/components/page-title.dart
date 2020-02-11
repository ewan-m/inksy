import 'package:flutter/material.dart';
import 'package:inksy/styles/colours.dart';

class PageTitle extends StatelessWidget {
  final String titleText;

  PageTitle(this.titleText);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      width: MediaQuery.of(context).size.width,
      child: Text(
        titleText,
        textAlign: TextAlign.left,
        style: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.w200,
          color: Colours.primary,
        ),
      ),
    );
  }
}
