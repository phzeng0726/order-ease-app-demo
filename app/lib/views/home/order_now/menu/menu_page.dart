import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ordering_system_client_app/core/controllers/order_form/order_form_bloc.dart';
import 'package:ordering_system_client_app/core/controllers/order_watcher/order_watcher_bloc.dart';
import 'package:ordering_system_client_app/core/controllers/user_watcher/user_watcher_bloc.dart';
import 'package:ordering_system_client_app/views/core/screen/home_page_layout.dart';
import 'package:ordering_system_client_app/views/core/style/main.dart';
import 'package:ordering_system_client_app/views/core/utils/app_localizations.dart';
import 'package:ordering_system_client_app/views/core/utils/app_screen_util.dart';
import 'package:ordering_system_client_app/views/core/widgets/custom_dialog.dart';
import 'package:ordering_system_client_app/views/core/widgets/loading_overlay.dart';
import 'package:ordering_system_client_app/views/home/order_now/menu/widgets/category_pill_widget.dart';
import 'package:ordering_system_client_app/views/home/order_now/menu/widgets/menu_item_list_tile.dart';
import 'package:ordering_system_client_app/views/routes/go_router.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderFormBloc, OrderFormState>(
      listenWhen: (p, c) => p.status != c.status,
      listener: (context, state) {
        AppScreenUtil.whenLoadStatus(
          state.status,
          initial: () {},
          inProgress: () => LoadingOverlay.show(context),
          succeed: () => showSuccessDialog(
            context,
            title: AppLocalizations.of(context)!.menuCreatedDialogTitle,
            content: AppLocalizations.of(context)!.menuCreatedDialogContent,
            buttonTitle: AppLocalizations.of(context)!.menuCreatedDialogTitle,
            onPressed: () {
              context.read<OrderWatcherBloc>().add(
                    FetchOrderHistoryEvent(
                      userId: context.read<UserWatcherBloc>().state.user.id!,
                    ),
                  );

              context
                ..pop()
                ..goNamed(AppRoutes.orderHistory.toName);
            },
          ),
          failed: () => showErrorDialog(
            context,
            contentOption: state.failureOption,
          ),
        );
      },
      child: BlocBuilder<OrderFormBloc, OrderFormState>(
        builder: (context, state) {
          return HomePageLayout(
            appBarTitle:
                '${AppLocalizations.of(context)!.onlineOrderingTitle} - ${state.menu.store.name}',
            isScrollablePage: false,
            padding: EdgeInsets.zero,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: kPagePadding,
                  child: _buildCategoryListWidget(context, state),
                ),
                Expanded(
                  child: _buildMenuItemListViewWidget(context, state),
                ),
                Padding(
                  padding: kPagePadding,
                  child: _buildCheckoutWidget(context, state),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategoryListWidget(
    BuildContext context,
    OrderFormState state,
  ) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          state.categoryList.length,
          (index) => CategoryPillWidget(
            category: state.categoryList[index],
            isSelected: state.selectedCategoryIndex == index,
            onTap: () => context.read<OrderFormBloc>().add(
                  ChangeWatchingCategoryEvent(
                    index: index,
                  ),
                ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItemListViewWidget(
    BuildContext context,
    OrderFormState state,
  ) {
    return SingleChildScrollView(
      child: Column(
        children: state.filteredMenuItemList
            .map(
              (menuItem) => MenuItemListTile(
                menuItem: menuItem,
              ),
            )
            .toList(),
      ),
    );
  }

  Column _buildCheckoutWidget(
    BuildContext context,
    OrderFormState state,
  ) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalizations.of(context)!.totalPrice,
              style: AppTextStyle.heading4(
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '\$ ${state.totalPrice.toInt()}',
              style: AppTextStyle.heading4(
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              splashFactory: NoSplash.splashFactory,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              elevation: 0.0,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  12.0,
                ),
              ),
            ),
            onPressed: state.orderTicket.orderItems.isEmpty
                ? null
                : () => context.read<OrderFormBloc>().add(
                      const CreateOrderTicketEvent(),
                    ),
            child: Text(
              AppLocalizations.of(context)!.placeOrder,
            ),
          ),
        ),
      ],
    );
  }
}
