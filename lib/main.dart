import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gesturesfinalproject/article_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Raywenderlich E-Book'),
    );
  }
}

// ignore: must_be_immutable
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  //List<Article> articlesList = [];

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.grey,
        centerTitle: true,
        leading: Icon(Icons.menu),
      ),
      body: SingleChildScrollView(
        child: GestureDetector(
          onHorizontalDragEnd: (DragEndDetails details) {
            print("horizontal drag");
          },
          onVerticalDragEnd: (DragEndDetails details) {
            print("vertical drag $details");
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  getTopicsList().image,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  children: [
                    //Header - Body --> Texts
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
                    Text(
                      getTopicsList().topicBody,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ArticleModel getTopicsList() {
    final items = ArticleModel.getData();
    final loc = items[4];
    return loc;
  }
}
