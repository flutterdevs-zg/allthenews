import 'package:flutter/material.dart';

class Dot extends StatelessWidget {
  final TextStyle textStyle;

  Dot({this.textStyle});

  @override
  Widget build(BuildContext context) => Text(
        String.fromCharCode(0x2022),
        style: textStyle,
      );
}
