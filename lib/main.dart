import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gesturesfinalproject/alert_view_dialogue.dart';
import 'package:gesturesfinalproject/article_model.dart';
import 'package:flutter/services.dart';
import 'package:gesturesfinalproject/constants.dart';
import 'package:gesturesfinalproject/drawing_shape.dart';
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
          child: Container(
            color: _changeColor ? Colors.white : Colors.grey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
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
                  child: RotatedBox(
                    quarterTurns: _rotate,
                    child: Transform(
                      alignment: FractionalOffset.center,
                      transform:
                          Matrix4.diagonal3(Vector3(_scale, _scale, _scale)),
                      child: Container(
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
                GestureDetector(
                  onDoubleTap: () {
                    setState(() {
                      _changeColor = !_changeColor;
                    });
                  },
                  onLongPress: () {
                    AlertViewDialogue().createAlertDialogue(context);
                  },
                  onPanStart: (DragStartDetails details) {
                    _points.clear();
                  },
                  onPanUpdate: (DragUpdateDetails details) {
                    setState(() {
                      RenderBox object = context.findRenderObject();
                      Offset _localPosition =
                          object.globalToLocal(details.localPosition);
                      _points = new List.from(_points)..add(_localPosition);
                      print(_points.length);
                      print(_localPosition);
                    });
                  },
                  onPanEnd: (DragEndDetails details) => _points.add(null),
                  child: new CustomPaint(
                    painter: new DrawingShape(points: _points),
                    size: Size.infinite,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Container(
                        child: Column(
                          children: [
                            Center(
                              child: Text(
                                getTopicsList().topicHeader,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
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
                  //   ),
                ),
                GestureDetector(
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
                    color: _changeColor ? Colors.white : Colors.grey,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Image.asset(
                                "images/previous.png",
                                fit: BoxFit.fill,
                                height: 50,
                                width: 40,
                              ),
                            ),
                            Flexible(
                              child: Image.asset(
                                "images/forward-arrow.png",
                                fit: BoxFit.fill,
                                height: 50,
                                width: 50,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
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
              print(_points.length);
              setState(() {
                _points.clear();
              });
              print(_points.length);
            },
            backgroundColor: Colors.brown,
          ),
        ));
  }

  ArticleModel getTopicsList() {
    final items = ArticleModel.getData();
    final location = items[_pageNumber];
    return location;
  }
}
