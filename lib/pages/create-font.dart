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
  Set<String> visitedLetters = Set.of([Alphabet.letters.first]);
  String currentLetter = Alphabet.letters.first;
  Offset bottomLeft;
  Offset topRight;

  bool isWithinBox(Offset drawPoint) {
    return drawPoint.dx > 0 &&
        drawPoint.dy > 0 &&
        drawPoint.dx < MediaQuery.of(context).size.width - 40.0 &&
        drawPoint.dy < MediaQuery.of(context).size.width * 1.1;
  }

  void updateMinMaxYValues(Offset newPoint) {
    if (bottomLeft == null && topRight == null) {
      bottomLeft = newPoint;
      topRight = newPoint;
    } else {
      if (newPoint.dy > topRight.dy) {
        topRight = Offset(topRight.dx, newPoint.dy);
      }
      if (newPoint.dx > topRight.dx) {
        topRight = Offset(newPoint.dx, topRight.dy);
      }
      if (newPoint.dx < bottomLeft.dx) {
        bottomLeft = Offset(newPoint.dx, bottomLeft.dy);
      }
      if (newPoint.dy < bottomLeft.dy) {
        bottomLeft = Offset(bottomLeft.dx, newPoint.dy);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Container sketchArea = Container(
      alignment: Alignment.topLeft,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width * 1.1,
      decoration: BoxDecoration(
        color: Colours.backgroundHighlight,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: CustomPaint(
        painter: LetterDrawer(
          bottomLeft: bottomLeft,
          topRight: topRight,
          points: letters[currentLetter],
          currentLetter: currentLetter,
        ),
      ),
    );

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          PageTitle("Create Font"),
          Container(
            margin: EdgeInsets.all(20.0),
            child: Column(
              children: [
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
                        visitedLetters.add(currentLetter);
                        letters.update(
                          currentLetter,
                          (points) =>
                              List.from(points)..add(details.localPosition),
                        );
                      });
                    }
                  },
                  onPanEnd: (DragEndDetails details) {
                    letters.update(
                      currentLetter,
                      (points) => List.from(points)..add(null),
                    );
                  },
                  child: sketchArea,
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
