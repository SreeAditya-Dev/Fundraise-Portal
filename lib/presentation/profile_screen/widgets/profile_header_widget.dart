import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';

class ProfileHeaderWidget extends StatelessWidget {
  final Map<String, dynamic> userProfile;
  final String userRole;
  final Color roleColor;

  const ProfileHeaderWidget({
    Key? key,
    required this.userProfile,
    required this.userRole,
    required this.roleColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      padding: EdgeInsets.all(6.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [roleColor, roleColor.withValues(alpha: 0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(6.w),
        boxShadow: [
          BoxShadow(
            color: roleColor.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // Profile Image and Role Badge
          Stack(
            children: [
              CircleAvatar(
                radius: 12.w,
                backgroundImage: NetworkImage(userProfile['profileImage']),
                backgroundColor: Colors.white.withValues(alpha: 0.2),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(3.w),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    _getRoleBadge(),
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: roleColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 3.h),

          // User Info
          Text(
            userProfile['name'],
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 0.5.h),

          Text(
            userProfile['email'],
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.white.withValues(alpha: 0.9),
                ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 1.h),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(4.w),
            ),
            child: Text(
              userProfile['role'],
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),

          SizedBox(height: 2.h),

          // Join Date
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomIconWidget(
                iconName: 'calendar_today',
                color: Colors.white.withValues(alpha: 0.8),
                size: 4.w,
              ),
              SizedBox(width: 2.w),
              Text(
                'Joined ${userProfile['joinedDate']}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
              ),
            ],
          ),

          if (userRole == 'demo') ...[
            SizedBox(height: 2.h),
            Container(
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(3.w),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomIconWidget(
                    iconName: 'science',
                    color: Colors.white,
                    size: 5.w,
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    'DEMO ACCOUNT - Explore all features',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _getRoleBadge() {
    switch (userRole) {
      case 'admin':
        return 'ADMIN';
      case 'demo':
        return 'DEMO';
      default:
        return 'USER';
    }
  }
}
