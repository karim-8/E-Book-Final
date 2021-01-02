import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: GestureDetector(
            onHorizontalDragEnd: (DragEndDetails details) {
              print("horizontal drag");
            },
            onVerticalDragEnd: (DragEndDetails details) {
              print("vertical drag");
            },
            child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    "images/ray1.png",
                  ),
                ),
                Text(
                    " The Xcode Simulator is one of the tools used most widely by developers. Running and testing apps on the simulator has become part of every developer’s daily routine. Becoming familiar with various simulator options is vital for any developer. Did you know you can create and configure simulators from the command line as well? In this tutorial, you’ll learn:"
                    "What a simulator is"
                    "Insights into useful simulator options"
                    "To create and configure simulators from the command line"
                    "To stream and capture logs using the command line"
                    "To create a Bash script to automate launching the app on a simulator in different locales."
                    "Getting Started"
                    "Download the project by clicking the Download Materials button at the top or bottom of this page. Open the RayWonders project. Build and run.  "),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
