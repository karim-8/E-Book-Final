import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gesturesfinalproject/constants.dart';

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
            ],
          ),
          content: Text(
            Constants.articleUrl,
            style: TextStyle(color: Colors.blue),
          ),
          actions: <Widget>[
            GestureDetector(
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Text(
                    Constants.copyButton,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.blue),
                  )),
              onTap: () async {
                Clipboard.setData(new ClipboardData(text: Constants.rayUrl));
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
                showToastMessage(context);
              },
            ),
          ],
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
