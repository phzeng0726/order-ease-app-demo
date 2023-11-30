import 'package:flutter/material.dart';
import 'package:ordering_system_client_app/core/models/enums/load_status_enum.dart';
import 'package:ordering_system_client_app/views/core/style/main.dart';
import 'package:ordering_system_client_app/views/core/widgets/custom_app_bar_widget.dart';

class HomePageLayout extends StatelessWidget {
  const HomePageLayout({
    super.key,
    this.appBarTitle,
    this.actions,
    this.leading,
    required this.body,
    this.padding = kPagePadding,
    this.bottomNavigationBar,
    this.isScrollablePage = true,
    this.isCenterPage = false,
    this.status,
  });

  final String? appBarTitle;
  final List<Widget>? actions;
  final Widget? leading;
  final Widget body;
  final Widget? bottomNavigationBar;
  final EdgeInsetsGeometry padding;
  final bool isScrollablePage;
  final bool isCenterPage;
  final LoadStatus? status;

  @override
  Widget build(BuildContext context) {
    final Widget normalBody = Padding(
      padding: padding,
      child: Center(
        child: body,
      ),
    );

    final Widget scrollableBody = SingleChildScrollView(
      child: normalBody,
    );

    return Scaffold(
      appBar: appBarTitle == null
          ? null
          : pageLayoutAppBar(
              context,
              appBarTitle: appBarTitle ?? '',
              leading: leading,
              actions: actions,
            ),
      body: status == LoadStatus.succeed || status == null
          ? isScrollablePage
              ? isCenterPage
                  ? Center(child: scrollableBody)
                  : scrollableBody
              : isCenterPage
                  ? Center(child: normalBody)
                  : normalBody
          : const Center(
              child: CircularProgressIndicator(),
            ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
