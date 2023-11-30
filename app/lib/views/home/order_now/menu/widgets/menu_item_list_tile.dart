import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ordering_system_client_app/core/controllers/order_form/order_form_bloc.dart';
import 'package:ordering_system_client_app/core/models/menu_item_data.dart';
import 'package:ordering_system_client_app/views/core/style/main.dart';

class MenuItemListTile extends StatelessWidget {
  const MenuItemListTile({
    super.key,
    required this.menuItem,
  });

  final MenuItemData menuItem;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderFormBloc, OrderFormState>(
      builder: (context, state) {
        return Container(
          margin: kWidgetPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: kWidgetPadding,
                child: Row(
                  children: [
                    Expanded(
                      child: _buildProductImage(context),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: kWidgetPadding,
                        child: Column(
                          children: [
                            Text(
                              menuItem.title,
                              style: AppTextStyle.heading4(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Text(
                              '\$ ${menuItem.price.toString()}',
                              style: AppTextStyle.heading4(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: _buildQuantityButtonWidget(context, state),
                    ),
                  ],
                ),
              ),
              const Divider(
                thickness: 1.1,
                color: ColorStyle.paleGrey,
              )
            ],
          ),
        );
      },
    );
  }

  ClipRRect _buildProductImage(
    BuildContext context,
  ) {
    final double imageWidth = MediaQuery.of(context).size.width / 5;
    final double imageHeight = MediaQuery.of(context).size.width / 5;

    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: menuItem.imageBytes == null
          ? Image.asset(
              'assets/images/add_picture.png',
              fit: BoxFit.cover,
              width: imageWidth,
              height: imageHeight,
            )
          : Image.memory(
              menuItem.imageBytes!,
              fit: BoxFit.cover,
              width: imageWidth,
              height: imageHeight,
            ),
    );
  }

  Widget _buildQuantityButtonWidget(
    BuildContext context,
    OrderFormState state,
  ) {
    const borderRadius = BorderRadius.all(
      Radius.circular(25.0),
    );

    return Container(
      decoration: BoxDecoration(
        color: ColorStyle.white,
        borderRadius: borderRadius,
        border: Border.all(
          width: 1,
          color: ColorStyle.orange,
        ),
      ),
      height: 40.0,
      child: FittedBox(
        child: Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.remove,
                color: state.orderItemMap[menuItem] == 0
                    ? ColorStyle.lightGrey
                    : ColorStyle.orange,
              ),
              onPressed: () => context.read<OrderFormBloc>().add(
                    RemoveOrderItemEvent(
                      menuItem: menuItem,
                    ),
                  ),
            ),
            Text(
              state.orderItemMap[menuItem].toString(),
              style: AppTextStyle.heading2(
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.add,
                color: ColorStyle.orange,
              ),
              onPressed: () => context.read<OrderFormBloc>().add(
                    AddOrderItemEvent(
                      menuItem: menuItem,
                    ),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
