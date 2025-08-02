import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class LeaderboardHeaderWidget extends StatelessWidget {
  final Map<String, dynamic> currentUser;

  const LeaderboardHeaderWidget({
    Key? key,
    required this.currentUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      padding: EdgeInsets.all(5.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            AppTheme.lightTheme.colorScheme.primary,
            AppTheme.lightTheme.colorScheme.secondary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color:
                AppTheme.lightTheme.colorScheme.primary.withValues(alpha: 0.3),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              CustomIconWidget(
                iconName: 'leaderboard',
                color: Colors.white,
                size: 8.w,
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Text(
                  'Leaderboard',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Live',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ],
          ),
          SizedBox(height: 3.h),
          _buildUserStats(context),
        ],
      ),
    );
  }

  Widget _buildUserStats(BuildContext context) {
    final int currentRank = currentUser['rank'] as int? ?? 0;
    final double totalRaised = currentUser['totalRaised'] as double? ?? 0.0;
    final int rankChange = currentUser['rankChange'] as int? ?? 0;

    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            context,
            'Your Rank',
            '#$currentRank',
            'trending_up',
            rankChange > 0
                ? '+$rankChange'
                : rankChange < 0
                    ? '$rankChange'
                    : '0',
          ),
        ),
        SizedBox(width: 4.w),
        Expanded(
          child: _buildStatCard(
            context,
            'Total Raised',
            '₹${_formatAmount(totalRaised)}',
            'account_balance_wallet',
            '${((totalRaised / 10000) * 100).toInt()}% of goal',
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String title,
    String value,
    String iconName,
    String subtitle,
  ) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomIconWidget(
                iconName: iconName,
                color: Colors.white.withValues(alpha: 0.8),
                size: 5.w,
              ),
              SizedBox(width: 2.w),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.8),
                        fontWeight: FontWeight.w500,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
          ),
          SizedBox(height: 0.5.h),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontWeight: FontWeight.w400,
                ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
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
