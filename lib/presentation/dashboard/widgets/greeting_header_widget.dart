import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class GreetingHeaderWidget extends StatelessWidget {
  final String userName;
  final String profileImageUrl;

  const GreetingHeaderWidget({
    Key? key,
    required this.userName,
    required this.profileImageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: Row(
        children: [
          Container(
            width: 12.w,
            height: 12.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppTheme.lightTheme.colorScheme.primary,
                width: 2,
              ),
            ),
            child: ClipOval(
              child: CustomImageWidget(
                imageUrl: profileImageUrl,
                width: 12.w,
                height: 12.w,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Good ${_getTimeOfDay()}!',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                      ),
                ),
                SizedBox(height: 0.5.h),
                Text(
                  userName,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.lightTheme.colorScheme.onSurface,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(2.w),
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.primary
                  .withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: CustomIconWidget(
              iconName: 'notifications',
              color: AppTheme.lightTheme.colorScheme.primary,
              size: 6.w,
            ),
          ),
        ],
      ),
    );
  }

  String _getTimeOfDay() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Morning';
    } else if (hour < 17) {
      return 'Afternoon';
    } else {
      return 'Evening';
    }
  }
}
