import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ordering_system_client_app/core/controllers/order_watcher/order_watcher_bloc.dart';
import 'package:ordering_system_client_app/views/core/screen/home_page_layout.dart';
import 'package:ordering_system_client_app/views/core/utils/app_localizations.dart';
import 'package:ordering_system_client_app/views/home/order_history/widgets/order_ticket_expansion_tile.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderWatcherBloc, OrderWatcherState>(
      builder: (context, state) {
        return HomePageLayout(
          appBarTitle: AppLocalizations.of(context)!.orderHistoryTitle,
          padding: EdgeInsets.zero,
          status: state.status,
          isCenterPage: state.orderTicketList.isEmpty,
          body: state.orderTicketList.isEmpty
              ? Text(
                  AppLocalizations.of(context)!.emptyOrderHistoryContent,
                )
              : Column(
                  children: state.orderTicketList
                      .map(
                        (orderTicket) => OrderTicketExpansionTile(
                          orderTicket: orderTicket,
                        ),
                      )
                      .toList(),
                ),
        );
      },
    );
  }
}
