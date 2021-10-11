import 'dart:math';

import 'package:flutter/material.dart';

class WidgetFlipper extends StatefulWidget {
  final Widget frontWidget;
  final Widget backWidget;

  const WidgetFlipper({
    Key? key,
    required this.frontWidget,
    required this.backWidget,
  }) : super(key: key);

  @override
  _WidgetFlipperState createState() => _WidgetFlipperState();
}

class _WidgetFlipperState extends State<WidgetFlipper>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> _frontRotation;
  late Animation<double> _backRotation;
  bool isFrontVisible = true;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _updateRotations(true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  _updateRotations(bool isRightTap) {
    setState(
      () {
        bool rotateToLeft =
            (isFrontVisible && !isRightTap) || !isFrontVisible && isRightTap;

        _frontRotation = TweenSequence(
          <TweenSequenceItem<double>>[
            TweenSequenceItem<double>(
              tween: Tween(
                begin: 0.0,
                end: rotateToLeft ? (pi / 2) : (-pi / 2),
              ).chain(
                CurveTween(curve: Curves.linear),
              ),
              weight: 50.0,
            ),
            TweenSequenceItem<double>(
              tween: ConstantTween<double>(
                rotateToLeft ? (-pi / 2) : (pi / 2),
              ),
              weight: 50.0,
            ),
          ],
        ).animate(controller);

        _backRotation = TweenSequence(
          <TweenSequenceItem<double>>[
            TweenSequenceItem<double>(
              tween: ConstantTween<double>(
                rotateToLeft ? (pi / 2) : (-pi / 2),
              ),
              weight: 50.0,
            ),
            TweenSequenceItem<double>(
              tween: Tween(
                begin: rotateToLeft ? (-pi / 2) : (pi / 2),
                end: 0.0,
              ).chain(
                CurveTween(curve: Curves.linear),
              ),
              weight: 50.0,
            ),
          ],
        ).animate(controller);
      },
    );
  }

  void _leftRotation() {
    _toggleSide(false);
  }

  void _rightRotation() {
    _toggleSide(true);
  }

  void _toggleSide(bool isRightTap) {
    _updateRotations(isRightTap);
    if (isFrontVisible) {
      controller.forward();
      isFrontVisible = false;
    } else {
      controller.reverse();
      isFrontVisible = true;
    }
  }

  Widget _tapDetectionControls() {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        GestureDetector(
          onTap: _leftRotation,
          child: FractionallySizedBox(
            widthFactor: 0.5,
            heightFactor: 1.0,
            alignment: Alignment.topLeft,
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
        GestureDetector(
          onTap: _rightRotation,
          child: FractionallySizedBox(
            widthFactor: 0.5,
            heightFactor: 1.0,
            alignment: Alignment.topRight,
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        AnimatedCard(
          animation: _backRotation,
          child: widget.backWidget,
        ),
        AnimatedCard(
          animation: _frontRotation,
          child: widget.frontWidget,
        ),
        _tapDetectionControls(),
      ],
    );
  }
}

class AnimatedCard extends StatelessWidget {
  const AnimatedCard({
    Key? key,
    required this.child,
    required this.animation,
  }) : super(key: key);

  final Widget child;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        var transform = Matrix4.identity();
        transform.setEntry(3, 2, 0.001);
        transform.rotateY(animation.value);
        return Transform(
          transform: transform,
          alignment: Alignment.center,
          child: child,
        );
      },
      child: child,
    );
  }
}
