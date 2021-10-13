import 'package:flutter/material.dart';
import 'package:ikinyarwanda/interface/widgets/game_item_widget.dart';
import 'package:stacked/stacked.dart';
import 'package:ikinyarwanda/interface/widgets/text_widget.dart';
import 'package:ikinyarwanda/shared/ui_helpers.dart';

import 'home_view_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        body: Padding(
          padding: basePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              verticalSpaceLarge,
              Align(
                alignment: Alignment.centerLeft,
                child: TextWiget.headline1(
                  'Ikinyarwanda',
                  color: Theme.of(context).primaryColor,
                ),
              ),
              verticalSpaceSmall,
              Align(
                alignment: Alignment.centerLeft,
                child: TextWiget.caption(
                  "Ikinyarwanda ni ururimi ruvugwa n'abenegihugu hafi ya bose mu Rwanda, ndetse no mu burasirazuba bwo hagati bw'Afurika mu gice cy'ibiyaga bigari.",
                ),
              ),
              verticalSpaceLarge,
              Align(
                alignment: Alignment.centerLeft,
                child: TextWiget.body(
                  'Imikino y\'amagambo yagufasha kunoza ikinyarwanda',
                  color: Theme.of(context).primaryColor,
                  fontWeight: 2,
                ),
              ),
              Flexible(
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 20,
                  ),
                  itemCount: viewModel.games.length,
                  itemBuilder: (ctx, index) => GameItemWidget(
                    game: viewModel.games[index],
                    onTap: viewModel.navigateToGame,
                  ),
                ),
              ),
              GestureDetector(
                onTap: viewModel.contactUs,
                child: TextWiget.caption('Twandikire'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
