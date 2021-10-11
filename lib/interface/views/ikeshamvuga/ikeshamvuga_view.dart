import 'package:flutter/material.dart';
import 'package:ikinyarwanda/interface/widgets/button_widget.dart';
import 'package:ikinyarwanda/interface/widgets/circular_progress_widget.dart';
import 'package:ikinyarwanda/interface/widgets/dots_indicator.dart';
import 'package:ikinyarwanda/interface/widgets/text_widget.dart';
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
      onModelReady: (viewModel) => viewModel.getIkeshamvugo(),
      builder: (context, viewModel, child) => Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: viewModel.isBusy
            ? const CircularProgressWidget()
            : SafeArea(
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
                          _isLastPage =
                              _currentPage == viewModel.ikeshamvugo.length - 1;
                        });
                      },
                      itemBuilder: (context, index) => Column(
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
                          verticalSpaceLarge,
                          Padding(
                            padding: basePadding,
                            child: TextWiget.headline2(
                              'Ikeshamvugo',
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(25, 0, 25, 8),
                            child: TextWiget.caption(
                              'Kanda kugirango ubone igisubizo',
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          verticalSpaceLarge,
                          Center(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height / 2,
                              child: WidgetFlipper(
                                frontWidget: AppCustomCard(
                                  title: viewModel.gameCardFrontTitle,
                                  flashCard:
                                      viewModel.ikeshamvugo[index].question,
                                  firstColor: Theme.of(context).primaryColor,
                                  secondColor:
                                      Theme.of(context).backgroundColor,
                                ),
                                backWidget: AppCustomCard(
                                  title: viewModel.gameCardBackTitle,
                                  flashCard:
                                      viewModel.ikeshamvugo[index].answer,
                                  firstColor: Theme.of(context).primaryColor,
                                  secondColor:
                                      Theme.of(context).backgroundColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (!_isLastPage)
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Padding(
                          padding: const EdgeInsets.all(
                            10,
                          ),
                          child: Center(
                            child: DotsIndicator(
                              controller: _controller,
                              itemCount: viewModel.ikeshamvugo.length,
                              color: Theme.of(context).primaryColor,
                              onPageSelected: (int page) {
                                _controller.animateToPage(
                                  page,
                                  duration: _duration,
                                  curve: _curve,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    if (_isLastPage)
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Padding(
                          padding: basePadding,
                          child: ButtonWidget(
                            title: 'Komeza',
                            busy: viewModel.isBusy,
                            onTap: () {
                              viewModel.getIkeshamvugo().then((_) {
                                setState(() {
                                  _isLastPage = false;
                                  _currentPage = 0;
                                  _controller = PageController(
                                    initialPage: 0,
                                  );
                                });
                              });
                            },
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

class AppCustomCard extends StatelessWidget {
  final String title;
  final String flashCard;
  final Color firstColor;
  final Color secondColor;

  const AppCustomCard({
    Key? key,
    required this.title,
    required this.flashCard,
    required this.firstColor,
    required this.secondColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: basePadding,
      color: Theme.of(context).backgroundColor,
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
                color: Theme.of(context).primaryColor,
              ),
              child: Center(
                child: TextWiget.headline2(
                  title,
                  align: TextAlign.center,
                  color: Theme.of(context).backgroundColor,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Center(
              child: Padding(
                padding: basePadding,
                child: TextWiget.headline2(
                  flashCard,
                  align: TextAlign.center,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
