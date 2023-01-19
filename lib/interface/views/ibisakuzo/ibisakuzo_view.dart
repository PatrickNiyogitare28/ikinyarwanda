import 'package:flutter/material.dart';
import 'package:ikinyarwanda/interface/widgets/button_widget.dart';
import 'package:ikinyarwanda/interface/widgets/circular_progress_widget.dart';
import 'package:ikinyarwanda/interface/widgets/dots_indicator.dart';
import 'package:ikinyarwanda/interface/widgets/text_widget.dart';
import 'package:ikinyarwanda/interface/widgets/web_centered_widget.dart';
import 'package:ikinyarwanda/models/igisakuzo.dart';
import 'package:ikinyarwanda/shared/ui_helpers.dart';
import 'package:stacked/stacked.dart';

import 'ibisakuzo_view_model.dart';

class IbisakuzoView extends StatefulWidget {
  const IbisakuzoView({Key? key}) : super(key: key);

  @override
  _IbisakuzoViewState createState() => _IbisakuzoViewState();
}

class _IbisakuzoViewState extends State<IbisakuzoView>
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
    return ViewModelBuilder<IbisakuzoViewModel>.reactive(
      viewModelBuilder: () => IbisakuzoViewModel(),
      onViewModelReady: (viewModel) => viewModel.getIbisakuzo(),
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: TextButton(
            style: TextButton.styleFrom(
              minimumSize: Size.zero,
              padding: EdgeInsets.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: viewModel.showAboutDialog,
            child: TextWidget.headline1(
              'Sakwe Sakwe?',
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
                        itemCount: viewModel.ibisakuzoIcumi.length,
                        controller: _controller,
                        onPageChanged: (index) {
                          setState(() {
                            _currentPage = index;
                            _isLastPage = _currentPage ==
                                viewModel.ibisakuzoIcumi.length - 1;
                          });
                        },
                        itemBuilder: (context, index) => Center(
                          child: IgisakuzoWidget(
                            igisakuzo: viewModel.ibisakuzoIcumi[index],
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
                              itemCount: viewModel.ibisakuzoIcumi.length,
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
                                  title: 'Ibindi bisakuzo',
                                  busy: viewModel.isBusy,
                                  onTap: () async {
                                    await viewModel.getIbisakuzo();
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

class IgisakuzoWidget extends StatelessWidget {
  final Igisakuzo igisakuzo;

  const IgisakuzoWidget({Key? key, required this.igisakuzo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceVariant,
      margin: basePadding,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 25.0,
              vertical: 25.0,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(borderRadius),
                topRight: Radius.circular(borderRadius),
              ),
            ),
            child: TextWidget.headline2(
              igisakuzo.question,
              align: TextAlign.center,
              color: Theme.of(context).colorScheme.background,
            ),
          ),
          verticalSpaceRegular,
          OptionWidget(
            optionText: igisakuzo.option1,
            correctAnswer: igisakuzo.correctAnswer,
          ),
          verticalSpaceTiny,
          OptionWidget(
            optionText: igisakuzo.option2,
            correctAnswer: igisakuzo.correctAnswer,
          ),
          verticalSpaceTiny,
          OptionWidget(
            optionText: igisakuzo.option3,
            correctAnswer: igisakuzo.correctAnswer,
          ),
          verticalSpaceTiny,
          OptionWidget(
            optionText: igisakuzo.option4,
            correctAnswer: igisakuzo.correctAnswer,
          ),
          verticalSpaceRegular,
        ],
      ),
    );
  }
}

class OptionWidget extends StatefulWidget {
  final String optionText;
  final String correctAnswer;
  const OptionWidget({
    Key? key,
    required this.optionText,
    required this.correctAnswer,
  }) : super(key: key);

  @override
  _GameOptionState createState() => _GameOptionState();
}

class _GameOptionState extends State<OptionWidget> {
  late bool _isCorrect;
  late bool _isWrong;

  @override
  void initState() {
    _isCorrect = false;
    _isWrong = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 12.0,
      ),
      constraints: const BoxConstraints(
        minHeight: 50,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: _isCorrect
            ? Theme.of(context).colorScheme.inverseSurface
            : _isWrong
                ? Theme.of(context).colorScheme.errorContainer
                : Theme.of(context).colorScheme.surface,
      ),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        onPressed: () {
          setState(() {
            if (widget.optionText == widget.correctAnswer) {
              if (!_isCorrect && !_isWrong) {
                _isCorrect = true;
              }
            } else {
              if (!_isCorrect && !_isWrong) {
                _isWrong = true;
              }
            }
          });
        },
        child: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: TextWidget.body(
                  widget.optionText,
                  color: _isCorrect
                      ? Theme.of(context).colorScheme.onInverseSurface
                      : _isWrong
                          ? Theme.of(context).colorScheme.onErrorContainer
                          : Theme.of(context).colorScheme.onSurface,
                ),
              ),
              horizontalSpaceTiny,
              _isCorrect
                  ? Icon(
                      Icons.check,
                      color: Theme.of(context).colorScheme.onInverseSurface,
                      size: 16,
                    )
                  : _isWrong
                      ? Icon(
                          Icons.close,
                          color: Theme.of(context).colorScheme.onErrorContainer,
                          size: 16,
                        )
                      : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
