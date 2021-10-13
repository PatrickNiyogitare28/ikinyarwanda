import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ikinyarwanda/interface/widgets/circular_progress_widget.dart';
import 'package:ikinyarwanda/interface/widgets/text_widget.dart';
import 'package:ikinyarwanda/shared/ui_helpers.dart';
import 'package:stacked/stacked.dart';

import 'incamarenga_view_model.dart';

class IncamarengaView extends StatelessWidget {
  const IncamarengaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<IncamarengaViewModel>.reactive(
      viewModelBuilder: () => IncamarengaViewModel(),
      onModelReady: (viewModel) => viewModel.getIkeshamvugo(),
      builder: (context, viewModel, child) => Scaffold(
        body: viewModel.isBusy
            ? const CircularProgressWidget()
            : SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: viewModel.navigatePop,
                          color: Theme.of(context).primaryColor,
                          icon: const Icon(Icons.arrow_back),
                          splashColor: Theme.of(context).primaryColor,
                        ),
                        IconButton(
                          onPressed: viewModel.showAboutDialog,
                          color: Theme.of(context).primaryColor,
                          icon: const Icon(Icons.info_outline),
                          splashColor: Theme.of(context).primaryColor,
                        ),
                      ],
                    ),
                    Padding(
                      padding: basePadding,
                      child: TextWiget.headline2(
                        'Incamarenga',
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25, 0, 25, 8),
                      child: TextWiget.caption(
                        'Kandaho kugirango ubone ibisobanuro',
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: viewModel.incamarenga.length,
                        padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                        itemBuilder: (context, index) => ExpansionTile(
                          collapsedBackgroundColor:
                              Theme.of(context).backgroundColor,
                          iconColor: Theme.of(context).primaryColor,
                          backgroundColor: Theme.of(context).backgroundColor,
                          tilePadding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                          ),
                          childrenPadding:
                              const EdgeInsets.fromLTRB(12, 0, 12, 12),
                          title: TextWiget.headline3(
                            viewModel.incamarenga[index].statement,
                          ),
                          children: [
                            TextWiget.body(
                              viewModel.incamarenga[index].explaination,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
