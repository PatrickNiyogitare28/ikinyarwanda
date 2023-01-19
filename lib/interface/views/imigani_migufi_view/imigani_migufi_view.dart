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
      onModelReady: (viewModel) => viewModel.getImigani(),
      builder: (context, viewModel, child) => Scaffold(
        body: viewModel.isBusy
            ? const CircularProgressWidget()
            : WebCenteredWidget(
                child: SafeArea(
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
                          'Imigani migufi',
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      verticalSpaceSmall,
                      Expanded(
                        child: ListView.separated(
                          separatorBuilder: (_, index) => Divider(
                            color: Theme.of(context).primaryColor,
                            indent: 25,
                            endIndent: 25,
                          ),
                          primary: true,
                          shrinkWrap: true,
                          itemCount: viewModel.imigani.length,
                          itemBuilder: (context, index) =>
                              CreationAwareListItem(
                            itemCreated: () {
                              SchedulerBinding.instance.addPostFrameCallback(
                                (duration) =>
                                    viewModel.handleItemCreated(index),
                              );
                            },
                            child: ListItem(title: viewModel.imigani[index]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final String title;
  const ListItem({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: basePadding,
      child: title == loadingIndicatorTitle
          ? CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(
                Theme.of(context).primaryColor,
              ),
              strokeWidth: 5,
            )
          : TextWiget.body(title),
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
