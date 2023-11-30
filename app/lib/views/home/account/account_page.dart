import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ordering_system_client_app/core/controllers/menu_watcher/menu_watcher_bloc.dart';
import 'package:ordering_system_client_app/core/controllers/user_actor/user_actor_bloc.dart';
import 'package:ordering_system_client_app/core/controllers/user_watcher/user_watcher_bloc.dart';
import 'package:ordering_system_client_app/core/models/enums/auth_status_enum.dart';
import 'package:ordering_system_client_app/core/models/user_data.dart';
import 'package:ordering_system_client_app/core/repos/auth_repository.dart';
import 'package:ordering_system_client_app/core/repos/firebase_facade.dart';
import 'package:ordering_system_client_app/views/core/functions/auth_functions.dart';
import 'package:ordering_system_client_app/views/core/screen/home_page_layout.dart';
import 'package:ordering_system_client_app/views/core/style/main.dart';
import 'package:ordering_system_client_app/views/core/utils/app_localizations.dart';
import 'package:ordering_system_client_app/views/core/utils/app_screen_util.dart';
import 'package:ordering_system_client_app/views/core/widgets/custom_dialog.dart';
import 'package:ordering_system_client_app/views/core/widgets/loading_overlay.dart';
import 'package:ordering_system_client_app/views/home/account/widgets/account_list_tile.dart';
import 'package:ordering_system_client_app/views/routes/go_router.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final UserData user = context.read<UserWatcherBloc>().state.user;

    return BlocProvider(
      create: (context) => UserActorBloc(
        context.read<AuthRepository>(),
        context.read<FirebaseFacade>(),
      ),
      child: MultiBlocListener(
        listeners: [
          // 刪除帳號，刪除成功的話呼叫登出
          BlocListener<UserActorBloc, UserActorState>(
            listenWhen: (p, c) => p.status != c.status,
            listener: (context, state) {
              AppScreenUtil.mapLoadStatus(
                state.status,
                initial: () {},
                inProgress: () => LoadingOverlay.show(context),
                succeed: () {
                  LoadingOverlay.hide();

                  context.read<UserWatcherBloc>().add(const LogoutEvent());
                },
                failed: () => showErrorDialog(
                  context,
                  contentOption: state.failureOption,
                ),
              );
            },
          ),
          // 登出/帳號刪除成功
          BlocListener<UserWatcherBloc, UserWatcherState>(
            listenWhen: (p, c) =>
                p.authStatus != c.authStatus &&
                c.authStatus == AuthStatus.unauthenticated,
            listener: (context, state) async {
              await userUnAuthFunction(context).whenComplete(
                () => context.goNamed(AppRoutes.auth.toName),
              );
            },
          ),
        ],
        child: BlocBuilder<MenuWatcherBloc, MenuWatcherState>(
          builder: (context, state) {
            return HomePageLayout(
              appBarTitle: AppLocalizations.of(context)!.accountTitle,
              padding: EdgeInsets.zero,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AccountListTile(
                    label: AppLocalizations.of(context)!.email,
                    title: user.email,
                  ),
                  AccountListTile(
                    label: AppLocalizations.of(context)!.lastName,
                    title: user.lastName,
                    showDivider: false,
                  ),
                  AccountListTile(
                    label: AppLocalizations.of(context)!.firstName,
                    title: user.firstName,
                    showDivider: false,
                  ),
                  const Divider(
                    color: ColorStyle.paleGrey,
                    thickness: 6.0,
                  ),
                  Column(
                    children: _buildLogoutAndDeleteUser(
                      context,
                      userId: user.id,
                    ),
                  ),
                  const Divider(
                    color: ColorStyle.paleGrey,
                    thickness: 6.0,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  List<Widget> _buildLogoutAndDeleteUser(
    BuildContext context, {
    String? userId,
  }) {
    late List<Widget> widgetList;

    if (context.read<UserWatcherBloc>().state.isAnonymousUser) {
      widgetList = [
        // 登出並刪除帳號
        AccountListTile(
          leading: const Icon(
            Icons.delete_forever,
            color: ColorStyle.dimGrey,
          ),
          title: AppLocalizations.of(context)!.deleteAndLogoutAccount,
          showTrailing: false,
          onTap: () => showActionDialog(
            context,
            title: AppLocalizations.of(context)!.deleteAccountDialogTitle,
            content: AppLocalizations.of(context)!.deleteAccountDialogContent,
            leftOnPressed: () => context.pop(),
            leftTitle: AppLocalizations.of(context)!.back,
            rightOnPressed: () {
              context.pop();
              context.read<UserActorBloc>().add(
                    const DeleteAnonymousUserEvent(),
                  );
            },
            rightTitle: AppLocalizations.of(context)!.delete,
          ),
          showDivider: false,
        ),
      ];
    } else {
      widgetList = [
        // 刪除帳號
        AccountListTile(
          leading: const Icon(
            Icons.delete_forever,
            color: ColorStyle.dimGrey,
          ),
          title: AppLocalizations.of(context)!.deleteAccount,
          showTrailing: false,
          onTap: () => showActionDialog(
            context,
            title: AppLocalizations.of(context)!.deleteAccountDialogTitle,
            content: AppLocalizations.of(context)!.deleteAccountDialogContent,
            leftOnPressed: () => context.pop(),
            leftTitle: AppLocalizations.of(context)!.back,
            rightOnPressed: () {
              context.pop();
              context.read<UserActorBloc>().add(
                    DeleteUserEvent(
                      userId: userId!,
                    ),
                  );
            },
            rightTitle: AppLocalizations.of(context)!.delete,
          ),
        ),
        // 登出
        AccountListTile(
          leading: const Icon(
            Icons.logout,
            color: ColorStyle.dimGrey,
          ),
          title: AppLocalizations.of(context)!.logout,
          showTrailing: false,
          onTap: () => context.read<UserWatcherBloc>().add(
                const LogoutEvent(),
              ),
          showDivider: false,
        ),
      ];
    }

    return widgetList;
  }
}
