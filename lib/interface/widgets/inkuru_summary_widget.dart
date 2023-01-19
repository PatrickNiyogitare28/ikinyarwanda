import 'package:flutter/material.dart';
import 'package:ikinyarwanda/models/inkuru.dart';
import 'package:ikinyarwanda/shared/ui_helpers.dart';

import 'text_widget.dart';

class InkuruSummaryWidget extends StatelessWidget {
  final Inkuru inkuru;
  final bool isFavorite;

  const InkuruSummaryWidget({
    Key? key,
    required this.inkuru,
    required this.isFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final summary = inkuru.content.length < 80
        ? inkuru.content
        : inkuru.content.substring(0, 80).endsWith('\n')
            ? inkuru.content.substring(0, 79) + '\u2026\u0020'
            : inkuru.content.substring(0, 80) + '\u2026\u0020';
    return Card(
      elevation: 0,
      shape: null,
      color: Theme.of(context).colorScheme.surfaceVariant,
      margin: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 8.0,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (inkuru.author != '' || inkuru.tags.isNotEmpty) ...[
              Row(
                children: [
                  TextWidget.caption(
                    inkuru.author == ''
                        ? inkuru.tags.join(', ')
                        : '${inkuru.author} | ${inkuru.tags.join(', ')}',
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  if (isFavorite) ...[
                    TextWidget.caption(
                      ' | ',
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    Icon(
                      Icons.bookmark,
                      size: 14,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ]
                ],
              ),
              verticalSpaceSmall,
            ],
            Align(
              alignment: Alignment.centerLeft,
              child: TextWidget.headline3(
                inkuru.title,
                align: TextAlign.start,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            verticalSpaceSmall,
            Align(
              alignment: Alignment.centerLeft,
              child: TextWidget.body(
                summary,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
