import 'package:ikinyarwanda/models/incamarenga.dart';
import 'package:ikinyarwanda/services/data_service.dart';
import 'package:ikinyarwanda/services/dialog_service.dart';
import 'package:ikinyarwanda/locator.dart';
import 'package:ikinyarwanda/services/navigation_service.dart';
import 'package:stacked/stacked.dart';

class IncamarengaViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();
  final _navigationService = locator<NavigationService>();
  final _dataService = locator<DataService>();

  var incamarenga = <Incamarega>[];

  void showAboutDialog() async {
    await _dialogService.showDialog(
      title: 'Incamarenga',
      description:
          'Umuntu aca amarenga ashaka kubwira uwo baziranye, icyo adashaka kubwira abamwumva bose.',
    );
  }

  Future<void> getIkeshamvugo() async {
    setBusy(true);
    incamarenga = await _dataService.getIncamarenga();
    notifyListeners();
    setBusy(false);
  }

  void navigatePop() {
    setBusy(true);
    _navigationService.pop();
    setBusy(false);
  }
}
