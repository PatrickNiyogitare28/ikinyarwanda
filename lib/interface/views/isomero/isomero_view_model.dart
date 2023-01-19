import 'package:ikinyarwanda/interface/route_names.dart';
import 'package:ikinyarwanda/locator.dart';
import 'package:ikinyarwanda/models/inkuru.dart';
import 'package:ikinyarwanda/services/data_service.dart';
import 'package:ikinyarwanda/services/dialog_service.dart';
import 'package:ikinyarwanda/services/favorites_service.dart';
import 'package:ikinyarwanda/services/navigation_service.dart';
import 'package:stacked/stacked.dart';

class IsomeroViewModel extends ReactiveViewModel {
  final _favoritesService = locator<FavoritesService>();
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final _dataService = locator<DataService>();

  List<String> get favorites =>
      _favoritesService.favoritedInkurus.map((i) => i.id).toList();

  final _inkurus = <Inkuru>[];
  List<Inkuru> get inkurus => _inkurus;

  List<String> get ubwoko => [
        'AAA',
        'Abana',
        'Ibyivugo',
        'Imigani',
        'Imivugo',
        'Indirimbo',
        'Inka',
        'Ubumenyi',
        'Urukundo',
        'Abakuru',
        'Alegisi Kagame',
        'Anastase Shyaka',
        'Déo Mazina',
        'Habyalimana Bangambiki',
        'J.B Habimana',
        'Jean Bonaventure Habimana',
        'Jean Pierre Kabano',
        'Jyamubandi Deo',
        'Kajuga Jerome',
        'Karangwa Anaclet',
        'Kimenyi Alexandre',
        'Mupenzi Venuste',
        'Ngarambe François-Xavier',
        'Placide Kalisa',
        'Rugamba Sipiriyani',
        'Sibomana Antoine',
        'Sipiriyani Rugamba',
        'Tuyisenge Olivier',
        'Yozefu Bizuru w\'i Rwamagana',
        'Zeferini Gahamanyi na Francine Uwera'
      ];

  Future<void> getInkurus() async {
    setBusy(true);
    await _favoritesService.initSetup();
    inkurus.addAll(await _dataService.getInkurus());
    setBusy(false);
  }

  Future<void> navigateToInkuruView(Inkuru inkuru) async {
    setBusy(true);
    await _navigationService.navigateTo(inkuruViewRoute, arguments: inkuru);
    setBusy(false);
  }

  Future<void> navigateToTaggedIsomeroView(String tag) async {
    setBusy(true);
    await _navigationService.navigateTo(taggedIsomeroViewRoute, arguments: tag);
    setBusy(false);
  }

  Future<void> showAboutDialog() async {
    await _dialogService.showDialog(
      title: 'Ubuvanganzo',
      description:
          'Ubuvanganzo nyarwanda harimo ibisigo, amazina y\'inka, ibyivugo, ibisingizo ibihozo, imigani miremire, ibitekerezo, imigani migufi (imigenurano),inshoberamahanga, insigamigani, n\'ibindi',
    );
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_favoritesService];
}
