import 'package:flutter/material.dart';
import 'package:ikinyarwanda/shared/styles.dart';
import 'package:ikinyarwanda/shared/ui_helpers.dart';

class ButtonWidget extends StatelessWidget {
  final String title;
  final bool busy;
  final void Function()? onTap;

  const ButtonWidget({
    Key? key,
    required this.title,
    this.busy = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 350),
        width: double.infinity,
        height: 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: !busy
            ? Text(
                title,
                style: bodyStyle.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).backgroundColor,
                ),
              )
            : const CircularProgressIndicator(
                strokeWidth: 5,
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
      ),
    );
  }
}
