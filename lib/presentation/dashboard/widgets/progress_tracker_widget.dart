import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ProgressTrackerWidget extends StatefulWidget {
  final double currentAmount;
  final double targetAmount;

  const ProgressTrackerWidget({
    Key? key,
    required this.currentAmount,
    required this.targetAmount,
  }) : super(key: key);

  @override
  State<ProgressTrackerWidget> createState() => _ProgressTrackerWidgetState();
}

class _ProgressTrackerWidgetState extends State<ProgressTrackerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _progressAnimation;

  final List<Map<String, dynamic>> milestones = [
    {'name': 'Bronze', 'amount': 2500.0, 'color': Color(0xFFCD7F32)},
    {'name': 'Silver', 'amount': 5000.0, 'color': Color(0xFFC0C0C0)},
    {'name': 'Gold', 'amount': 10000.0, 'color': Color(0xFFFFD700)},
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _progressAnimation = Tween<double>(
      begin: 0,
      end: widget.currentAmount / widget.targetAmount,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  color: AppTheme.lightTheme.colorScheme.secondary
                      .withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: CustomIconWidget(
                  iconName: 'trending_up',
                  color: AppTheme.lightTheme.colorScheme.secondary,
                  size: 5.w,
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Progress Tracker',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    Text(
                      'Track your fundraising milestones',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppTheme
                                .lightTheme.colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          AnimatedBuilder(
            animation: _progressAnimation,
            builder: (context, child) {
              return Column(
                children: [
                  Container(
                    height: 12,
                    decoration: BoxDecoration(
                      color: AppTheme.lightTheme.colorScheme.outline
                          .withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Stack(
                      children: [
                        FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: _progressAnimation.value.clamp(0.0, 1.0),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFFEC4899), Color(0xFFF472B6)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                        // Milestone markers
                        ...milestones.map((milestone) {
                          final position = (milestone['amount'] as double) /
                              widget.targetAmount;
                          final isAchieved = widget.currentAmount >=
                              (milestone['amount'] as double);

                          return Positioned(
                            left: (position * 100).w - 1.5.w,
                            top: -1,
                            child: Container(
                              width: 3.w,
                              height: 14,
                              decoration: BoxDecoration(
                                color: isAchieved
                                    ? milestone['color'] as Color
                                    : AppTheme.lightTheme.colorScheme.outline,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color:
                                      AppTheme.lightTheme.colorScheme.surface,
                                  width: 2,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: milestones.map((milestone) {
                      final isAchieved = widget.currentAmount >=
                          (milestone['amount'] as double);

                      return Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 2.w, vertical: 1.h),
                            decoration: BoxDecoration(
                              color: isAchieved
                                  ? (milestone['color'] as Color)
                                      .withValues(alpha: 0.1)
                                  : AppTheme.lightTheme.colorScheme.outline
                                      .withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              milestone['name'] as String,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    color: isAchieved
                                        ? milestone['color'] as Color
                                        : AppTheme.lightTheme.colorScheme
                                            .onSurfaceVariant,
                                    fontWeight: isAchieved
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                                  ),
                            ),
                          ),
                          SizedBox(height: 0.5.h),
                          Text(
                            '₹${(milestone['amount'] as double).toStringAsFixed(0)}',
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                  color: AppTheme
                                      .lightTheme.colorScheme.onSurfaceVariant,
                                ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
