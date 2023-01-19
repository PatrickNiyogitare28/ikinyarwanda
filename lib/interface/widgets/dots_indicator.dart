import 'dart:math';

import 'package:flutter/material.dart';

class DotsIndicator extends AnimatedWidget {
  final PageController controller;
  final int itemCount;
  final ValueChanged<int> onPageSelected;
  static const double _kDotSize = 8.0;
  static const double _kMaxZoom = 2.0;
  static const double _kDotSpacing = 25.0;

  const DotsIndicator({
    Key? key,
    required this.controller,
    required this.itemCount,
    required this.onPageSelected,
  }) : super(listenable: controller, key: key);

  Widget _buildDot(BuildContext context, int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((controller.page ?? controller.initialPage) - index).abs(),
      ),
    );
    double zoom = 1.0 + (_kMaxZoom - 1.0) * selectedness;
    return Expanded(
      child: SizedBox(
        width: _kDotSpacing,
        child: Center(
          child: Material(
            color: Theme.of(context).colorScheme.onBackground,
            type: MaterialType.circle,
            child: SizedBox(
              width: _kDotSize * zoom,
              height: _kDotSize * zoom,
              child: InkWell(
                onTap: () => onPageSelected(index),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(
        itemCount,
        (index) => _buildDot(context, index),
      ),
    );
  }
}
