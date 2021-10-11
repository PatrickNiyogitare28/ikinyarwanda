import 'package:ikinyarwanda/models/game.dart';
import 'package:ikinyarwanda/services/dialog_service.dart';
import 'package:ikinyarwanda/services/navigation_service.dart';
import 'package:ikinyarwanda/locator.dart';
import 'package:ikinyarwanda/shared/route_names.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();

  void contactUs() async {
    await _dialogService.showDialog(
      title: 'Twohereze ubutumwa',
      description:
          'Nshuti mukoresha,\n\nWatwohereza ibitekerezo, imivugo, inkuru ngufi, ikinyarwanda, insanganyamatsiko, n\'izindi nyandiko wifuza gusangiza abandi kuri imeri (rubandarwanda@gmail.com) cyangwa ku mbuga nkoranyambaga Twitter na Instagram - (@Rubanda_)',
    );
  }

  Future navigateToGame(String route, {dynamic arguments}) async {
    setBusy(true);
    await _navigationService.navigateTo(route, arguments: arguments);
    setBusy(false);
  }

  final _games = const [
    Game(
      title: 'Sakwe\nSakwe',
      route: ibisakuzoViewRoute,
      addArg: 1,
    ),
    Game(
      title: 'Ntibavuga\nBavuga',
      route: ikeshamvugoViewRoute,
    ),
    Game(
      title: 'Inca\nMarenga',
      route: incamarengaViewRoute,
    ),
    Game(
      title: 'Imigani\nMigufi',
      route: imiganiMigufiViewRoute,
    ),
    Game(
      title: 'Ibindi\nBisakuzo',
      route: ibisakuzoViewRoute,
      addArg: 2,
    ),
  ];

  List<Game> get games => _games;
}
