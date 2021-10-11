import 'package:ikinyarwanda/models/incamarenga.dart';
import 'package:ikinyarwanda/services/data_service.dart';
import 'package:ikinyarwanda/services/dialog_service.dart';
import 'package:ikinyarwanda/locator.dart';
import 'package:stacked/stacked.dart';

class IncamarengaViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();
  final _dataService = locator<DataService>();

  var incamarenga = <Incamarega>[];

  var gameTitle = 'Incamarenga';
  var gameAbout =
      'Umuntu aca amarenga ashaka kubwira uwo baziranye, icyo adashaka kubwira abamwumva bose.';

  void showAboutDialog() async {
    await _dialogService.showDialog(
      title: gameTitle,
      description: gameAbout,
    );
  }

  Future<void> getIkeshamvugo() async {
    setBusy(true);
    incamarenga = await _dataService.getIncamarenga();
    notifyListeners();
    setBusy(false);
  }
}
