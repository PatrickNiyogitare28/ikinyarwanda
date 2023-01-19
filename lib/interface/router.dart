import 'package:flutter/material.dart';
import 'package:ikinyarwanda/models/inkuru.dart';
import 'views/home_view.dart';
import 'views/isomero/inkuru/inkuru_view.dart';
import 'views/isomero/tagged/tagged_isomero_view.dart';
import 'widgets/text_widget.dart';
import 'route_names.dart';

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
    case inkuruViewRoute:
      final inkuru = settings.arguments as Inkuru;
      return _pageRoute(
        routeName: settings.name!,
        view: InkuruView(inkuru: inkuru),
      );
    case taggedIsomeroViewRoute:
      final tag = settings.arguments as String;
      return _pageRoute(
        routeName: settings.name!,
        view: TaggedIsomeroView(tag: tag),
      );

    default:
      return MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(
            child: TextWidget.headline3('Paje itazwi!'),
          ),
        ),
      );
  }
}
