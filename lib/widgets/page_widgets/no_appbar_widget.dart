import 'package:flutter/material.dart';
import 'package:linguachat/utils/color_util.dart';

/// Bu kütüphane Scaffold widget'ının appBar özelliğini kullanmadan Scaffold widget'ını kullanmanızı sağlar.
AppBar NoAppBarWidget({Color? color}) {
  return AppBar(
    elevation: 0,
    backgroundColor: color ?? ColorUtil.white,
    toolbarHeight: 0,
  );
}
