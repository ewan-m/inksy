import 'package:flutter/material.dart';
import 'package:inksy/components/page-title.dart';
import 'package:inksy/pages/alphabet.dart';
import 'package:inksy/pages/letter-button.dart';
import 'package:inksy/pages/letter-drawer.dart';
import 'package:inksy/styles/colours.dart';

class CreateFont extends StatefulWidget {
  @override
  CreateFontState createState() => CreateFontState();
}

class CreateFontState extends State<CreateFont> with TickerProviderStateMixin {
  Map<String, List<Offset>> letters = Map.fromIterable(
    Alphabet.letters,
    key: (item) => item,
    value: (item) => <Offset>[],
  );
  Map<String, List<Offset>> limits = Map.fromIterable(
    Alphabet.letters,
    key: (item) => item,
    value: (item) => <Offset>[],
  );
  Set<String> visitedLetters = Set.of([Alphabet.letters.first]);
  String currentLetter = Alphabet.letters.first;
  double thickness = 20.0;
  bool showGuides = true;

  bool isWithinBox(Offset drawPoint) {
    return drawPoint.dx > 0 &&
        drawPoint.dy > 0 &&
        drawPoint.dx < MediaQuery.of(context).size.width - 40.0 &&
        drawPoint.dy < MediaQuery.of(context).size.width * 1.0;
  }

  void updateMinMaxYValues(Offset newPoint) {
    if (limits[currentLetter].isEmpty) {
      limits[currentLetter].add(newPoint);
      limits[currentLetter].add(newPoint);
    } else {
      if (newPoint.dy > limits[currentLetter][1].dy) {
        limits[currentLetter][1] =
            Offset(limits[currentLetter][1].dx, newPoint.dy);
      }
      if (newPoint.dx > limits[currentLetter][1].dx) {
        limits[currentLetter][1] =
            Offset(newPoint.dx, limits[currentLetter][1].dy);
      }
      if (newPoint.dx < limits[currentLetter][0].dx) {
        limits[currentLetter][0] =
            Offset(newPoint.dx, limits[currentLetter][0].dy);
      }
      if (newPoint.dy < limits[currentLetter][0].dy) {
        limits[currentLetter][0] =
            Offset(limits[currentLetter][0].dx, newPoint.dy);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colours.white,
      child: Column(
        children: [
          PageTitle(
            "Create your font",
            "Draw each letter to create your own handwritten font",
          ),
          Container(
            margin: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colours.black,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10.0)),
            child: Column(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Slider(
                            min: 15.0,
                            max: 45.0,
                            value: thickness,
                            onChanged: (double newValue) {
                              setState(() {
                                thickness = newValue;
                              });
                            },
                            activeColor: Colours.secondary,
                            inactiveColor: Colours.black,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              showGuides = !showGuides;
                            });
                          },
                          icon: Icon(
                            showGuides
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colours.black,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              letters.update(currentLetter, (points) => []);
                              limits[currentLetter] = [];
                            });
                          },
                          icon: Icon(Icons.undo, color: Colours.black),
                        ),
                      ],
                    )),
                GestureDetector(
                  onPanUpdate: (DragUpdateDetails details) {
                    if (isWithinBox(details.localPosition)) {
                      setState(() {
                        updateMinMaxYValues(details.localPosition);
                        letters.update(
                          currentLetter,
                          (points) =>
                              List.from(points)..add(details.localPosition),
                        );
                      });
                    }
                  },
                  onPanStart: (DragStartDetails details) {
                    if (isWithinBox(details.localPosition)) {
                      setState(() {
                        updateMinMaxYValues(details.localPosition);
                        letters.update(
                          currentLetter,
                          (points) =>
                              List.from(points)..add(details.localPosition),
                        );
                      });
                    }
                  },
                  onPanEnd: (DragEndDetails details) {
                    setState(() {
                      visitedLetters.add(currentLetter);
                      letters.update(
                        currentLetter,
                        (points) => List.from(points)..add(null),
                      );
                    });
                  },
                  child: Container(
                    alignment: Alignment.topLeft,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width * 1.0,
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Colours.black,
                          width: 1,
                        ),
                      ),
                    ),
                    child: CustomPaint(
                      painter: LetterDrawer(
                        limits: limits,
                        points: letters[currentLetter],
                        currentLetter: currentLetter,
                        thickness: thickness,
                        showGuideLines: showGuides,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: Alphabet.letters
                  .map(
                    (e) => LetterButton(
                        letter: e,
                        visited: visitedLetters.contains(e),
                        current: e == currentLetter,
                        onTap: (newLetter) {
                          setState(() {
                            currentLetter = newLetter;
                          });
                        }),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
