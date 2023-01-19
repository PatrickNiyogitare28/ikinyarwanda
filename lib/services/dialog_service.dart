import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:ikinyarwanda/models/dialog.dart';

class DialogService {
  final _dialogNavigationKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> get dialogNavigationKey => _dialogNavigationKey;

  late Function _showDialogListener;
  late Completer<DialogResponse>? _dialogCompleter;

  void registerDialogListener(Function(DialogRequest) showDialogListener) {
    _showDialogListener = showDialogListener;
  }

  Future<DialogResponse>? showDialog(
      {required String title,
      required String description,
      String buttonTitle = 'Ok'}) {
    _dialogCompleter = Completer<DialogResponse>();
    _showDialogListener(DialogRequest(
        title: title, description: description, buttonTitle: buttonTitle));
    return _dialogCompleter!.future;
  }

  Future<DialogResponse>? showConfirmationDialog({
    required String title,
    required String description,
    String confirmation = 'Yego',
    String cancel = 'Oya',
  }) {
    _dialogCompleter = Completer<DialogResponse>();
    _showDialogListener(DialogRequest(
        title: title,
        description: description,
        buttonTitle: confirmation,
        cancelTitle: cancel));

    return _dialogCompleter!.future;
  }

  void dialogComplete(DialogResponse response) {
    _dialogNavigationKey.currentState!.pop();
    _dialogCompleter!.complete(response);
    _dialogCompleter = null;
  }
}
