import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class WebCenteredWidget extends StatelessWidget {
  final Widget child;
  const WebCenteredWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInfo) {
        return Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: child,
          ),
        );
      },
    );
  }
}
