import 'package:ikinyarwanda/locator.dart';
import 'package:ikinyarwanda/models/inkuru.dart';
import 'package:ikinyarwanda/services/data_service.dart';
import 'package:stacked/stacked.dart';

import 'localstorage_service.dart';

class FavoritesService with ListenableServiceMixin {
  final _storageService = locator<LocalStorageService>();
  final _dataService = locator<DataService>();

  final _reactiveList = ReactiveList<Inkuru>();
  List<Inkuru> get favoritedInkurus => _reactiveList;

  final _favoritesIds = <String>{};

  FavoritesService() {
    listenToReactiveValues([_reactiveList]);
  }

  Future<void> initSetup() async {
    final favs = _storageService.getStringListFromDisk('favorites');
    if (favs.isNotEmpty) {
      _favoritesIds.clear();
      _reactiveList.clear();
      _favoritesIds.addAll(favs);
      for (var f in favs) {
        final inkuru = await _dataService.getInkuruById(f);
        if (inkuru != null) {
          _reactiveList.add(inkuru);
        }
      }
    }
  }

  bool isFavorite(String id) {
    return _favoritesIds.contains(id);
  }

  void favoriteInkuru(String id) async {
    _favoritesIds.add(id);
    final inkuru = await _dataService.getInkuruById(id);
    if (inkuru != null) {
      _reactiveList.add(inkuru);
    }
    await _storageService.saveStringListToDisk('favorites', _favoritesIds);
  }

  void unfavoriteInkuru(String id) async {
    _favoritesIds.remove(id);
    _reactiveList.removeWhere((story) => story.title == id);
    await _storageService.saveStringListToDisk('favorites', _favoritesIds);
  }
}
