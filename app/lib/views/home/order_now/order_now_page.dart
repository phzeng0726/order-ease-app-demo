import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ordering_system_client_app/configurations.dart';
import 'package:ordering_system_client_app/core/controllers/menu_watcher/menu_watcher_bloc.dart';
import 'package:ordering_system_client_app/core/controllers/order_form/order_form_bloc.dart';
import 'package:ordering_system_client_app/core/controllers/user_watcher/user_watcher_bloc.dart';
import 'package:ordering_system_client_app/core/models/enums/load_status_enum.dart';
import 'package:ordering_system_client_app/core/models/menu_data.dart';
import 'package:ordering_system_client_app/views/core/screen/home_page_layout.dart';
import 'package:ordering_system_client_app/views/core/style/main.dart';
import 'package:ordering_system_client_app/views/core/utils/app_localizations.dart';
import 'package:ordering_system_client_app/views/core/utils/app_screen_util.dart';
import 'package:ordering_system_client_app/views/core/widgets/custom_dialog.dart';
import 'package:ordering_system_client_app/views/core/widgets/loading_overlay.dart';
import 'package:ordering_system_client_app/views/routes/go_router.dart';

class OrderNowPage extends StatelessWidget {
  const OrderNowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        // QRCode掃到storeSeatId，以id抓menu
        BlocListener<MenuWatcherBloc, MenuWatcherState>(
          listenWhen: (p, c) =>
              p.storeSeatId != c.storeSeatId && c.storeSeatId != '',
          listener: (context, state) {
            context.read<MenuWatcherBloc>().add(
                  const FetchMenuEvent(
                    languageId: languageId,
                  ),
                );
          },
        ),
        // 抓到Menu，將資料傳到OrderFormBloc
        BlocListener<MenuWatcherBloc, MenuWatcherState>(
          listenWhen: (p, c) => p.status != c.status,
          listener: (context, state) {
            AppScreenUtil.mapLoadStatus(
              state.status,
              initial: () {},
              inProgress: () => LoadingOverlay.show(context),
              succeed: () {
                LoadingOverlay.hide();

                context.read<OrderFormBloc>().add(
                      InitialEvent(
                        userId: context.read<UserWatcherBloc>().state.user.id!,
                        seatId: int.parse(state.storeSeatId.split('_')[1]),
                        menu: state.menu,
                      ),
                    );
              },
              failed: () => showErrorDialog(
                context,
                contentOption: state.failureOption,
              ),
            );
          },
        ),
        // 傳遞成功後跳轉頁面
        BlocListener<OrderFormBloc, OrderFormState>(
          listenWhen: (p, c) =>
              p.menu != c.menu &&
              c.menu != MenuData.empty() &&
              c.status != LoadStatus.inProgress,
          listener: (context, state) {
            context.goNamed((AppRoutes.menu.toName));
          },
        ),
      ],
      child: BlocBuilder<MenuWatcherBloc, MenuWatcherState>(
        builder: (context, state) {
          return HomePageLayout(
            appBarTitle: AppLocalizations.of(context)!.homeTitle,
            isCenterPage: true,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  onPressed: () => context.pushNamed(AppRoutes.qrScan.toName),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.qr_code_scanner,
                          size: 50.0,
                        ),
                        const SizedBox(
                          height: 6.0,
                        ),
                        Text(
                          AppLocalizations.of(context)!.orderNow,
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 60.0,
                ),
                Text(
                  AppLocalizations.of(context)!.clickScanQrCodeButtonHint,
                  style: AppTextStyle.text(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
