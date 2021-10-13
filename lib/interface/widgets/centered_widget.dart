import 'package:flutter/material.dart';

class CenteredWidget extends StatelessWidget {
  final Widget child;
  final double width;
  const CenteredWidget({
    Key? key,
    required this.child,
    this.width = 1200,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: width),
        child: child,
      ),
    );
  }
}

// TODO: adapt responsive
//     ResponsiveBuilder(
      // builder: (context, sizingInfo) { var isMobile = sizingInfo.deviceScreenType != DeviceScreenType.mobile;

