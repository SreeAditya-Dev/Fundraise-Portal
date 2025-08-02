import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class AnnouncementFilterWidget extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onCategorySelected;
  final List<String> categories;

  const AnnouncementFilterWidget({
    Key? key,
    required this.selectedCategory,
    required this.onCategorySelected,
    required this.categories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 6.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category == selectedCategory;

          return Container(
            margin: EdgeInsets.only(right: 2.w),
            child: FilterChip(
              label: Text(
                category,
                style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                  color: isSelected
                      ? AppTheme.lightTheme.colorScheme.onPrimary
                      : AppTheme.lightTheme.colorScheme.onSurface,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
              selected: isSelected,
              onSelected: (selected) {
                onCategorySelected(category);
              },
              backgroundColor: AppTheme.lightTheme.colorScheme.surface,
              selectedColor: AppTheme.lightTheme.colorScheme.primary,
              checkmarkColor: AppTheme.lightTheme.colorScheme.onPrimary,
              side: BorderSide(
                color: isSelected
                    ? AppTheme.lightTheme.colorScheme.primary
                    : AppTheme.lightTheme.colorScheme.outline,
                width: 1,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
            ),
          );
        },
      ),
    );
  }
}
