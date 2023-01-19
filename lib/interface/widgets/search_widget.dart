import 'package:flutter/material.dart';
import 'package:ikinyarwanda/models/inkuru.dart';
import 'package:ikinyarwanda/shared/styles.dart';

import 'inkuru_summary_widget.dart';

class SearchWidget extends SearchDelegate<Inkuru?> {
  final String searchLabel;
  final List<Inkuru> inkurus;
  final List<String> favorites;
  final Function(Inkuru) readInkuru;
  final BuildContext context;

  SearchWidget({
    required this.readInkuru,
    required this.inkurus,
    required this.favorites,
    required this.searchLabel,
    required this.context,
  });

  var tempStories = <Inkuru>[];

  @override
  String get searchFieldLabel => searchLabel;

  @override
  TextStyle? get searchFieldStyle => headline3Style.apply(
        color: Theme.of(context).colorScheme.onPrimary,
        decoration: TextDecoration.none,
      );

  @override
  ThemeData appBarTheme(BuildContext context) {
    final theme = Theme.of(context);
    return theme.copyWith(
      inputDecorationTheme: InputDecorationTheme(
        border: InputBorder.none,
        hintStyle: headline3Style.apply(
            color: Theme.of(context).colorScheme.onPrimary),
        labelStyle: headline3Style.apply(
            color: Theme.of(context).colorScheme.onPrimary),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.clear,
          size: 22.0,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
        size: 22.0,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView.builder(
      itemCount: tempStories.length,
      itemBuilder: (context, index) {
        var a = tempStories[index];
        return GestureDetector(
          onTap: () async {
            await readInkuru(a);
            close(context, a);
          },
          child: InkuruSummaryWidget(
            inkuru: a,
            isFavorite: favorites.contains(a.id),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    tempStories = inkurus
        .where((a) => a.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: tempStories.length,
      itemBuilder: (context, index) {
        var a = tempStories[index];
        return GestureDetector(
          onTap: () async {
            await readInkuru(a);
            close(context, a);
          },
          child: InkuruSummaryWidget(
            inkuru: a,
            isFavorite: favorites.contains(a.id),
          ),
        );
      },
    );
  }
}
