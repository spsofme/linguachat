import 'package:flutter/material.dart';
import 'package:linguachat/widgets/page_widgets/no_appbar_widget.dart';

/// Ortak Scaffold widget'ını kullanmanızı sağlar.
Widget PageWidget(BuildContext context,
    {required Widget child, Widget? header, Color? color}) {
  return Scaffold(
    appBar: NoAppBarWidget(color: color),
    // body: child,
    body: Container(
      color: color,
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            child: header,
          ),
          child,
        ],
      ),
    ),
  );
}
