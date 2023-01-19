import 'package:flutter/material.dart';
import 'package:ikinyarwanda/interface/widgets/button_widget.dart';
import 'package:ikinyarwanda/interface/widgets/circular_progress_widget.dart';
import 'package:ikinyarwanda/interface/widgets/dots_indicator.dart';
import 'package:ikinyarwanda/interface/widgets/text_widget.dart';
import 'package:ikinyarwanda/interface/widgets/web_centered_widget.dart';
import 'package:ikinyarwanda/interface/widgets/widget_flipper.dart';
import 'package:ikinyarwanda/shared/ui_helpers.dart';
import 'package:stacked/stacked.dart';

import 'ikeshamvuga_view_model.dart';

class IkeshamvugoView extends StatefulWidget {
  const IkeshamvugoView({Key? key}) : super(key: key);

  @override
  _IkeshamvugoViewState createState() => _IkeshamvugoViewState();
}

class _IkeshamvugoViewState extends State<IkeshamvugoView>
    with TickerProviderStateMixin {
  late PageController _controller;
  var _currentPage = 0;
  var _isLastPage = false;
  static const _duration = Duration(milliseconds: 300);
  static const _curve = Curves.ease;

  @override
  void initState() {
    _controller = PageController(initialPage: _currentPage);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<IkeshamvugoViewModel>.reactive(
      viewModelBuilder: () => IkeshamvugoViewModel(),
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
              'Ikeshamvugo',
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
        body: viewModel.isBusy
            ? const CircularProgressWidget()
            : WebCenteredWidget(
                child: SafeArea(
                  child: Stack(
                    children: [
                      PageView.builder(
                        pageSnapping: true,
                        allowImplicitScrolling: false,
                        reverse: false,
                        scrollDirection: Axis.horizontal,
                        itemCount: viewModel.ikeshamvugo.length,
                        controller: _controller,
                        onPageChanged: (index) {
                          setState(() {
                            _currentPage = index;
                            _isLastPage = _currentPage ==
                                viewModel.ikeshamvugo.length - 1;
                          });
                        },
                        itemBuilder: (context, index) => Center(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height / 2,
                            child: WidgetFlipper(
                              frontWidget: AppCustomCard(
                                title: viewModel.gameCardFrontTitle,
                                flashCard:
                                    viewModel.ikeshamvugo[index].question,
                              ),
                              backWidget: AppCustomCard(
                                title: viewModel.gameCardBackTitle,
                                flashCard: viewModel.ikeshamvugo[index].answer,
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (!_isLastPage) ...[
                        Positioned(
                          bottom: 10.0,
                          left: 0.0,
                          right: 0.0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            child: DotsIndicator(
                              controller: _controller,
                              itemCount: viewModel.ikeshamvugo.length,
                              onPageSelected: (page) {
                                _controller.animateToPage(
                                  page,
                                  duration: _duration,
                                  curve: _curve,
                                );
                              },
                            ),
                          ),
                        ),
                      ] else ...[
                        Positioned(
                          bottom: 10.0,
                          left: 0.0,
                          right: 0.0,
                          child: Padding(
                            padding: basePadding,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ButtonWidget(
                                  title: 'Komeza',
                                  busy: viewModel.isBusy,
                                  onTap: () async {
                                    await viewModel.getIkeshamvugo();
                                    setState(() {
                                      _isLastPage = false;
                                      _currentPage = 0;
                                      _controller.jumpTo(0);
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

class AppCustomCard extends StatelessWidget {
  final String title;
  final String flashCard;

  const AppCustomCard({
    Key? key,
    required this.title,
    required this.flashCard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: basePadding,
      color: Theme.of(context).colorScheme.surfaceVariant,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(borderRadius),
                  topRight: Radius.circular(borderRadius),
                ),
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              child: Center(
                child: TextWidget.headline2(
                  title,
                  align: TextAlign.center,
                  color: Theme.of(context).colorScheme.background,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Center(
              child: Padding(
                padding: basePadding,
                child: TextWidget.headline2(
                  flashCard,
                  align: TextAlign.center,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
