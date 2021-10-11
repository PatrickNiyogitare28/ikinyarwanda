import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ikinyarwanda/interface/widgets/circular_progress_widget.dart';
import 'package:ikinyarwanda/interface/widgets/text_widget.dart';
import 'package:stacked/stacked.dart';

import 'incamarenga_view_model.dart';

class IncamarengaView extends StatelessWidget {
  const IncamarengaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool darkModeOn = brightness == Brightness.dark;

    return ViewModelBuilder<IncamarengaViewModel>.reactive(
      viewModelBuilder: () => IncamarengaViewModel(),
      onModelReady: (viewModel) => viewModel.getIkeshamvugo(),
      builder: (context, viewModel, child) => Scaffold(
        body: viewModel.isBusy
            ? const CircularProgressWidget()
            : SafeArea(
                child: ListView.builder(
                  itemCount: viewModel.incamarenga.length,
                  itemBuilder: (context, index) => ExpansionTile(
                    collapsedBackgroundColor: Theme.of(context).backgroundColor,
                    iconColor: Theme.of(context).primaryColor,
                    backgroundColor: Theme.of(context).backgroundColor,
                    tilePadding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                    ),
                    childrenPadding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                    title: Text(
                      viewModel.incamarenga[index].statement,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    children: [
                      TextWiget.body(
                        viewModel.incamarenga[index].explaination,
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
