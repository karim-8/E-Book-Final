/*
Copyright (c) 2021 Razeware LLC

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or
sell copies of the Software, and to permit persons to whom
the Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

Notwithstanding the foregoing, you may not use, copy, modify,
merge, publish, distribute, sublicense, create a derivative work,
and/or sell copies of the Software in any work that is designed,
intended, or marketed for pedagogical or instructional purposes
related to programming, coding, application development, or
information technology. Permission for such use, copying,
modification, merger, publication, distribution, sublicensing,
creation of derivative works, or sale is expressly withheld.

This project and source code may use libraries or frameworks
that are released under various Open-Source licenses. Use of
those libraries and frameworks are governed by their own
individual licenses.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE.
 */

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gesturesfinalproject/models/article_model.dart';
import 'package:gesturesfinalproject/painting/screen_drawing.dart';
import 'package:gesturesfinalproject/utilities/alert_view_dialogue.dart';
import 'package:gesturesfinalproject/utilities/constants.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: Constants.appTitle),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _pageNumber = 0;
  var _changeColor = true;
  var _scale = 1.0;
  var _previousScale = 1.0;
  var _rotate = 0;
  List<Offset> _points = <Offset>[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: _changeColor ? Colors.brown : Colors.grey,
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(
                Icons.rotate_left,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  _rotate < 3 ? _rotate++ : _rotate = 0;
                });
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height,
            color: _changeColor ? Colors.white : Colors.grey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                coverImageView(),
                bookTopic(),
                changePageView(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: new Container(
          color: _changeColor ? Colors.white : Colors.grey,
          height: 40.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${_pageNumber + 1}",
                style: TextStyle(color: Colors.black, fontSize: 18),
              )
            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: new FloatingActionButton(
            child: new Icon(Icons.clear),
            onPressed: () {
              setState(() {
                _points.clear();
              });
            },
            backgroundColor: Colors.brown,
          ),
        ));
  }

  Widget coverImageView() {
    return GestureDetector(
      onScaleStart: (ScaleStartDetails details) {
        _previousScale = _scale;
        setState(() {});
      },
      onScaleUpdate: (ScaleUpdateDetails details) {
        _scale = _previousScale * details.scale;
        setState(() {});
      },
      onScaleEnd: (ScaleEndDetails details) {
        _scale = 1.0;
        setState(() {});
      },
      child: Container(
        height: 200,
        child: RotatedBox(
          quarterTurns: _rotate,
          child: Transform(
            alignment: FractionalOffset.center,
            transform: Matrix4.diagonal3(Vector3(_scale, _scale, _scale)),
            child: Container(
              height: 200,
              color: Colors.black,
              child: Image.asset(
                getTopicsList().image,
                fit: BoxFit.fill,
                height: 200,
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget bookTopic() {
    return GestureDetector(
      onTap: () {
        AlertViewDialogue().createAlertDialogue(context, false);
      },

      onDoubleTap: () {
        setState(() {
          _changeColor = !_changeColor;
        });
      },
      onLongPress: () {
        AlertViewDialogue().createAlertDialogue(context, true);
      },
      onPanStart: (DragStartDetails details) {
        _points.clear();
      },
      onPanUpdate: (DragUpdateDetails details) {
        setState(() {
          RenderBox object = context.findRenderObject();
          Offset _localPosition = object.globalToLocal(details.localPosition);
          _points = new List.from(_points)..add(_localPosition);
        });
      },
      onPanEnd: (DragEndDetails details) => _points.add(null),
      child: ClipRect(
        child: new CustomPaint(
          painter: new ScreenDrawing(points: _points),
          size: Size.infinite,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Container(
              child: Column(
                children: [
                  Center(
                    child: Text(
                      getTopicsList().topicHeader,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    child: Text(
                      getTopicsList().topicBody,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      //   ),
    );
  }

  Widget changePageView() {
    return Expanded(
      flex: 2,
      child: GestureDetector(
          onDoubleTap: () {
            setState(() {
              _changeColor = !_changeColor;
            });
          },
          onHorizontalDragEnd: (DragEndDetails details) {
            setState(() {
              if (details.primaryVelocity > 1) {
                _pageNumber <= 4 && _pageNumber != 0
                    ? _pageNumber--
                    : _pageNumber = 4;
              } else {
                _pageNumber >= 0 && _pageNumber != 4
                    ? _pageNumber++
                    : _pageNumber = 0;
              }
            });
          },
          onVerticalDragEnd: (DragEndDetails details) {
            setState(() {
              if (details.primaryVelocity > 1) {
                _pageNumber <= 4 && _pageNumber != 0
                    ? _pageNumber--
                    : _pageNumber = 4;
              } else {
                _pageNumber >= 0 && _pageNumber != 4
                    ? _pageNumber++
                    : _pageNumber = 0;
              }
            });
          },
          child: Container(
            //height: 200,
            color: _changeColor ? Colors.white : Colors.grey,
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      "images/previous-arrow.png",
                      fit: BoxFit.fill,
                      height: 50,
                      width: 40,
                    ),
                    Image.asset(
                      "images/forward-arrow.png",
                      fit: BoxFit.fill,
                      height: 50,
                      width: 50,
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }

  ArticleModel getTopicsList() {
    final items = ArticleModel.getData();
    final location = items[_pageNumber];
    return location;
  }
}
