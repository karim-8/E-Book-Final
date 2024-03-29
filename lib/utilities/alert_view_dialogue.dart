
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gesturesfinalproject/utilities/constants.dart';

class AlertViewDialogue {
  createAlertDialogue(BuildContext context, bool isLongPressed) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: !isLongPressed
              ? Column(
                  children: [
                    headerView(),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      Constants.articleUrl,
                      style: TextStyle(color: Colors.blue, fontSize: 12),
                    ),
                    itemsRowView(context,dialogContext),
                  ],
                )
              : singleAlertView(),
        );
      },
    );
  }

  Widget headerView() {
    return Row(
      children: [
        Container(
          child: Image.asset(
            Constants.rayLogo,
            width: 25,
            height: 25,
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          Constants.rayDomain,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ],
    );
  }
  Widget itemsRowView(BuildContext context, BuildContext dialogContext){
    return RawGestureDetector(
      gestures: {
        AllowMultipleGestureRecognizer:
        GestureRecognizerFactoryWithHandlers<
            AllowMultipleGestureRecognizer>(
              () => AllowMultipleGestureRecognizer(), //constructor
              (AllowMultipleGestureRecognizer instance) {
            //initializer
            instance.onTap = () {
              print("Row Tapped");
              Navigator.of(dialogContext).pop();
            };
          },
        )
      },
      child: Container(
        height: 50,
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            copyButtonView(context),
            visitButtonView(context),
          ],
        ),
      ),
    );
  }
  Widget copyButtonView(BuildContext context) {
    return RawGestureDetector(
      gestures: {
        AllowMultipleGestureRecognizer:
        GestureRecognizerFactoryWithHandlers<
            AllowMultipleGestureRecognizer>(
              () =>
              AllowMultipleGestureRecognizer(), //constructor
              (AllowMultipleGestureRecognizer instance) {
            //initializer
            instance.onTap = () {
              Clipboard.setData(new ClipboardData(
                  text: Constants.rayUrl));
              showToastMessage(context,Constants.copyMessage);
              print('Copy Button Tapped');
            };
          },
        )
      },
      child: Container(
          width: 70,height: 30,
          decoration: BoxDecoration(
              border: Border.all(width: 1,color: Colors.blue)
          ),
          child: Center(
            child: Text(
              Constants.copyButton,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                  fontSize: 12),
            ),
          )),
    );
  }
  Widget visitButtonView(BuildContext context) {
    return RawGestureDetector(
      behavior: HitTestBehavior.deferToChild,
      gestures: {
        AllowMultipleGestureRecognizer:
        GestureRecognizerFactoryWithHandlers<
            AllowMultipleGestureRecognizer>(
              () =>
              AllowMultipleGestureRecognizer(), //constructor
              (AllowMultipleGestureRecognizer instance) {
            //initializer
            instance.onTap = () {
              Clipboard.setData(new ClipboardData(
                  text: Constants.mainUrl));
              showToastMessage(context,Constants.visitMessage);
              print('visit Site Tapped');
            };
          },
        )
      },
      child: Container(
          width: 100,height: 30,
          decoration: BoxDecoration(
              border: Border.all(width: 1,color: Colors.blue)
          ),
          child: Center(
            child: Text(
              Constants.visit,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                  fontSize: 12),
            ),
          )),
    ) ;
  }
  Widget singleAlertView() {
    return Row(
      children: [
        Container(
          child: Image.asset(
            Constants.rayLogo,
            width: 25,
            height: 25,
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          Constants.rayDomain,
          style:
          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ],
    );
  }

  showToastMessage(BuildContext context,String message) async {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(message),duration:Duration(seconds: 2),
    ));
  }
}

class AllowMultipleGestureRecognizer extends TapGestureRecognizer {
  @override
  void rejectGesture(int pointer) {
    acceptGesture(pointer);
  }
}
