import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class LeaderboardCardWidget extends StatelessWidget {
  final Map<String, dynamic> intern;
  final int rank;
  final bool isCurrentUser;

  const LeaderboardCardWidget({
    Key? key,
    required this.intern,
    required this.rank,
    this.isCurrentUser = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: _getRankGradient(),
        border: isCurrentUser
            ? Border.all(
                color: AppTheme.lightTheme.colorScheme.secondary,
                width: 2,
              )
            : null,
        boxShadow: [
          BoxShadow(
            color: isCurrentUser
                ? AppTheme.lightTheme.colorScheme.secondary
                    .withValues(alpha: 0.3)
                : Colors.black.withValues(alpha: 0.1),
            blurRadius: isCurrentUser ? 12 : 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Container(
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(context).cardColor,
        ),
        child: Row(
          children: [
            _buildRankBadge(),
            SizedBox(width: 3.w),
            _buildAvatar(),
            SizedBox(width: 4.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          (intern['name'] as String? ?? 'Unknown'),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: isCurrentUser
                                    ? AppTheme.lightTheme.colorScheme.secondary
                                    : null,
                              ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (isCurrentUser)
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 2.w, vertical: 0.5.h),
                          decoration: BoxDecoration(
                            color: AppTheme.lightTheme.colorScheme.secondary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'You',
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    '₹${_formatAmount(intern['totalRaised'] as double? ?? 0.0)}',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppTheme.lightTheme.colorScheme.primary,
                        ),
                  ),
                  SizedBox(height: 1.h),
                  _buildProgressIndicator(),
                ],
              ),
            ),
            SizedBox(width: 2.w),
            _buildRankChangeIndicator(),
          ],
        ),
      ),
    );
  }

  Widget _buildRankBadge() {
    return Container(
      width: 12.w,
      height: 12.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: _getRankBadgeGradient(),
        boxShadow: [
          BoxShadow(
            color: _getRankColor().withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: rank <= 3
            ? CustomIconWidget(
                iconName: _getTrophyIcon(),
                color: Colors.white,
                size: 6.w,
              )
            : Text(
                '$rank',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
      ),
    );
  }

  Widget _buildAvatar() {
    final String? avatarUrl = intern['avatar'] as String?;
    final String name = intern['name'] as String? ?? 'U';

    return Container(
      width: 14.w,
      height: 14.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            AppTheme.lightTheme.colorScheme.primary,
            AppTheme.lightTheme.colorScheme.secondary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: avatarUrl != null && avatarUrl.isNotEmpty
          ? ClipOval(
              child: CustomImageWidget(
                imageUrl: avatarUrl,
                width: 14.w,
                height: 14.w,
                fit: BoxFit.cover,
              ),
            )
          : Center(
              child: Text(
                name.isNotEmpty ? name[0].toUpperCase() : 'U',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
    );
  }

  Widget _buildProgressIndicator() {
    final double progress =
        (intern['progressPercentage'] as double? ?? 0.0) / 100;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Progress to next milestone',
              style: TextStyle(
                fontSize: 10.sp,
                color: Colors.grey[600],
              ),
            ),
            Text(
              '${(intern['progressPercentage'] as double? ?? 0.0).toInt()}%',
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
                color: AppTheme.lightTheme.colorScheme.primary,
              ),
            ),
          ],
        ),
        SizedBox(height: 0.5.h),
        Container(
          height: 0.8.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color:
                AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.3),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: progress.clamp(0.0, 1.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                gradient: LinearGradient(
                  colors: [
                    AppTheme.lightTheme.colorScheme.primary,
                    AppTheme.lightTheme.colorScheme.secondary,
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRankChangeIndicator() {
    final int rankChange = intern['rankChange'] as int? ?? 0;

    if (rankChange == 0) {
      return Container(
        padding: EdgeInsets.all(2.w),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey.withValues(alpha: 0.2),
        ),
        child: CustomIconWidget(
          iconName: 'remove',
          color: Colors.grey,
          size: 4.w,
        ),
      );
    }

    final bool isPositive = rankChange > 0;
    final Color changeColor = isPositive ? Colors.green : Colors.red;

    return Container(
      padding: EdgeInsets.all(2.w),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: changeColor.withValues(alpha: 0.1),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomIconWidget(
            iconName: isPositive ? 'keyboard_arrow_up' : 'keyboard_arrow_down',
            color: changeColor,
            size: 4.w,
          ),
          Text(
            '${rankChange.abs()}',
            style: TextStyle(
              fontSize: 8.sp,
              fontWeight: FontWeight.w600,
              color: changeColor,
            ),
          ),
        ],
      ),
    );
  }

  LinearGradient? _getRankGradient() {
    if (!isCurrentUser) return null;

    return LinearGradient(
      colors: [
        AppTheme.lightTheme.colorScheme.secondary.withValues(alpha: 0.1),
        AppTheme.lightTheme.colorScheme.primary.withValues(alpha: 0.1),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  LinearGradient _getRankBadgeGradient() {
    switch (rank) {
      case 1:
        return const LinearGradient(
          colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 2:
        return const LinearGradient(
          colors: [Color(0xFFC0C0C0), Color(0xFF808080)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 3:
        return const LinearGradient(
          colors: [Color(0xFFCD7F32), Color(0xFF8B4513)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      default:
        return LinearGradient(
          colors: [
            AppTheme.lightTheme.colorScheme.primary,
            AppTheme.lightTheme.colorScheme.primaryContainer,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
    }
  }

  Color _getRankColor() {
    switch (rank) {
      case 1:
        return const Color(0xFFFFD700);
      case 2:
        return const Color(0xFFC0C0C0);
      case 3:
        return const Color(0xFFCD7F32);
      default:
        return AppTheme.lightTheme.colorScheme.primary;
    }
  }

  String _getTrophyIcon() {
    switch (rank) {
      case 1:
        return 'emoji_events';
      case 2:
        return 'military_tech';
      case 3:
        return 'workspace_premium';
      default:
        return 'star';
    }
  }

  String _formatAmount(double amount) {
    if (amount >= 100000) {
      return '${(amount / 100000).toStringAsFixed(1)}L';
    } else if (amount >= 1000) {
      return '${(amount / 1000).toStringAsFixed(1)}K';
    } else {
      return amount.toStringAsFixed(0);
    }
  }
}
