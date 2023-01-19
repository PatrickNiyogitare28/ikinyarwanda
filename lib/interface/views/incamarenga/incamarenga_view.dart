import 'package:flutter/material.dart';
import 'package:ikinyarwanda/interface/widgets/circular_progress_widget.dart';
import 'package:ikinyarwanda/interface/widgets/text_widget.dart';
import 'package:ikinyarwanda/interface/widgets/web_centered_widget.dart';
import 'package:stacked/stacked.dart';

import 'incamarenga_view_model.dart';

class IncamarengaView extends StatelessWidget {
  const IncamarengaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<IncamarengaViewModel>.reactive(
      viewModelBuilder: () => IncamarengaViewModel(),
      onViewModelReady: (viewModel) => viewModel.getIkeshamvugo(),
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).colorScheme.primary,
          centerTitle: true,
          title: TextButton(
            style: TextButton.styleFrom(
              minimumSize: Size.zero,
              padding: EdgeInsets.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: viewModel.showAboutDialog,
            child: TextWidget.headline1(
              'Incamarenga',
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
        body: viewModel.isBusy
            ? const CircularProgressWidget()
            : WebCenteredWidget(
                child: SafeArea(
                  child: ListView.builder(
                    itemCount: viewModel.incamarenga.length,
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    itemBuilder: (context, index) => ExpansionTile(
                      tilePadding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                      ),
                      childrenPadding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                      title: TextWidget.body(
                        viewModel.incamarenga[index].statement,
                      ),
                      children: [
                        TextWidget.body(
                          viewModel.incamarenga[index].explaination,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
