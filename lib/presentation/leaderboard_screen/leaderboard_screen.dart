import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/empty_leaderboard_widget.dart';
import './widgets/leaderboard_card_widget.dart';
import './widgets/leaderboard_header_widget.dart';
import './widgets/skeleton_leaderboard_widget.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({Key? key}) : super(key: key);

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen>
    with TickerProviderStateMixin {
  bool _isLoading = true;
  bool _isRefreshing = false;
  late AnimationController _celebrationController;
  late AnimationController _rankChangeController;

  // Mock current user data
  final Map<String, dynamic> _currentUser = {
    "id": 3,
    "name": "Priya Sharma",
    "avatar":
        "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=400",
    "totalRaised": 75000.0,
    "rank": 3,
    "rankChange": 2,
    "progressPercentage": 75.0,
  };

  // Mock leaderboard data
  final List<Map<String, dynamic>> _leaderboardData = [
    {
      "id": 1,
      "name": "Arjun Patel",
      "avatar":
          "https://images.pexels.com/photos/1222271/pexels-photo-1222271.jpeg?auto=compress&cs=tinysrgb&w=400",
      "totalRaised": 125000.0,
      "rank": 1,
      "rankChange": 0,
      "progressPercentage": 85.0,
    },
    {
      "id": 2,
      "name": "Sneha Reddy",
      "avatar":
          "https://images.pexels.com/photos/1239291/pexels-photo-1239291.jpeg?auto=compress&cs=tinysrgb&w=400",
      "totalRaised": 98000.0,
      "rank": 2,
      "rankChange": 1,
      "progressPercentage": 92.0,
    },
    {
      "id": 3,
      "name": "Priya Sharma",
      "avatar":
          "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=400",
      "totalRaised": 75000.0,
      "rank": 3,
      "rankChange": 2,
      "progressPercentage": 75.0,
    },
    {
      "id": 4,
      "name": "Rahul Kumar",
      "avatar":
          "https://images.pexels.com/photos/1681010/pexels-photo-1681010.jpeg?auto=compress&cs=tinysrgb&w=400",
      "totalRaised": 62000.0,
      "rank": 4,
      "rankChange": -1,
      "progressPercentage": 68.0,
    },
    {
      "id": 5,
      "name": "Ananya Singh",
      "avatar":
          "https://images.pexels.com/photos/1130626/pexels-photo-1130626.jpeg?auto=compress&cs=tinysrgb&w=400",
      "totalRaised": 45000.0,
      "rank": 5,
      "rankChange": 0,
      "progressPercentage": 45.0,
    },
  ];

  @override
  void initState() {
    super.initState();
    _celebrationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _rankChangeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _loadLeaderboardData();
  }

  @override
  void dispose() {
    _celebrationController.dispose();
    _rankChangeController.dispose();
    super.dispose();
  }

  Future<void> _loadLeaderboardData() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        _isLoading = false;
      });

      // Trigger rank change animation if user moved up
      if (_currentUser['rankChange'] as int > 0) {
        _triggerRankChangeAnimation();
      }
    }
  }

  Future<void> _refreshLeaderboard() async {
    if (_isRefreshing) return;

    setState(() {
      _isRefreshing = true;
    });

    // Provide haptic feedback
    HapticFeedback.lightImpact();

    // Simulate refresh delay
    await Future.delayed(const Duration(seconds: 1));

    // Simulate rank changes
    final List<Map<String, dynamic>> updatedData = List.from(_leaderboardData);
    for (var intern in updatedData) {
      // Randomly update some values to simulate real-time changes
      if (intern['id'] != _currentUser['id']) {
        final double currentAmount = intern['totalRaised'] as double;
        final double change = (currentAmount * 0.02) *
            (0.5 - (DateTime.now().millisecond / 1000));
        intern['totalRaised'] =
            (currentAmount + change).clamp(0.0, double.infinity);
      }
    }

    // Re-sort by total raised
    updatedData.sort((a, b) =>
        (b['totalRaised'] as double).compareTo(a['totalRaised'] as double));

    // Update ranks
    for (int i = 0; i < updatedData.length; i++) {
      final int oldRank = updatedData[i]['rank'] as int;
      updatedData[i]['rank'] = i + 1;
      updatedData[i]['rankChange'] = oldRank - (i + 1);
    }

    if (mounted) {
      setState(() {
        _leaderboardData.clear();
        _leaderboardData.addAll(updatedData);

        // Update current user data
        final currentUserData = _leaderboardData.firstWhere(
          (intern) => intern['id'] == _currentUser['id'],
          orElse: () => _currentUser,
        );
        _currentUser.addAll(currentUserData);

        _isRefreshing = false;
      });

      // Show success feedback
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              CustomIconWidget(
                iconName: 'refresh',
                color: Colors.white,
                size: 5.w,
              ),
              SizedBox(width: 3.w),
              const Text('Leaderboard updated!'),
            ],
          ),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );

      // Trigger celebration if rank improved
      if ((_currentUser['rankChange'] as int) > 0) {
        _triggerCelebrationAnimation();
      }
    }
  }

  void _triggerCelebrationAnimation() {
    _celebrationController.forward().then((_) {
      _celebrationController.reset();
    });
    HapticFeedback.mediumImpact();
  }

  void _triggerRankChangeAnimation() {
    _rankChangeController.forward().then((_) {
      _rankChangeController.reset();
    });
  }

  void _showInternProfile(Map<String, dynamic> intern) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildProfileBottomSheet(intern),
    );
  }

  Widget _buildProfileBottomSheet(Map<String, dynamic> intern) {
    return Container(
      height: 60.h,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          Container(
            width: 12.w,
            height: 0.5.h,
            margin: EdgeInsets.symmetric(vertical: 2.h),
            decoration: BoxDecoration(
              color: Colors.grey.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(6.w),
              child: Column(
                children: [
                  // Profile header
                  Row(
                    children: [
                      Container(
                        width: 20.w,
                        height: 20.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              AppTheme.lightTheme.colorScheme.primary,
                              AppTheme.lightTheme.colorScheme.secondary,
                            ],
                          ),
                        ),
                        child: intern['avatar'] != null
                            ? ClipOval(
                                child: CustomImageWidget(
                                  imageUrl: intern['avatar'] as String,
                                  width: 20.w,
                                  height: 20.w,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Center(
                                child: Text(
                                  (intern['name'] as String)[0].toUpperCase(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              intern['name'] as String,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                            SizedBox(height: 1.h),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 3.w, vertical: 1.h),
                              decoration: BoxDecoration(
                                color: AppTheme.lightTheme.colorScheme.primary
                                    .withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'Rank #${intern['rank']}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      color: AppTheme
                                          .lightTheme.colorScheme.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  // Stats
                  Container(
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(16),
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
                        Row(
                          children: [
                            Expanded(
                              child: _buildStatItem(
                                'Total Raised',
                                '₹${_formatAmount(intern['totalRaised'] as double)}',
                                'account_balance_wallet',
                              ),
                            ),
                            Container(
                              width: 1,
                              height: 8.h,
                              color: Colors.grey.withValues(alpha: 0.2),
                            ),
                            Expanded(
                              child: _buildStatItem(
                                'Progress',
                                '${(intern['progressPercentage'] as double).toInt()}%',
                                'trending_up',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 4.h),
                  // Action buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Encouragement sent to ${intern['name']}!'),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          },
                          icon: CustomIconWidget(
                            iconName: 'favorite',
                            color: AppTheme.lightTheme.colorScheme.primary,
                            size: 5.w,
                          ),
                          label: const Text('Send Encouragement'),
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: CustomIconWidget(
                            iconName: 'close',
                            color: Colors.white,
                            size: 5.w,
                          ),
                          label: const Text('Close'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String title, String value, String iconName) {
    return Column(
      children: [
        CustomIconWidget(
          iconName: iconName,
          color: AppTheme.lightTheme.colorScheme.primary,
          size: 8.w,
        ),
        SizedBox(height: 1.h),
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppTheme.lightTheme.colorScheme.primary,
              ),
        ),
        SizedBox(height: 0.5.h),
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).textTheme.bodySmall?.color,
              ),
        ),
      ],
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: _isLoading
            ? const SkeletonLeaderboardWidget()
            : _leaderboardData.isEmpty
                ? const EmptyLeaderboardWidget()
                : RefreshIndicator(
                    onRefresh: _refreshLeaderboard,
                    color: AppTheme.lightTheme.colorScheme.primary,
                    backgroundColor: Theme.of(context).cardColor,
                    child: CustomScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      slivers: [
                        SliverToBoxAdapter(
                          child: Column(
                            children: [
                              LeaderboardHeaderWidget(
                                  currentUser: _currentUser),
                              SizedBox(height: 2.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4.w),
                                child: Row(
                                  children: [
                                    CustomIconWidget(
                                      iconName: 'emoji_events',
                                      color: AppTheme
                                          .lightTheme.colorScheme.primary,
                                      size: 6.w,
                                    ),
                                    SizedBox(width: 2.w),
                                    Text(
                                      'Top Performers',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                    const Spacer(),
                                    if (_isRefreshing)
                                      SizedBox(
                                        width: 5.w,
                                        height: 5.w,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            AppTheme
                                                .lightTheme.colorScheme.primary,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 2.h),
                            ],
                          ),
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final intern = _leaderboardData[index];
                              final bool isCurrentUser =
                                  intern['id'] == _currentUser['id'];

                              return GestureDetector(
                                onLongPress: () => _showInternProfile(intern),
                                child: AnimatedBuilder(
                                  animation: _rankChangeController,
                                  builder: (context, child) {
                                    return Transform.scale(
                                      scale: isCurrentUser &&
                                              _rankChangeController.isAnimating
                                          ? 1.0 +
                                              (0.05 *
                                                  _rankChangeController.value)
                                          : 1.0,
                                      child: LeaderboardCardWidget(
                                        intern: intern,
                                        rank: intern['rank'] as int,
                                        isCurrentUser: isCurrentUser,
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                            childCount: _leaderboardData.length,
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: SizedBox(height: 4.h),
                        ),
                      ],
                    ),
                  ),
      ),
      floatingActionButton: _isLoading
          ? null
          : FloatingActionButton.extended(
              onPressed: () {
                HapticFeedback.lightImpact();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      children: [
                        CustomIconWidget(
                          iconName: 'share',
                          color: Colors.white,
                          size: 5.w,
                        ),
                        SizedBox(width: 3.w),
                        const Text('Referral code shared!'),
                      ],
                    ),
                    duration: const Duration(seconds: 2),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              icon: CustomIconWidget(
                iconName: 'share',
                color: Colors.white,
                size: 5.w,
              ),
              label: Text(
                'Share Code',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              backgroundColor: AppTheme.lightTheme.colorScheme.secondary,
              foregroundColor: Colors.white,
            ),
    );
  }
}
