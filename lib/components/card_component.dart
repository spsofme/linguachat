import 'package:flutter/material.dart';
import 'package:linguachat/utils/color_util.dart';

Widget CardComponent({required Widget child, Function()? onTap , Function()? onDoubleTap, Color? color}) {
  return Card(
    elevation: 4.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
    color: color ?? ColorUtil.white,
    child: InkWell(
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      // child: child,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: child,
      ),
    ),
  );
}
