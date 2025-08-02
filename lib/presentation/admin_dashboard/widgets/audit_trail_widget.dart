import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class AuditTrailWidget extends StatelessWidget {
  final List<Map<String, dynamic>> auditTrail;

  const AuditTrailWidget({
    Key? key,
    required this.auditTrail,
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
                'Audit Trail',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'View All',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: const Color(0xFFFF6B6B),
                      ),
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),

          // Audit Trail List
          Column(
            children: auditTrail.take(3).map((audit) {
              return Container(
                margin: EdgeInsets.only(bottom: 2.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 10.w,
                      height: 10.w,
                      decoration: BoxDecoration(
                        color: _getActionColor(audit['action'])
                            .withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(5.w),
                      ),
                      child: Icon(
                        _getActionIcon(audit['action']),
                        color: _getActionColor(audit['action']),
                        size: 5.w,
                      ),
                    ),
                    SizedBox(width: 3.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                audit['action'],
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              Text(
                                audit['timestamp'],
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: AppTheme.lightTheme.colorScheme
                                          .onSurfaceVariant,
                                    ),
                              ),
                            ],
                          ),
                          SizedBox(height: 0.5.h),
                          Text(
                            audit['details'],
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AppTheme.lightTheme.colorScheme
                                          .onSurfaceVariant,
                                    ),
                          ),
                          SizedBox(height: 0.5.h),
                          Text(
                            'by ${audit['user']}',
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                  color: const Color(0xFFFF6B6B),
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),

          // Security Notice
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
                  iconName: 'security',
                  color: const Color(0xFF9C27B0),
                  size: 5.w,
                ),
                SizedBox(width: 2.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Secure Audit Logging',
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF9C27B0),
                                ),
                      ),
                      Text(
                        'All admin actions are logged with timestamps and user attribution for security compliance.',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: const Color(0xFF9C27B0),
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getActionColor(String action) {
    switch (action.toLowerCase()) {
      case 'user approved':
        return const Color(0xFF4CAF50);
      case 'campaign created':
        return const Color(0xFF2196F3);
      case 'announcement published':
        return const Color(0xFFFF9800);
      default:
        return const Color(0xFF9C27B0);
    }
  }

  IconData _getActionIcon(String action) {
    switch (action.toLowerCase()) {
      case 'user approved':
        return Icons.person_add;
      case 'campaign created':
        return Icons.campaign;
      case 'announcement published':
        return Icons.announcement;
      default:
        return Icons.admin_panel_settings;
    }
  }
}
