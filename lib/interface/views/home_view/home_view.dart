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
                  "Ibisakuzo ni umukino wo mu magambo. Ntibavuga - Bavuga cyangwa Ikeshamvugo ni ubuhanga bukoreshwa mu kuvuga imvugo inoze, ifite inganzo kandi ivugitse ku buryo bunoze. Umuntu aca amarenga ashaka kubwira uwo baziranye, icyo adashaka kubwira abamwumva bose. Imigani migufi yerekana uburezi, uburere n'imibanire y'abanyarwanda. ",
                ),
              ),
              verticalSpaceSmall,
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
                onTap: () {},
                child: TextWiget.caption('Twandikire'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


/*
Nkuko amateka y’ubuvanganzo nyarwanda abigaragaza, ibisakuzo ni umukino wo mu magambo, ibibazo n'ibisubizo bihimbaza abakuru n'abato kandi birimo ubuhanga byahimbanywe ubuhanga n'abahimbyi b'inzobere.
Ntibavuga - Bavuga cyangwa Ikeshamvugo ni ubuhanga bukoreshwa mu kuvuga imvugo inoze, yuje ikinyabupfura, ifite inganzo kandi ivugitse ku buryo bunoze mu muco w'Abanyarwanda.
Umuntu aca amarenga ashaka kubwira uwo baziranye, icyo adashaka kubwira abamwumva bose.
Imigani migufi ariyo bakunze kwita "Imigani y'imigenurano" yerekana uburezi, uburere n'imibanire y'abanyarwanda. 
 */