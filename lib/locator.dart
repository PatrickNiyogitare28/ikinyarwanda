import 'package:get_it/get_it.dart';

import '/services/dialog_service.dart';
import '/services/data_service.dart';
import '/services/navigation_service.dart';
import 'services/favorites_service.dart';
import 'services/localstorage_service.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => DataService());
  locator.registerLazySingleton(() => FavoritesService());

  final instance = await LocalStorageService.getServiceInstance();
  locator.registerSingleton<LocalStorageService>(instance!);
}
