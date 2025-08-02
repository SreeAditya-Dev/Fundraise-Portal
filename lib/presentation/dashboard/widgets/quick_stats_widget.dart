import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class QuickStatsWidget extends StatelessWidget {
  final Map<String, dynamic> stats;

  const QuickStatsWidget({
    Key? key,
    required this.stats,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> statItems = [
      {
        'title': 'Total Referrals',
        'value': stats['totalReferrals'].toString(),
        'icon': 'people',
        'color': AppTheme.lightTheme.colorScheme.primary,
      },
      {
        'title': 'Active Campaigns',
        'value': stats['activeCampaigns'].toString(),
        'icon': 'campaign',
        'color': AppTheme.lightTheme.colorScheme.secondary,
      },
      {
        'title': 'Completion Rate',
        'value': '${stats['completionRate']}%',
        'icon': 'check_circle',
        'color': AppTheme.lightTheme.colorScheme.tertiary,
      },
    ];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.w),
            child: Text(
              'Quick Stats',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          SizedBox(height: 2.h),
          Row(
            children: statItems.map((item) {
              return Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                    right: statItems.indexOf(item) < statItems.length - 1
                        ? 2.w
                        : 0,
                  ),
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color: AppTheme.lightTheme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppTheme.lightTheme.colorScheme.outline
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
                    children: [
                      Container(
                        width: 10.w,
                        height: 10.w,
                        decoration: BoxDecoration(
                          color:
                              (item['color'] as Color).withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: CustomIconWidget(
                          iconName: item['icon'] as String,
                          color: item['color'] as Color,
                          size: 5.w,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        item['value'] as String,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppTheme.lightTheme.colorScheme.onSurface,
                            ),
                      ),
                      SizedBox(height: 0.5.h),
                      Text(
                        item['title'] as String,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: AppTheme
                                  .lightTheme.colorScheme.onSurfaceVariant,
                            ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
