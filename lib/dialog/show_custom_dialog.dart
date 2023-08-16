import 'package:flutter/material.dart';

showAlertDialog(BuildContext context, String title, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
          title: Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          content: Text(
            message,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                width: 60,
                height: 30,
                color: Theme.of(context).primaryColor,
                child: Center(
                  child: Text(
                    'OK',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
          ]);
    },
  );
}
