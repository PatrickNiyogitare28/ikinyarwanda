import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:ikinyarwanda/interface/widgets/text_widget.dart';
import 'package:ikinyarwanda/interface/widgets/web_centered_widget.dart';
import 'package:stacked/stacked.dart';

import 'package:ikinyarwanda/shared/ui_helpers.dart';
import 'package:ikinyarwanda/interface/widgets/circular_progress_widget.dart';

import 'imigani_migufi_view_model.dart';

class ImiganiMigufiView extends StatelessWidget {
  const ImiganiMigufiView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ImiganiMigufiViewModel>.reactive(
      viewModelBuilder: () => ImiganiMigufiViewModel(),
      onViewModelReady: (viewModel) => viewModel.getImigani(),
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
              'Imigani migufi',
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
        body: viewModel.isBusy
            ? const CircularProgressWidget()
            : WebCenteredWidget(
                child: ListView.separated(
                  separatorBuilder: (_, index) => Divider(
                    indent: 25,
                    endIndent: 25,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  primary: true,
                  shrinkWrap: true,
                  itemCount: viewModel.imigani.length,
                  itemBuilder: (context, index) => CreationAwareListItem(
                    itemCreated: () {
                      SchedulerBinding.instance.addPostFrameCallback(
                        (duration) => viewModel.handleItemCreated(index),
                      );
                    },
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: basePadding,
                      child: viewModel.imigani[index] == loadingIndicatorTitle
                          ? const CircularProgressWidget()
                          : TextWidget.body(
                              viewModel.imigani[index],
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}

class CreationAwareListItem extends StatefulWidget {
  final Function? itemCreated;
  final Widget child;
  const CreationAwareListItem({
    Key? key,
    this.itemCreated,
    required this.child,
  }) : super(key: key);

  @override
  _CreationAwareListItemState createState() => _CreationAwareListItemState();
}

class _CreationAwareListItemState extends State<CreationAwareListItem> {
  @override
  void initState() {
    super.initState();
    if (widget.itemCreated != null) {
      widget.itemCreated!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
