import 'package:flutter/material.dart';
import 'views/home_view/home_view.dart';
import 'views/ibisakuzo_view/ibisakuzo_view.dart';
import 'views/imigani_migufi_view/imigani_migufi_view.dart';
import 'views/incamarenga_view/incamarenga_view.dart';
import 'widgets/text_widget.dart';
import 'views/ikeshamvuga/ikeshamvuga_view.dart';
import '../shared/route_names.dart';

PageRoute _pageRoute({required String routeName, required Widget view}) {
  return MaterialPageRoute(
    settings: RouteSettings(name: routeName),
    builder: (_) => view,
  );
}

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case homeViewRoute:
      return _pageRoute(
        routeName: settings.name!,
        view: const HomeView(),
      );
    case ibisakuzoViewRoute:
      var level = settings.arguments as int;
      return _pageRoute(
        routeName: settings.name!,
        view: IbisakuzoView(level: level),
      );
    case ikeshamvugoViewRoute:
      return _pageRoute(
        routeName: settings.name!,
        view: const IkeshamvugoView(),
      );
    case incamarengaViewRoute:
      return _pageRoute(
        routeName: settings.name!,
        view: const IncamarengaView(),
      );
    case imiganiMigufiViewRoute:
      return _pageRoute(
        routeName: settings.name!,
        view: const ImiganiMigufiView(),
      );

    default:
      return MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(
            child: TextWiget.headline3('Paje itazwi!'),
          ),
        ),
      );
  }
}
