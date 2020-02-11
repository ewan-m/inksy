import 'package:flutter/material.dart';
import 'package:inksy/components/page-title.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(children: [PageTitle("Home")]),
    );
  }
}
