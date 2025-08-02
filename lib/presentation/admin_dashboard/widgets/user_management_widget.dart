import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class UserManagementWidget extends StatelessWidget {
  final List<Map<String, dynamic>> recentInterns;

  const UserManagementWidget({
    Key? key,
    required this.recentInterns,
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
                'User Management',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: CustomIconWidget(
                  iconName: 'person_add',
                  color: const Color(0xFFFF6B6B),
                  size: 5.w,
                ),
                label: Text(
                  'Add User',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: const Color(0xFFFF6B6B),
                      ),
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),

          // Recent Interns List
          Column(
            children: recentInterns.map((intern) {
              return Container(
                margin: EdgeInsets.only(bottom: 2.h),
                padding: EdgeInsets.all(3.w),
                decoration: BoxDecoration(
                  color:
                      AppTheme.lightTheme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(3.w),
                  border: Border.all(
                    color: AppTheme.lightTheme.colorScheme.outline
                        .withValues(alpha: 0.2),
                  ),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 6.w,
                      backgroundColor:
                          const Color(0xFFFF6B6B).withValues(alpha: 0.1),
                      child: Text(
                        intern['name'].toString().substring(0, 1).toUpperCase(),
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: const Color(0xFFFF6B6B),
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ),
                    SizedBox(width: 3.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            intern['name'],
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          Text(
                            intern['email'],
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AppTheme.lightTheme.colorScheme
                                          .onSurfaceVariant,
                                    ),
                          ),
                          Text(
                            'Raised: ₹${intern['raised']}',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: const Color(0xFF4CAF50),
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 2.w, vertical: 0.5.h),
                          decoration: BoxDecoration(
                            color: intern['status'] == 'Active'
                                ? const Color(0xFF4CAF50).withValues(alpha: 0.1)
                                : const Color(0xFFFF9800)
                                    .withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(2.w),
                          ),
                          child: Text(
                            intern['status'],
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                  color: intern['status'] == 'Active'
                                      ? const Color(0xFF4CAF50)
                                      : const Color(0xFFFF9800),
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: CustomIconWidget(
                                iconName: 'edit',
                                color: const Color(0xFF2196F3),
                                size: 5.w,
                              ),
                            ),
                            SizedBox(width: 2.w),
                            GestureDetector(
                              onTap: () {},
                              child: CustomIconWidget(
                                iconName: 'delete',
                                color: const Color(0xFFF44336),
                                size: 5.w,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),

          // View All Button
          Center(
            child: TextButton(
              onPressed: () {},
              child: Text(
                'View All Users',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: const Color(0xFFFF6B6B),
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
