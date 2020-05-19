import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:inksy/components/footer-navigator/footer-navigator.dart';
import 'package:inksy/pages/create-font.dart';
import 'package:inksy/pages/home.dart';
import 'package:inksy/pages/search.dart';
import 'package:inksy/styles/colours.dart';

class MainContent extends StatefulWidget {
  @override
  State createState() {
    return _MainContentState();
  }
}

class _MainContentState extends State<MainContent> {
  int pageIndex = 0;

  List<Widget> pageList = <Widget>[
    Home(),
    Search(),
    CreateFont(),
  ];

  @override
  Widget build(context) {
    return MaterialApp(
      title: 'inkwall',
      theme: ThemeData(
        fontFamily: 'AvenirNext',
      ),
      home: Scaffold(
        backgroundColor: Colours.white,
        extendBody: true,
        body: SafeArea(
          child: PageTransitionSwitcher(
            transitionBuilder: (
              Widget child,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) {
              return FadeThroughTransition(
                animation: animation,
                secondaryAnimation: secondaryAnimation,
                child: child,
              );
            },
            child: pageList[pageIndex],
          ),
        ),
        bottomNavigationBar: FooterNavigator(
          height: 55.0,
          color: Colours.black,
          buttonBackgroundColor: Colours.black,
          backgroundColor: Colours.white,
          items: <Widget>[
            Icon(Icons.home, size: 30, color: Colours.white),
            Icon(Icons.search, size: 30, color: Colours.white),
            Icon(Icons.edit, size: 30, color: Colours.white),
          ],
          onTap: (index) {
            setState(() {
              pageIndex = index;
            });
          },
        ),
      ),
    );
  }
}
