import 'package:flutter/material.dart';
import 'package:ordering_system_client_app/core/models/core/date_time_converter.dart';
import 'package:ordering_system_client_app/core/models/core/order_status_converter.dart';
import 'package:ordering_system_client_app/core/models/order_ticket_data.dart';
import 'package:ordering_system_client_app/views/core/style/main.dart';
import 'package:ordering_system_client_app/views/core/utils/app_localizations.dart';

class OrderTicketExpansionTile extends StatelessWidget {
  const OrderTicketExpansionTile({
    super.key,
    required this.orderTicket,
    this.onTap,
  });

  final OrderTicketData orderTicket;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    Widget _buildTitle() {
      final _orderStatus = OrderStatusConverter(orderTicket.orderStatus!);

      return Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.store,
                      size: 22.0,
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: orderTicket.storeName ?? 'Not Found',
                              style: AppTextStyle.heading4(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: ' #${orderTicket.id}',
                              style: AppTextStyle.smallText(
                                color: ColorStyle.dimGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  DateTimeConverter(orderTicket.createdAt!).toLocalTimeString(),
                  style: AppTextStyle.smallText(),
                ),
                const SizedBox(
                  height: 2,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: _orderStatus.toColor(),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  child: Text(
                    _orderStatus.toText(context),
                    style: AppTextStyle.smallText(),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  AppLocalizations.of(context)!.totalPrice,
                  style: AppTextStyle.text(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                FittedBox(
                  child: Text(
                    '\$ ${orderTicket.totalPrice?.toInt()}',
                    style: AppTextStyle.heading1(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      );
    }

    return Column(
      children: [
        ExpansionTile(
          childrenPadding: EdgeInsets.zero,
          tilePadding: EdgeInsets.symmetric(
            horizontal: kPagePadding.horizontal / 2,
            vertical: AppPaddingSize.compactVertical,
          ),
          shape: Border.all(
            color: Colors.transparent,
          ),
          title: _buildTitle(),
          children: [
            ...orderTicket.orderItems.map(
              (order) => Container(
                padding: EdgeInsets.symmetric(
                  horizontal: kPagePadding.horizontal / 2,
                  vertical: AppPaddingSize.compactVertical,
                ),
                child: Row(
                  children: [
                    Text(
                      '${order.quantity}',
                      style: AppTextStyle.heading4(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      ' × ${order.productName}',
                      style: AppTextStyle.heading5(),
                    ),
                    const Spacer(),
                    Text(
                      '\$ ${(order.productPrice * order.quantity).toInt()}',
                      style: AppTextStyle.heading5(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const Divider(
          color: ColorStyle.paleGrey,
        )
      ],
    );
  }
}
