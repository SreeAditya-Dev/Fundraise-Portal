import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class EmptyLeaderboardWidget extends StatelessWidget {
  const EmptyLeaderboardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 30.w,
            height: 30.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.lightTheme.colorScheme.primary
                  .withValues(alpha: 0.1),
            ),
            child: Center(
              child: CustomIconWidget(
                iconName: 'leaderboard',
                color: AppTheme.lightTheme.colorScheme.primary
                    .withValues(alpha: 0.5),
                size: 15.w,
              ),
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'No Rankings Yet',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).textTheme.titleLarge?.color,
                ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 2.h),
          Text(
            'Start fundraising to see your position on the leaderboard and compete with other interns!',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).textTheme.bodySmall?.color,
                ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4.h),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, '/dashboard');
            },
            icon: CustomIconWidget(
              iconName: 'trending_up',
              color: Colors.white,
              size: 5.w,
            ),
            label: Text(
              'Start Fundraising',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
