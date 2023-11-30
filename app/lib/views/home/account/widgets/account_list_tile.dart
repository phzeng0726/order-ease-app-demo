import 'package:flutter/material.dart';
import 'package:ordering_system_client_app/views/core/style/main.dart';

class AccountListTile extends StatelessWidget {
  const AccountListTile({
    super.key,
    this.label,
    required this.title,
    this.onTap,
    this.showDivider = true,
    this.showTrailing = true,
    this.trailing,
    this.leading,
    this.style,
    this.subList,
  });

  final String? label;
  final String title;
  final void Function()? onTap;
  final bool showDivider;
  final bool showTrailing;
  final Widget? leading;

  final Widget? trailing;
  final TextStyle? style;
  final List<dynamic>? subList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: leading,
          title: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: AppPaddingSize.compactVertical,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (label != null) ...[
                  Text(
                    label!,
                    style: AppTextStyle.smallText(color: ColorStyle.dimGrey),
                  ),
                ],
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    title,
                    style: AppTextStyle.heading5(),
                  ),
                )
              ],
            ),
          ),
          trailing: showTrailing
              ? trailing ??
                  const Icon(
                    Icons.lock,
                    size: 16.0,
                    color: ColorStyle.dimGrey,
                  )
              : null,
          visualDensity: const VisualDensity(vertical: -4.0),
          onTap: onTap,
        ),
        if (showDivider) ...[
          const Divider(
            color: ColorStyle.paleGrey,
          ),
        ],
      ],
    );
  }
}
