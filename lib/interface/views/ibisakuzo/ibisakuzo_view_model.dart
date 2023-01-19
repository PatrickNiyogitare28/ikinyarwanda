import 'dart:core';
import 'dart:math';

import 'package:ikinyarwanda/models/igisakuzo.dart';
import 'package:ikinyarwanda/services/data_service.dart';
import 'package:ikinyarwanda/services/dialog_service.dart';
import 'package:ikinyarwanda/locator.dart';
import 'package:stacked/stacked.dart';

class IbisakuzoViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();
  final _dataService = locator<DataService>();

  var ibisakuzoIcumi = <Igisakuzo>[];
  int? randomId;
  int? level;

  void showAboutDialog() async {
    await _dialogService.showDialog(
      title: 'Sakwe Sakwe',
      description:
          "Ibisakuzo ni umukino wo mu magambo, ibibazo n'ibisubizo bihimbaza abakuru n'abato kandi birimo ubuhanga. Nkuko amateka y'ubuvanganzo nyarwanda abigaragaza, ibisakuzo nabyo byagiraga abahimbyi b'inzobere muri byo, bahoraga bacukumbura ijoro n'umunsi, kugirango barusheho kunoza no gukungahaza uwo mukino.",
    );
  }

  // generate random number from 1 to 800 because there are 800 available
  // generate level random number from 1 to 2 because there are 2 levels available
  void _generateRandomNumber() {
    final random = Random();
    randomId = random.nextInt(800) + 1;
    level = random.nextInt(2) + 1;
  }

  Future<void> getIbisakuzo() async {
    setBusy(true);
    _generateRandomNumber();
    ibisakuzoIcumi = await _dataService.getIbisakuzo(level!, randomId!);
    notifyListeners();
    setBusy(false);
  }
}
