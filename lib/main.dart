import 'package:flutter/material.dart';
import 'package:gesturesfinalproject/alert_view_dialogue.dart';
import 'package:gesturesfinalproject/article_model.dart';
import 'package:flutter/services.dart';
import 'package:gesturesfinalproject/constants.dart';

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
  var pageNumber = 0;
  var changeColor = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: changeColor ? Colors.brown : Colors.grey,
        centerTitle: true,
        leading: Icon(Icons.menu),
      ),
      body: GestureDetector(
        onHorizontalDragEnd: (DragEndDetails details) {
          setState(() {
            if (details.primaryVelocity > 1) {
              pageNumber <= 4 && pageNumber != 0
                  ? pageNumber--
                  : pageNumber = 4;
            } else {
              pageNumber >= 0 && pageNumber != 4
                  ? pageNumber++
                  : pageNumber = 0;
            }
          });
        },
        onVerticalDragEnd: (DragEndDetails details) {
          setState(() {
            if (details.primaryVelocity > 1) {
              pageNumber <= 4 && pageNumber != 0
                  ? pageNumber--
                  : pageNumber = 4;
            } else {
              pageNumber >= 0 && pageNumber != 4
                  ? pageNumber++
                  : pageNumber = 0;
            }
          });
        },
        onDoubleTap: () {
          setState(() {
            changeColor = !changeColor;
          });
        },
        onLongPress: () {
          AlertViewDialogue().createAlertDialogue(context);
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              color: changeColor ? Colors.white : Colors.grey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    color: Colors.black,
                    width: double.infinity,
                    child: Image.asset(
                      getTopicsList().image,
                      fit: BoxFit.fill,
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
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
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: new Container(
        color: changeColor ? Colors.white : Colors.grey,
        height: 40.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${pageNumber + 1}",
              style: TextStyle(color: Colors.black, fontSize: 18),
            )
          ],
        ),
      ),
    );
  }

  ArticleModel getTopicsList() {
    final items = ArticleModel.getData();
    final location = items[pageNumber];
    return location;
  }
}
