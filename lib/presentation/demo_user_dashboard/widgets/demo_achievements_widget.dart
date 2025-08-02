import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class DemoAchievementsWidget extends StatelessWidget {
  final List<Map<String, dynamic>> achievements;

  const DemoAchievementsWidget({
    Key? key,
    required this.achievements,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(4.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Demo Achievements',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(2.w),
                ),
                child: Text(
                  'Sample Data',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: const Color(0xFF4CAF50),
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),

          // Achievements Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 3.w,
              mainAxisSpacing: 2.h,
              childAspectRatio: 1.2,
            ),
            itemCount: achievements.length,
            itemBuilder: (context, index) {
              final achievement = achievements[index];
              return _buildAchievementCard(context, achievement);
            },
          ),

          SizedBox(height: 2.h),

          // Demo Info
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              color: const Color(0xFFF3E5F5),
              borderRadius: BorderRadius.circular(3.w),
              border: Border.all(
                color: const Color(0xFF9C27B0).withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              children: [
                CustomIconWidget(
                  iconName: 'info',
                  color: const Color(0xFF9C27B0),
                  size: 5.w,
                ),
                SizedBox(width: 2.w),
                Expanded(
                  child: Text(
                    'These achievements showcase the gamification features. Real users earn badges through actual fundraising activities.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: const Color(0xFF9C27B0),
                        ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementCard(
      BuildContext context, Map<String, dynamic> achievement) {
    final isUnlocked = achievement['isUnlocked'] as bool;

    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: isUnlocked
            ? const Color(0xFF4CAF50).withValues(alpha: 0.1)
            : AppTheme.lightTheme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(3.w),
        border: Border.all(
          color: isUnlocked
              ? const Color(0xFF4CAF50).withValues(alpha: 0.3)
              : AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomIconWidget(
                iconName: achievement['icon'],
                color: isUnlocked ? const Color(0xFF4CAF50) : Colors.grey,
                size: 8.w,
              ),
              if (isUnlocked)
                Container(
                  padding: EdgeInsets.all(1.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4CAF50),
                    borderRadius: BorderRadius.circular(1.w),
                  ),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 3.w,
                  ),
                ),
            ],
          ),
          SizedBox(height: 1.h),
          Column(
            children: [
              Text(
                achievement['title'],
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isUnlocked ? const Color(0xFF4CAF50) : Colors.grey,
                    ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 0.5.h),
              Text(
                achievement['description'],
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: isUnlocked
                          ? AppTheme.lightTheme.colorScheme.onSurface
                          : Colors.grey,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
