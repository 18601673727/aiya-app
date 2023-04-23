import 'dart:ui';
import 'package:flutter/material.dart';

class BlurryDialog extends StatelessWidget {
  const BlurryDialog(
    this.confirmText,
    this.cancelText,
    this.title,
    this.content,
    this.continueCallBack,
    this.cancelCallback, {
    super.key,
  });

  final String title;
  final String content;
  final String confirmText;
  final String cancelText;
  final VoidCallback continueCallBack;
  final VoidCallback cancelCallback;
  final TextStyle textStyle = const TextStyle(color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
      child: AlertDialog(
        title: Text(
          title,
          style: textStyle,
        ),
        content: Text(
          content,
          style: textStyle,
        ),
        actions: <Widget>[
          TextButton(
            child: Text(confirmText),
            onPressed: () {
              continueCallBack();
            },
          ),
          TextButton(
            child: Text(cancelText),
            onPressed: () {
              cancelCallback();
            },
          ),
        ],
      ),
    );
  }
}
