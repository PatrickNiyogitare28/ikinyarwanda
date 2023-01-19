import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:ikinyarwanda/interface/widgets/web_centered_widget.dart';
import 'package:stacked/stacked.dart';

import 'home_view_model.dart';
import 'ibisakuzo/ibisakuzo_view.dart';
import 'ikeshamvuga/ikeshamvuga_view.dart';
import 'imigani_migufi/imigani_migufi_view.dart';
import 'incamarenga/incamarenga_view.dart';
import 'isomero/isomero_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        primary: false,
        body: WebCenteredWidget(
          child: getViewForIndex(viewModel.currentIndex),
        ),
        bottomNavigationBar: PageTransitionSwitcher(
          duration: const Duration(milliseconds: 300),
          reverse: viewModel.reverse,
          transitionBuilder: (
            Widget child,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return SharedAxisTransition(
              child: child,
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.horizontal,
            );
          },
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: viewModel.currentIndex,
            onTap: viewModel.setIndex,
            elevation: 0,
            backgroundColor: Theme.of(context).colorScheme.surface,
            selectedItemColor: Theme.of(context).colorScheme.primary,
            unselectedItemColor: Theme.of(context).colorScheme.onSurface,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.library_books_outlined),
                label: 'Isomero',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.rule_outlined),
                label: 'Sakwe Sakwe',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.games_outlined),
                label: 'Ikeshamvugo',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.token_outlined),
                label: 'Incamarenga',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.storm_outlined),
                label: 'Imigani',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget getViewForIndex(int index) {
  switch (index) {
    case 0:
      return const IsomeroView();
    case 1:
      return const IbisakuzoView();
    case 2:
      return const IkeshamvugoView();
    case 3:
      return const IncamarengaView();
    case 4:
      return const ImiganiMigufiView();
    default:
      return const IsomeroView();
  }
}
