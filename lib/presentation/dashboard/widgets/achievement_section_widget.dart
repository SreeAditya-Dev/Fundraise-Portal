import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class AchievementSectionWidget extends StatelessWidget {
  final List<Map<String, dynamic>> achievements;

  const AchievementSectionWidget({
    Key? key,
    required this.achievements,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Achievements',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/rewards-screen');
                  },
                  child: Text(
                    'View All',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: AppTheme.lightTheme.colorScheme.primary,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 1.h),
          SizedBox(
            height: 20.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 1.w),
              itemCount: achievements.length,
              itemBuilder: (context, index) {
                final achievement = achievements[index];
                return Container(
                  width: 35.w,
                  margin: EdgeInsets.only(right: 3.w),
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                    color: AppTheme.lightTheme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: (achievement['isUnlocked'] as bool)
                          ? AppTheme.lightTheme.colorScheme.primary
                              .withValues(alpha: 0.3)
                          : AppTheme.lightTheme.colorScheme.outline
                              .withValues(alpha: 0.2),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 12.w,
                        height: 12.w,
                        decoration: BoxDecoration(
                          color: (achievement['isUnlocked'] as bool)
                              ? AppTheme.lightTheme.colorScheme.primary
                                  .withValues(alpha: 0.1)
                              : AppTheme.lightTheme.colorScheme.outline
                                  .withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: CustomIconWidget(
                          iconName: achievement['icon'] as String,
                          color: (achievement['isUnlocked'] as bool)
                              ? AppTheme.lightTheme.colorScheme.primary
                              : AppTheme
                                  .lightTheme.colorScheme.onSurfaceVariant,
                          size: 6.w,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        achievement['title'] as String,
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: (achievement['isUnlocked'] as bool)
                                  ? AppTheme.lightTheme.colorScheme.onSurface
                                  : AppTheme
                                      .lightTheme.colorScheme.onSurfaceVariant,
                            ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        achievement['description'] as String,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: AppTheme
                                  .lightTheme.colorScheme.onSurfaceVariant,
                            ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (achievement['isUnlocked'] as bool) ...[
                        SizedBox(height: 1.h),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 2.w, vertical: 0.5.h),
                          decoration: BoxDecoration(
                            color: AppTheme.lightTheme.colorScheme.tertiary
                                .withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'Unlocked',
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                  color:
                                      AppTheme.lightTheme.colorScheme.tertiary,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
