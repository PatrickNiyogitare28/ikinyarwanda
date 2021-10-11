import 'dart:math';

import 'package:ikinyarwanda/services/data_service.dart';
import 'package:ikinyarwanda/services/dialog_service.dart';
import 'package:ikinyarwanda/locator.dart';
import 'package:ikinyarwanda/services/navigation_service.dart';
import 'package:stacked/stacked.dart';

const String loadingIndicatorTitle = '^';

class ImiganiMigufiViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();
  final _navigationService = locator<NavigationService>();
  final _dataService = locator<DataService>();

  static const int itemRequestThreshold = 30;
  var _currentPage = 0;

  var imigani = <String>[];

  int? randomId;

  void showAboutDialog() async {
    await _dialogService.showDialog(
      title: 'Imigani Migufi',
      description:
          "Imigani migufi ariyo bakunze kwita ''Imigani y'imigenurano'' irusha ibindi byose kuranga umuco rusange w'abanyarwanda.  Ushaka kumenya uburezi n'uburere cyangwa imibanire y'abantu bya Kinyarwanda wabisangamo.\nNkuko amateka y'ubuvanganzo nyarwanda abigaragaza, umugani n'ipfundo ry'amagambo atonze neza Gacamigani yakagiriyemo ihame ridutoza gukora iki cyangwa se kudakora kiriya. Mbese muri make umugani ni umwanzuro w'amarenga y'intekerezo. Umugani uvuga ukuri, ariko muri kamere yawo ntabwo wo uba ari ukuri.",
    );
  }

  Future handleItemCreated(int index) async {
    var itemPosition = index + 1;
    var requestMoreData =
        itemPosition % itemRequestThreshold == 0 && itemPosition != 0;
    var pageToRequest = itemPosition ~/ itemRequestThreshold;

    if (requestMoreData && pageToRequest > _currentPage) {
      _currentPage = pageToRequest;
      _showLoadingIndicator();

      _generateRandomNumber();
      var indiMigani = await _dataService.getImiganiMigufi(randomId!);
      imigani.addAll(indiMigani);
      _removeLoadingIndicator();
    }
  }

  void _showLoadingIndicator() {
    imigani.add(loadingIndicatorTitle);
    notifyListeners();
  }

  void _removeLoadingIndicator() {
    imigani.remove(loadingIndicatorTitle);
    notifyListeners();
  }

  void _generateRandomNumber() {
    var random = Random();
    randomId = random.nextInt(10) + 1;
  }

  void getImigani() async {
    setBusy(true);
    _generateRandomNumber();
    imigani = await _dataService.getImiganiMigufi(randomId!);
    notifyListeners();
    setBusy(false);
  }

  void navigatePop() {
    setBusy(true);
    _navigationService.pop();
    setBusy(false);
  }
}
