import 'package:flutter/material.dart';
import 'package:ikinyarwanda/interface/widgets/text_widget.dart';
import 'package:ikinyarwanda/interface/widgets/web_centered_widget.dart';
import 'package:ikinyarwanda/models/inkuru.dart';
import 'package:ikinyarwanda/shared/ui_helpers.dart';
import 'package:stacked/stacked.dart';

import 'Inkuru_view_model.dart';

class InkuruView extends StatelessWidget {
  final Inkuru inkuru;
  const InkuruView({Key? key, required this.inkuru}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<InkuruViewModel>.reactive(
      viewModelBuilder: () => InkuruViewModel(),
      onViewModelReady: (viewModel) => viewModel.getFavoriteStatus(inkuru.id),
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: Theme.of(context).colorScheme.primary,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                size: 25,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              onPressed: viewModel.navigatorPop,
            ),
            title: TextWidget.headline3(
              inkuru.title,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            actions: [
              IconButton(
                onPressed: () => viewModel.handleFavorite(inkuru),
                icon: Icon(
                  viewModel.isFavorite
                      ? Icons.bookmark_added
                      : Icons.bookmark_add_outlined,
                  size: 25,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              )
            ],
          ),
          body: WebCenteredWidget(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpaceSmall,
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30.0,
                    ),
                    child: TextWidget.body(
                      inkuru.content,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  verticalSpaceMedium,
                  if (inkuru.author != '') ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30.0,
                      ),
                      child: TextWidget.body(
                        inkuru.author,
                        fontWeight: 2,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                    verticalSpaceTiny,
                  ],
                  if (inkuru.tags != []) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30.0,
                      ),
                      child: TextWidget.caption(
                        inkuru.tags.join(', '),
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ],
                  verticalSpaceMedium,
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
