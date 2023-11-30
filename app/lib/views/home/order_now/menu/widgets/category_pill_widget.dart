import 'package:flutter/material.dart';
import 'package:ordering_system_client_app/core/models/category_data.dart';
import 'package:ordering_system_client_app/views/core/style/main.dart';

class CategoryPillWidget extends StatelessWidget {
  const CategoryPillWidget({
    super.key,
    required this.category,
    required this.isSelected,
    this.onTap,
  });

  final CategoryData category;
  final bool isSelected;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    const borderRadius = BorderRadius.all(
      Radius.circular(25.0),
    );
    return Container(
      margin: const EdgeInsets.only(right: 8.0),
      child: Material(
        child: Ink(
          decoration: BoxDecoration(
            color: isSelected ? ColorStyle.orange : ColorStyle.white,
            borderRadius: borderRadius,
            border: Border.all(
              width: 1,
              color: isSelected ? ColorStyle.white : ColorStyle.orange,
            ),
          ),
          child: InkWell(
            borderRadius: borderRadius, // 水波紋圓角
            onTap: onTap,
            child: Container(
              margin: const EdgeInsets.symmetric(
                vertical: 2.0,
                horizontal: 16.0,
              ),
              height: 25.0,
              child: Center(
                child: Text(
                  category.title.toUpperCase(),
                  style: AppTextStyle.smallText(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
