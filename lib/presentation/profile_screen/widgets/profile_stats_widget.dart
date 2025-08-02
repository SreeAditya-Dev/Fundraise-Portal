import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class ProfileStatsWidget extends StatelessWidget {
  final Map<String, dynamic> userProfile;
  final String userRole;
  final Color roleColor;

  const ProfileStatsWidget({
    Key? key,
    required this.userProfile,
    required this.userRole,
    required this.roleColor,
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
          Text(
            _getStatsTitle(),
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 2.h),

          if (userRole == 'admin') _buildAdminStats(context),
          if (userRole == 'demo') _buildDemoStats(context),
          if (userRole == 'user') _buildUserStats(context),

          SizedBox(height: 2.h),

          // Achievements Section
          Text(
            _getAchievementsTitle(),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 1.h),
          _buildAchievements(context),
        ],
      ),
    );
  }

  Widget _buildAdminStats(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            context,
            'Total Users',
            '${userProfile['totalUsers']}',
            Icons.people,
            const Color(0xFF2196F3),
          ),
        ),
        SizedBox(width: 3.w),
        Expanded(
          child: _buildStatCard(
            context,
            'Campaigns',
            '${userProfile['totalCampaigns']}',
            Icons.campaign,
            const Color(0xFF4CAF50),
          ),
        ),
        SizedBox(width: 3.w),
        Expanded(
          child: _buildStatCard(
            context,
            'System',
            userProfile['systemStatus'],
            Icons.check_circle,
            roleColor,
          ),
        ),
      ],
    );
  }

  Widget _buildDemoStats(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            context,
            'Demo Raised',
            '₹${_formatNumber(userProfile['totalRaised'])}',
            Icons.account_balance_wallet,
            const Color(0xFF4CAF50),
          ),
        ),
        SizedBox(width: 3.w),
        Expanded(
          child: _buildStatCard(
            context,
            'Referrals',
            '${userProfile['referrals']}',
            Icons.people,
            const Color(0xFF2196F3),
          ),
        ),
        SizedBox(width: 3.w),
        Expanded(
          child: _buildStatCard(
            context,
            'Tier',
            userProfile['tier'],
            Icons.emoji_events,
            const Color(0xFFFFD700),
          ),
        ),
      ],
    );
  }

  Widget _buildUserStats(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            context,
            'Total Raised',
            '₹${_formatNumber(userProfile['totalRaised'])}',
            Icons.account_balance_wallet,
            const Color(0xFF4CAF50),
          ),
        ),
        SizedBox(width: 3.w),
        Expanded(
          child: _buildStatCard(
            context,
            'Referrals',
            '${userProfile['referrals']}',
            Icons.people,
            const Color(0xFF2196F3),
          ),
        ),
        SizedBox(width: 3.w),
        Expanded(
          child: _buildStatCard(
            context,
            'Tier',
            userProfile['tier'],
            Icons.star,
            roleColor,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(3.w),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 6.w),
          SizedBox(height: 1.h),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
            textAlign: TextAlign.center,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildAchievements(BuildContext context) {
    final achievements =
        userProfile['achievements'] as List<Map<String, dynamic>>? ?? [];

    return Wrap(
      spacing: 2.w,
      runSpacing: 1.h,
      children: achievements.map((achievement) {
        final isUnlocked = achievement['unlocked'] as bool? ?? false;
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
          decoration: BoxDecoration(
            color: isUnlocked
                ? roleColor.withValues(alpha: 0.1)
                : Colors.grey.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(3.w),
            border: Border.all(
              color: isUnlocked
                  ? roleColor.withValues(alpha: 0.3)
                  : Colors.grey.withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isUnlocked ? Icons.check_circle : Icons.lock,
                color: isUnlocked ? roleColor : Colors.grey,
                size: 4.w,
              ),
              SizedBox(width: 1.w),
              Text(
                achievement['title'],
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: isUnlocked ? roleColor : Colors.grey,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  String _getStatsTitle() {
    switch (userRole) {
      case 'admin':
        return 'Administrative Overview';
      case 'demo':
        return 'Demo Statistics';
      default:
        return 'Your Statistics';
    }
  }

  String _getAchievementsTitle() {
    switch (userRole) {
      case 'admin':
        return 'Admin Permissions';
      case 'demo':
        return 'Demo Features Explored';
      default:
        return 'Achievements Unlocked';
    }
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
