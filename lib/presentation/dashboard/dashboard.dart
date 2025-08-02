import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/achievement_section_widget.dart';
import './widgets/donation_hero_card_widget.dart';
import './widgets/greeting_header_widget.dart';
import './widgets/progress_tracker_widget.dart';
import './widgets/quick_stats_widget.dart';
import './widgets/referral_code_card_widget.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with TickerProviderStateMixin {
  int _currentIndex = 0;
  late AnimationController _fabAnimationController;
  late Animation<double> _fabAnimation;

  // Mock data for the dashboard
  final Map<String, dynamic> userData = {
    "name": "Priya Sharma",
    "profileImage":
        "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=400",
    "referralCode": "PRIYA2024",
    "totalDonations": 7500.0,
    "targetAmount": 10000.0,
  };

  final List<Map<String, dynamic>> achievements = [
    {
      "id": 1,
      "title": "First Milestone",
      "description": "Raised ₹2,500",
      "icon": "star",
      "isUnlocked": true,
    },
    {
      "id": 2,
      "title": "Team Player",
      "description": "5 referrals made",
      "icon": "group",
      "isUnlocked": true,
    },
    {
      "id": 3,
      "title": "Silver Badge",
      "description": "Raised ₹5,000",
      "icon": "military_tech",
      "isUnlocked": true,
    },
    {
      "id": 4,
      "title": "Gold Badge",
      "description": "Reach ₹10,000",
      "icon": "emoji_events",
      "isUnlocked": false,
    },
  ];

  final Map<String, dynamic> quickStats = {
    "totalReferrals": 12,
    "activeCampaigns": 3,
    "completionRate": 75,
  };

  @override
  void initState() {
    super.initState();
    _fabAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fabAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _fabAnimationController, curve: Curves.easeInOut),
    );
    _fabAnimationController.forward();
  }

  @override
  void dispose() {
    _fabAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _handleRefresh,
          color: AppTheme.lightTheme.colorScheme.primary,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    GreetingHeaderWidget(
                      userName: userData['name'] as String,
                      profileImageUrl: userData['profileImage'] as String,
                    ),
                    SizedBox(height: 1.h),
                    DonationHeroCardWidget(
                      totalDonations: userData['totalDonations'] as double,
                      targetAmount: userData['targetAmount'] as double,
                    ),
                    SizedBox(height: 1.h),
                    ReferralCodeCardWidget(
                      referralCode: userData['referralCode'] as String,
                    ),
                    SizedBox(height: 1.h),
                    ProgressTrackerWidget(
                      currentAmount: userData['totalDonations'] as double,
                      targetAmount: userData['targetAmount'] as double,
                    ),
                    SizedBox(height: 2.h),
                    AchievementSectionWidget(
                      achievements: achievements,
                    ),
                    SizedBox(height: 2.h),
                    QuickStatsWidget(
                      stats: quickStats,
                    ),
                    SizedBox(height: 10.h), // Bottom padding for FAB
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: AppTheme.lightTheme.colorScheme.primary,
          unselectedItemColor: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
          items: [
            BottomNavigationBarItem(
              icon: CustomIconWidget(
                iconName: 'dashboard',
                color: _currentIndex == 0
                    ? AppTheme.lightTheme.colorScheme.primary
                    : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                size: 6.w,
              ),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: CustomIconWidget(
                iconName: 'card_giftcard',
                color: _currentIndex == 1
                    ? AppTheme.lightTheme.colorScheme.primary
                    : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                size: 6.w,
              ),
              label: 'Rewards',
            ),
            BottomNavigationBarItem(
              icon: CustomIconWidget(
                iconName: 'leaderboard',
                color: _currentIndex == 2
                    ? AppTheme.lightTheme.colorScheme.primary
                    : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                size: 6.w,
              ),
              label: 'Leaderboard',
            ),
            BottomNavigationBarItem(
              icon: CustomIconWidget(
                iconName: 'announcement',
                color: _currentIndex == 3
                    ? AppTheme.lightTheme.colorScheme.primary
                    : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                size: 6.w,
              ),
              label: 'Announcements',
            ),
            BottomNavigationBarItem(
              icon: CustomIconWidget(
                iconName: 'person',
                color: _currentIndex == 4
                    ? AppTheme.lightTheme.colorScheme.primary
                    : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                size: 6.w,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
      floatingActionButton: AnimatedBuilder(
        animation: _fabAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _fabAnimation.value,
            child: FloatingActionButton.extended(
              onPressed: _shareReferralCode,
              backgroundColor: AppTheme.lightTheme.colorScheme.primary,
              foregroundColor: Colors.white,
              elevation: 8,
              icon: CustomIconWidget(
                iconName: 'share',
                color: Colors.white,
                size: 5.w,
              ),
              label: Text(
                'Share Code',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    // Navigate to respective screens
    switch (index) {
      case 0:
        // Already on dashboard
        break;
      case 1:
        // Navigate to rewards screen (not implemented in this task)
        break;
      case 2:
        Navigator.pushNamed(context, '/leaderboard-screen');
        break;
      case 3:
        Navigator.pushNamed(context, '/announcements-screen');
        break;
      case 4:
        Navigator.pushNamed(
          context,
          '/profile-screen',
          arguments: {'role': 'user'},
        );
        break;
    }
  }

  Future<void> _handleRefresh() async {
    // Simulate refresh delay
    await Future.delayed(const Duration(seconds: 1));

    // Show refresh success message
    Fluttertoast.showToast(
      msg: "Dashboard refreshed successfully!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppTheme.lightTheme.colorScheme.tertiary,
      textColor: Colors.white,
    );

    // Add haptic feedback
    HapticFeedback.lightImpact();
  }

  void _shareReferralCode() {
    final referralCode = userData['referralCode'] as String;
    final shareText =
        "Join me in fundraising! Use my referral code: $referralCode to get started. Together we can make a difference! 🌟";

    // Copy to clipboard as a fallback
    Clipboard.setData(ClipboardData(text: shareText));

    Fluttertoast.showToast(
      msg: "Referral message copied to clipboard!",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppTheme.lightTheme.colorScheme.primary,
      textColor: Colors.white,
    );

    // Add haptic feedback
    HapticFeedback.mediumImpact();

    // Animate FAB
    _fabAnimationController.reverse().then((_) {
      _fabAnimationController.forward();
    });
  }
}
