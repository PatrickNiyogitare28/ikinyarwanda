import 'package:flutter/material.dart';
import 'package:ikinyarwanda/interface/widgets/circular_progress_widget.dart';
import 'package:ikinyarwanda/shared/ui_helpers.dart';

import 'text_widget.dart';

class ButtonWidget extends StatelessWidget {
  final String title;
  final bool disabled;
  final bool busy;
  final void Function()? onTap;
  final bool outline;
  final Widget? leading;
  final Color? color;
  final Color? borderColor;

  const ButtonWidget({
    Key? key,
    required this.title,
    this.disabled = false,
    this.busy = false,
    this.onTap,
    this.leading,
    this.color,
  })  : outline = false,
        borderColor = null,
        super(key: key);

  const ButtonWidget.outline({
    Key? key,
    required this.title,
    this.onTap,
    this.leading,
    this.disabled = false,
    this.busy = false,
    this.outline = true,
    this.borderColor,
  })  : color = Colors.transparent,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: !disabled ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 350),
        height: 50,
        width: 150,
        constraints: const BoxConstraints(maxWidth: 250, minWidth: 200),
        alignment: Alignment.center,
        decoration: !outline
            ? BoxDecoration(
                color: !disabled
                    ? color ?? Theme.of(context).colorScheme.secondary
                    : color == null
                        ? Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(.3)
                        : color!.withOpacity(.3),
                borderRadius: BorderRadius.circular(borderRadius),
              )
            : BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(borderRadius),
                border: Border.all(
                  color: !disabled
                      ? borderColor ?? Theme.of(context).colorScheme.secondary
                      : borderColor == null
                          ? Theme.of(context)
                              .colorScheme
                              .secondary
                              .withOpacity(.3)
                          : borderColor!.withOpacity(.3),
                  width: 1,
                ),
              ),
        child: !busy
            ? Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (leading != null) leading!,
                  if (leading != null) horizontalSpaceSmall,
                  Flexible(
                    child: TextWidget.body(
                      title,
                      fontWeight: !outline ? 2 : 1,
                      color: !outline
                          ? Theme.of(context).colorScheme.onSecondary
                          : !disabled
                              ? Theme.of(context).colorScheme.onSecondary
                              : Theme.of(context)
                                  .colorScheme
                                  .onBackground
                                  .withOpacity(.3),
                    ),
                  ),
                ],
              )
            : const CircularProgressWidget(),
      ),
    );
  }
}
