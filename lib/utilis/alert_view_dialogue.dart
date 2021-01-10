import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gesturesfinalproject/utilis/constants.dart';

class AlertViewDialogue {
  createAlertDialogue(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Column(
            children: [
              Row(
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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                Constants.articleUrl,
                style: TextStyle(color: Colors.blue, fontSize: 12),
              ),
              RawGestureDetector(
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
                      RawGestureDetector(
                        gestures: {
                          AllowMultipleGestureRecognizer:
                              GestureRecognizerFactoryWithHandlers<
                                  AllowMultipleGestureRecognizer>(
                            () =>
                                AllowMultipleGestureRecognizer(), //constructor
                            (AllowMultipleGestureRecognizer instance) {
                              //initializer
                              instance.onTap = () {
                                Clipboard.setData(
                                    new ClipboardData(text: Constants.rayUrl));
                                showToastMessage(context);
                                print('Copy Button Tapped');
                              };
                            },
                          )
                        },
                        child: Container(
                            child: Center(
                          child: Text(
                            Constants.copyButton,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                                fontSize: 12),
                          ),
                        )),
                      ),
                      RawGestureDetector(
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
                                Clipboard.setData(
                                    new ClipboardData(text: Constants.mainUrl));
                                showToastMessage(context);
                                print('visit Site Tapped');
                              };
                            },
                          )
                        },
                        child: Container(
                            height: 50,
                            child: Center(
                              child: Text(
                                Constants.visit,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                    fontSize: 12),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  showToastMessage(BuildContext context) async {
    ScaffoldMessengerState scaffoldMessenger = ScaffoldMessenger.of(context);
    ScaffoldFeatureController controller = scaffoldMessenger.showSnackBar(
      const SnackBar(content: Text('URL Copied to Clipboard')),
    );
    final result = await controller.closed;
  }
}

class AllowMultipleGestureRecognizer extends TapGestureRecognizer {
  @override
  void rejectGesture(int pointer) {
    acceptGesture(pointer);
  }
}
