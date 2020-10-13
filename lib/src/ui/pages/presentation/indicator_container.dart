import 'dart:math';

import 'package:flutter/material.dart';

class _Constants {
  static const indicatorSize = 8.0;
  static const indicatorSpacing = 25.0;
  static const indicatorMaxZoom = 2.0;
}

class IndicatorContainer extends AnimatedWidget {
  const IndicatorContainer({
    @required this.controller,
    @required this.itemCount,
    @required this.onPageSelected,
  }) : super(listenable: controller);

  final PageController controller;
  final int itemCount;
  final ValueChanged<int> onPageSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(itemCount, _buildIndicator),
    );
  }

  Widget _buildIndicator(int index) {
    final double animationValue = max(0, 1.0 - ((controller.hasClients ? controller.page : controller.initialPage) - index).abs());
    final double zoom = 1.0 + (_Constants.indicatorMaxZoom - 1.0) * animationValue;
    return SizedBox(
      width: _Constants.indicatorSpacing,
      child: Center(
        child: Material(
          color: Colors.grey,
          type: MaterialType.circle,
          child: SizedBox(
            width: _Constants.indicatorSize * zoom,
            height: _Constants.indicatorSize * zoom,
            child: InkWell(
              onTap: () => onPageSelected(index),
            ),
          ),
        ),
      ),
    );
  }
}
