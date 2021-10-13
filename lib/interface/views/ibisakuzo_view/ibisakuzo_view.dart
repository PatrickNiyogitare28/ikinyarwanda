import 'package:flutter/material.dart';
import 'package:ikinyarwanda/interface/widgets/button_widget.dart';
import 'package:ikinyarwanda/interface/widgets/circular_progress_widget.dart';
import 'package:ikinyarwanda/interface/widgets/dots_indicator.dart';
import 'package:ikinyarwanda/interface/widgets/text_widget.dart';
import 'package:ikinyarwanda/models/igisakuzo.dart';
import 'package:ikinyarwanda/shared/styles.dart';
import 'package:ikinyarwanda/shared/ui_helpers.dart';
import 'package:stacked/stacked.dart';

import 'ibisakuzo_view_model.dart';

class IbisakuzoView extends StatefulWidget {
  final int level;
  const IbisakuzoView({Key? key, required this.level}) : super(key: key);

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
      onModelReady: (viewModel) => viewModel.getIbisakuzo(widget.level),
      builder: (context, viewModel, child) => Scaffold(
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
                      itemCount: viewModel.ibisakuzoIcumi.length,
                      controller: _controller,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                          _isLastPage = _currentPage ==
                              viewModel.ibisakuzoIcumi.length - 1;
                        });
                      },
                      itemBuilder: (context, index) => IgisakuzoWidget(
                        igisakuzo: viewModel.ibisakuzoIcumi[index],
                        navigationPop: viewModel.navigatePop,
                        showAbout: viewModel.showAboutDialog,
                        correctScore: viewModel.correctScore,
                        wrongScore: viewModel.wrongScore,
                        updateScore: viewModel.updateScore,
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
                              itemCount: viewModel.ibisakuzoIcumi.length,
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
                            title: 'Ibindi bisakuzo',
                            busy: viewModel.isBusy,
                            onTap: () async {
                              await viewModel.getIbisakuzo(widget.level);
                              setState(() {
                                _isLastPage = false;
                                _currentPage = 0;
                                _controller.jumpTo(0);
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

class IgisakuzoWidget extends StatelessWidget {
  final Igisakuzo igisakuzo;
  final VoidCallback navigationPop;
  final VoidCallback showAbout;
  final Function(bool) updateScore;
  final int correctScore;
  final int wrongScore;
  const IgisakuzoWidget({
    Key? key,
    required this.igisakuzo,
    required this.navigationPop,
    required this.showAbout,
    required this.correctScore,
    required this.wrongScore,
    required this.updateScore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: 200,
            maxHeight: 320,
          ),
          child: Container(
            color: Theme.of(context).primaryColor,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: navigationPop,
                      color: Theme.of(context).backgroundColor,
                      icon: const Icon(Icons.arrow_back),
                      splashColor: Theme.of(context).primaryColor,
                    ),
                    const Spacer(),
                    Icon(
                      Icons.check,
                      color: Theme.of(context).backgroundColor,
                    ),
                    horizontalSpaceSmall,
                    TextWiget.body(
                      correctScore.toString(),
                      color: Theme.of(context).backgroundColor,
                    ),
                    horizontalSpaceMedium,
                    Icon(
                      Icons.close,
                      color: Theme.of(context).errorColor,
                    ),
                    horizontalSpaceSmall,
                    TextWiget.body(
                      wrongScore.toString(),
                      color: Theme.of(context).backgroundColor,
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: showAbout,
                      color: Theme.of(context).backgroundColor,
                      icon: const Icon(Icons.info_outline),
                      splashColor: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: basePadding,
                      child: RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Sakwe Sakwe?\n\n',
                              style: headline2Style.apply(
                                color: Theme.of(context).backgroundColor,
                              ),
                            ),
                            TextSpan(
                              text: igisakuzo.question,
                              style: headline3Style.apply(
                                color: Theme.of(context).backgroundColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        verticalSpaceTiny,
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OptionWidget(
                optionText: igisakuzo.option1,
                correctAnswer: igisakuzo.correctAnswer,
                updateScore: updateScore,
              ),
              OptionWidget(
                optionText: igisakuzo.option2,
                correctAnswer: igisakuzo.correctAnswer,
                updateScore: updateScore,
              ),
              OptionWidget(
                optionText: igisakuzo.option3,
                correctAnswer: igisakuzo.correctAnswer,
                updateScore: updateScore,
              ),
              OptionWidget(
                optionText: igisakuzo.option4,
                correctAnswer: igisakuzo.correctAnswer,
                updateScore: updateScore,
              ),
            ],
          ),
        ),
        verticalSpaceTiny,
      ],
    );
  }
}

class OptionWidget extends StatefulWidget {
  final String optionText;
  final String correctAnswer;
  final Function(bool) updateScore;
  const OptionWidget({
    Key? key,
    required this.optionText,
    required this.correctAnswer,
    required this.updateScore,
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
            ? Theme.of(context).primaryColor
            : Theme.of(context).backgroundColor,
      ),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          primary: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        onPressed: () {
          setState(() {
            if (widget.optionText == widget.correctAnswer) {
              if (!_isCorrect && !_isWrong) {
                widget.updateScore(true);
                _isCorrect = true;
              }
            } else {
              if (!_isCorrect && !_isWrong) {
                widget.updateScore(false);
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
                child: TextWiget.body(
                  widget.optionText,
                  color: _isCorrect
                      ? Theme.of(context).backgroundColor
                      : _isWrong
                          ? Theme.of(context).errorColor
                          : Theme.of(context).primaryColor,
                ),
              ),
              horizontalSpaceTiny,
              _isCorrect
                  ? Icon(
                      Icons.check,
                      color: Theme.of(context).backgroundColor,
                      size: 16,
                    )
                  : _isWrong
                      ? Icon(
                          Icons.close,
                          color: Theme.of(context).errorColor,
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
