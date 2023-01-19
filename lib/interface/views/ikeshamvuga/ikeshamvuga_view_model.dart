import 'dart:math';

import 'package:ikinyarwanda/models/ikeshamvugo.dart';
import 'package:ikinyarwanda/services/data_service.dart';
import 'package:ikinyarwanda/services/dialog_service.dart';
import 'package:ikinyarwanda/locator.dart';
import 'package:stacked/stacked.dart';

class IkeshamvugoViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();
  final _dataService = locator<DataService>();

  var ikeshamvugo = <NtibavugaBavuga>[];
  int? randomId;

  var gameCardFrontTitle = 'Ntibavuga';
  var gameCardBackTitle = 'Bavuga';

  void showAboutDialog() async {
    await _dialogService.showDialog(
      title: 'Ikeshamvugo',
      description:
          "Ntibavuga - Bavuga cyangwa Ikeshamvugo ni ubuhanga bukoreshwa mu kuvuga no guhanga mu kinyarwanda. Iyo akaba ari imvugo inoze, yuje ikinyabupfura, ifite inganzo kandi ivugitse ku buryo bunoze. Ikeshamvugo ahanini, ni imvugo ikoreshwa mu guha agaciro umuntu uyu n'uyu cyangwa ikintu iki n'iki bitewe n'akamaro gifite mu muco w'Abanyarwanda, bityo hakirindwa gukoreshwa izina ryacyo mu buryo bukocamye.",
    );
  }

  void _generateRandomNumber() {
    var random = Random();
    randomId = random.nextInt(30) + 1;
  }

  Future<void> getIkeshamvugo() async {
    setBusy(true);
    _generateRandomNumber();
    ikeshamvugo = await _dataService.getIkeshamvugo(randomId!);
    notifyListeners();
    setBusy(false);
  }
}
