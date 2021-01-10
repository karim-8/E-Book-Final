import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gesturesfinalproject/utilis/alert_view_dialogue.dart';
import 'package:gesturesfinalproject/models/article_model.dart';
import 'package:gesturesfinalproject/utilis/constants.dart';
import 'package:gesturesfinalproject/painting/screen_drawing.dart';
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
      child: RotatedBox(
        quarterTurns: _rotate,
        child: Transform(
          alignment: FractionalOffset.center,
          transform: Matrix4.diagonal3(Vector3(_scale, _scale, _scale)),
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
    );
  }

  Widget bookTopic() {
    return GestureDetector(
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
    return GestureDetector(
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
        height: MediaQuery.of(context).size.height,
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
      ),
    );
  }

  ArticleModel getTopicsList() {
    final items = ArticleModel.getData();
    final location = items[_pageNumber];
    return location;
  }
}

/*

 */
