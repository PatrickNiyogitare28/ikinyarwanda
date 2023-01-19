import 'package:ikinyarwanda/interface/route_names.dart';
import 'package:ikinyarwanda/locator.dart';
import 'package:ikinyarwanda/models/inkuru.dart';
import 'package:ikinyarwanda/services/data_service.dart';
import 'package:ikinyarwanda/services/favorites_service.dart';
import 'package:ikinyarwanda/services/navigation_service.dart';
import 'package:stacked/stacked.dart';

class TaggedIsomeroViewModel extends ReactiveViewModel {
  final _navigationService = locator<NavigationService>();
  final _favoritesService = locator<FavoritesService>();
  final _dataService = locator<DataService>();

  List<Inkuru> get _favorites => _favoritesService.favoritedInkurus;
  List<String> get favorites =>
      _favoritesService.favoritedInkurus.map((i) => i.id).toList();

  final _inkurus = <Inkuru>[];
  List<Inkuru> get inkurus => _inkurus;

  Future<void> getInkurus(String tag) async {
    setBusy(true);
    await _favoritesService.initSetup();
    if (tag == 'AAA') {
      inkurus.addAll(_favorites);
    } else {
      inkurus.addAll(await _dataService.getInkurus(tag));
    }
    setBusy(false);
  }

  Future<void> navigateToInkuruView(Inkuru inkuru) async {
    setBusy(true);
    await _navigationService.navigateTo(inkuruViewRoute, arguments: inkuru);
    setBusy(false);
  }

  void navigateBack() {
    _navigationService.pop();
  }
}
