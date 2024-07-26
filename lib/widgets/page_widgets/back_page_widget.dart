import 'package:flutter/material.dart';
import 'package:linguachat/widgets/page_widgets/no_appbar_widget.dart';

Widget BackPageWidget(BuildContext context,
    {required Widget header, required Widget child, Color? color}) {
  return Scaffold(
    appBar: NoAppBarWidget(color: color),
    body: Container(
      color: color,
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                iconSize: 24,
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              header,
              const SizedBox(
                width: 48,
              )
            ],
          ),
          child,
        ],
      ),
    ),
  );
}
