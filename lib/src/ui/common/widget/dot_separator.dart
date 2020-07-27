import 'package:flutter/material.dart';

class DotSeparator extends StatelessWidget {
  final double size;
  final Color color;

  const DotSeparator({this.size, this.color});

  @override
  Widget build(BuildContext context) => Text(
        String.fromCharCode(0x2022),
        style: Theme.of(context).textTheme.bodyText1.copyWith(
              color: color,
              fontSize: size,
              fontWeight: FontWeight.bold,
            ),
      );
}
