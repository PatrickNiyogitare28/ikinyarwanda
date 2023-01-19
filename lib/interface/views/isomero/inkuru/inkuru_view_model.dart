import 'package:ikinyarwanda/locator.dart';
import 'package:ikinyarwanda/models/inkuru.dart';
import 'package:ikinyarwanda/services/dialog_service.dart';
import 'package:ikinyarwanda/services/favorites_service.dart';
import 'package:ikinyarwanda/services/navigation_service.dart';
import 'package:stacked/stacked.dart';

class InkuruViewModel extends ReactiveViewModel {
  final _dialogService = locator<DialogService>();
  final _navigationService = locator<NavigationService>();
  final _favoritesService = locator<FavoritesService>();

  var isFavorite = false;

  void getFavoriteStatus(String id) {
    isFavorite = _favoritesService.isFavorite(id);
  }

  void handleFavorite(Inkuru inkuru) async {
    if (isFavorite) {
      var dialogResponse = await _dialogService.showConfirmationDialog(
        title: 'Gusiba mu byo ukunda',
        description:
            'Uremeza ko ushaka kuvana "${inkuru.title}" mubyo ukunda gusoma?',
        confirmation: 'Yego',
        cancel: 'Oya',
      )!;

      if (dialogResponse.confirmed!) {
        _favoritesService.unfavoriteInkuru(inkuru.id);
        isFavorite = false;
        notifyListeners();
      }
    } else {
      _favoritesService.favoriteInkuru(inkuru.id);
      isFavorite = true;
      notifyListeners();
    }
  }

  void navigatorPop() {
    _navigationService.pop();
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_favoritesService];
}
