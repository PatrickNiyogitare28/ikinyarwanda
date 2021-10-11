import 'package:flutter/material.dart';
import 'package:ikinyarwanda/interface/widgets/text_widget.dart';
import 'package:ikinyarwanda/models/game.dart';
import 'package:ikinyarwanda/shared/ui_helpers.dart';

class GameItemWidget extends StatelessWidget {
  final Game game;
  final Function onTap;

  const GameItemWidget({
    Key? key,
    required this.game,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(game.route, arguments: game.addArg),
      child: Card(
        elevation: 2,
        color: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Center(
          child: TextWiget.headline2(
            game.title,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
