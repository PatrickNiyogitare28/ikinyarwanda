import 'package:flutter/material.dart';
import 'package:ikinyarwanda/interface/widgets/text_widget.dart';
import 'package:ikinyarwanda/interface/widgets/web_centered_widget.dart';
import 'package:ikinyarwanda/models/dialog.dart';
import 'package:ikinyarwanda/services/dialog_service.dart';
import 'package:ikinyarwanda/locator.dart';
import 'package:ikinyarwanda/shared/ui_helpers.dart';

class DialogManager extends StatefulWidget {
  final Widget child;
  const DialogManager({Key? key, required this.child}) : super(key: key);

  @override
  State<DialogManager> createState() => _DialogManagerState();
}

class _DialogManagerState extends State<DialogManager> {
  final _dialogService = locator<DialogService>();

  void _showDialog(DialogRequest request) {
    final isComfirmationDialog = request.cancelTitle != null;
    showDialog(
      context: context,
      builder: (context) => WebCenteredWidget(
        child: AlertDialog(
          elevation: 0,
          title: TextWidget.headline1(
            request.title,
            color: Theme.of(context).colorScheme.primary,
          ),
          content: TextWidget.body(request.description),
          actions: [
            if (isComfirmationDialog)
              TextButton(
                onPressed: () {
                  _dialogService
                      .dialogComplete(DialogResponse(confirmed: false));
                },
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                ),
                child: TextWidget.headline3(request.cancelTitle!),
              ),
            TextButton(
              onPressed: () {
                _dialogService.dialogComplete(DialogResponse(confirmed: true));
              },
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
              ),
              child: TextWidget.headline3(request.buttonTitle),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    _dialogService.registerDialogListener(_showDialog);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
