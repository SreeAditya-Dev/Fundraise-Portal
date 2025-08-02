import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class CampaignOversightWidget extends StatelessWidget {
  final List<Map<String, dynamic>> campaigns;

  const CampaignOversightWidget({
    Key? key,
    required this.campaigns,
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
                'Campaign Oversight',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: CustomIconWidget(
                  iconName: 'add_circle',
                  color: const Color(0xFFFF6B6B),
                  size: 5.w,
                ),
                label: Text(
                  'New Campaign',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: const Color(0xFFFF6B6B),
                      ),
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),

          // Campaign Cards
          Column(
            children: campaigns.map((campaign) {
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            campaign['name'],
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: CustomIconWidget(
                                iconName: 'visibility',
                                color: const Color(0xFF2196F3),
                                size: 5.w,
                              ),
                            ),
                            SizedBox(width: 2.w),
                            GestureDetector(
                              onTap: () {},
                              child: CustomIconWidget(
                                iconName: 'edit',
                                color: const Color(0xFFFF9800),
                                size: 5.w,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h),

                    // Progress Bar
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '₹${_formatNumber(campaign['raised'])} raised',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: const Color(0xFF4CAF50),
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                            Text(
                              '${campaign['progress'].toStringAsFixed(0)}%',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.h),
                        LinearProgressIndicator(
                          value: campaign['progress'] / 100,
                          backgroundColor: AppTheme
                              .lightTheme.colorScheme.outline
                              .withValues(alpha: 0.2),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            _getProgressColor(campaign['progress']),
                          ),
                          minHeight: 1.h,
                        ),
                      ],
                    ),

                    SizedBox(height: 1.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Target: ₹${_formatNumber(campaign['target'])}',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppTheme.lightTheme.colorScheme
                                        .onSurfaceVariant,
                                  ),
                        ),
                        Text(
                          '${campaign['participants']} participants',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppTheme.lightTheme.colorScheme
                                        .onSurfaceVariant,
                                  ),
                        ),
                      ],
                    ),

                    if (campaign['progress'] < 50)
                      Container(
                        margin: EdgeInsets.only(top: 1.h),
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.w, vertical: 0.5.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF9800).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(2.w),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomIconWidget(
                              iconName: 'warning',
                              color: const Color(0xFFFF9800),
                              size: 4.w,
                            ),
                            SizedBox(width: 1.w),
                            Text(
                              'Needs Attention',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    color: const Color(0xFFFF9800),
                                    fontWeight: FontWeight.w600,
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
        ],
      ),
    );
  }

  Color _getProgressColor(double progress) {
    if (progress >= 80) return const Color(0xFF4CAF50);
    if (progress >= 50) return const Color(0xFF2196F3);
    return const Color(0xFFFF9800);
  }

  String _formatNumber(double number) {
    if (number >= 100000) {
      return '${(number / 100000).toStringAsFixed(1)}L';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toStringAsFixed(0);
  }
}
