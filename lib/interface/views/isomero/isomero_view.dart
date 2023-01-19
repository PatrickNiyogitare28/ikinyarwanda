import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:ikinyarwanda/interface/widgets/circular_progress_widget.dart';
import 'package:ikinyarwanda/interface/widgets/inkuru_summary_widget.dart';
import 'package:ikinyarwanda/interface/widgets/search_widget.dart';
import 'package:ikinyarwanda/interface/widgets/text_widget.dart';
import 'package:ikinyarwanda/interface/widgets/web_centered_widget.dart';

import 'isomero_view_model.dart';

class IsomeroView extends StatelessWidget {
  const IsomeroView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<IsomeroViewModel>.reactive(
      viewModelBuilder: () => IsomeroViewModel(),
      onViewModelReady: ((viewModel) => viewModel.getInkurus()),
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
              'Isomero',
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
        body: viewModel.isBusy
            ? const CircularProgressWidget()
            : WebCenteredWidget(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      color: Theme.of(context).colorScheme.surface,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: viewModel.ubwoko.length,
                                itemBuilder: (_, index) => GestureDetector(
                                  onTap: () =>
                                      viewModel.navigateToTaggedIsomeroView(
                                    viewModel.ubwoko[index],
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 15.0),
                                      child: ConstrainedBox(
                                        constraints:
                                            const BoxConstraints(minWidth: 30),
                                        child: index == 0
                                            ? Icon(
                                                Icons.bookmark_border,
                                                size: 22.0,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSurface,
                                              )
                                            : TextWidget.body(
                                                viewModel.ubwoko[index],
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSurface,
                                              ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            padding: const EdgeInsets.only(left: 8),
                            constraints: const BoxConstraints(),
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
                              size: 22.0,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
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
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
