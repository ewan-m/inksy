import 'package:flutter/material.dart';
import 'package:inksy/components/page-title.dart';
import 'package:inksy/styles/colours.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colours.white,
      child: Column(children: [PageTitle("Home", "It's a home")]),
    );
  }
}
