import 'package:flutter/material.dart';
import 'package:ikinyarwanda/interface/widgets/inkuru_summary_widget.dart';
import 'package:ikinyarwanda/interface/widgets/search_widget.dart';
import 'package:ikinyarwanda/interface/widgets/text_widget.dart';
import 'package:stacked/stacked.dart';

import 'tagged_isomero_view_model.dart';

class TaggedIsomeroView extends StatelessWidget {
  final String tag;
  const TaggedIsomeroView({
    Key? key,
    required this.tag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TaggedIsomeroViewModel>.reactive(
      viewModelBuilder: () => TaggedIsomeroViewModel(),
      createNewViewModelOnInsert: true,
      onViewModelReady: (viewModel) => viewModel.getInkurus(tag),
      builder: (context, viewModel, child) {
        final tagTitle = tag == 'AAA' ? 'Ibyo ukunda gusoma' : tag;
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
              onPressed: viewModel.navigateBack,
            ),
            title: TextWidget.headline3(
              tagTitle,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            actions: [
              IconButton(
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: SearchWidget(
                      inkurus: viewModel.inkurus,
                      readInkuru: viewModel.navigateToInkuruView,
                      favorites: viewModel.favorites,
                      searchLabel: 'Shakisha',
                      context: context,
                    ),
                  );
                },
                icon: Icon(
                  Icons.search,
                  size: 25.0,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ],
          ),
          body: ListView.builder(
            itemCount: viewModel.inkurus.length,
            itemBuilder: (_, index) => GestureDetector(
              onTap: () => viewModel.navigateToInkuruView(
                viewModel.inkurus[index],
              ),
              child: InkuruSummaryWidget(
                inkuru: viewModel.inkurus[index],
                isFavorite: viewModel.favorites.contains(
                  viewModel.inkurus[index].id,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
