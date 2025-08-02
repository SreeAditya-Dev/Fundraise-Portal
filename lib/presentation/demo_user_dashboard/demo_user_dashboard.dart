import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/demo_achievements_widget.dart';
import './widgets/demo_features_widget.dart';
import './widgets/demo_hero_section_widget.dart';
import './widgets/demo_tutorial_overlay_widget.dart';
import './widgets/demo_watermark_widget.dart';

class DemoUserDashboard extends StatefulWidget {
  const DemoUserDashboard({Key? key}) : super(key: key);

  @override
  State<DemoUserDashboard> createState() => _DemoUserDashboardState();
}

class _DemoUserDashboardState extends State<DemoUserDashboard>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  bool _showTutorial = true;
  late AnimationController _celebrationController;
  late Animation<double> _celebrationAnimation;

  // Demo user data with impressive statistics
  final Map<String, dynamic> demoUserData = {
    "name": "Demo User",
    "profileImage":
        "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=400",
    "referralCode": "DEMO2024",
    "totalDonations": 85000.0,
    "targetAmount": 100000.0,
    "referrals": 150,
    "tier": "Gold",
  };

  final List<Map<String, dynamic>> demoAchievements = [
    {
      "id": 1,
      "title": "Demo Champion",
      "description": "Explored all features",
      "icon": "star",
      "isUnlocked": true,
      "isDemo": true,
    },
    {
      "id": 2,
      "title": "Super Referrer",
      "description": "150+ referrals made",
      "icon": "group",
      "isUnlocked": true,
      "isDemo": true,
    },
    {
      "id": 3,
      "title": "Gold Tier",
      "description": "Raised ₹85,000",
      "icon": "emoji_events",
      "isUnlocked": true,
      "isDemo": true,
    },
    {
      "id": 4,
      "title": "Platinum Goal",
      "description": "Reach ₹100,000",
      "icon": "military_tech",
      "isUnlocked": false,
      "isDemo": true,
    },
  ];

  final List<Map<String, dynamic>> demoAnnouncements = [
    {
      "title": "Welcome to Demo Mode!",
      "content":
          "Explore all features with sample data. This showcases platform capabilities.",
      "timestamp": "2 hours ago",
      "isDemo": true,
    },
    {
      "title": "Sample Achievement Unlocked",
      "content":
          "Congratulations on reaching Gold tier! This is how achievements work.",
      "timestamp": "1 day ago",
      "isDemo": true,
    },
  ];

  @override
  void initState() {
    super.initState();
    _celebrationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _celebrationAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _celebrationController, curve: Curves.elasticOut),
    );

    // Start celebration animation
    Future.delayed(const Duration(milliseconds: 500), () {
      _celebrationController.forward();
    });
  }

  @override
  void dispose() {
    _celebrationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            RefreshIndicator(
              onRefresh: _handleDemoRefresh,
              color: const Color(0xFF4CAF50),
              child: CustomScrollView(
                slivers: [
                  // Demo Header with Watermark
                  SliverToBoxAdapter(
                    child: Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.all(4.w),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF4CAF50), Color(0xFF66BB6A)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(6.w),
                              bottomRight: Radius.circular(6.w),
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 8.w,
                                    backgroundImage: NetworkImage(
                                        demoUserData['profileImage']),
                                  ),
                                  SizedBox(width: 4.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'Welcome, ${demoUserData['name']}!',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall
                                                  ?.copyWith(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                            SizedBox(width: 2.w),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 2.w,
                                                  vertical: 0.5.h),
                                              decoration: BoxDecoration(
                                                color: Colors.white
                                                    .withValues(alpha: 0.2),
                                                borderRadius:
                                                    BorderRadius.circular(3.w),
                                              ),
                                              child: Text(
                                                'DEMO',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall
                                                    ?.copyWith(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          'Exploring Platform Features',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                color: Colors.white
                                                    .withValues(alpha: 0.9),
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const DemoWatermarkWidget(),
                      ],
                    ),
                  ),

                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        SizedBox(height: 2.h),
                        AnimatedBuilder(
                          animation: _celebrationAnimation,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: _celebrationAnimation.value,
                              child: DemoHeroSectionWidget(
                                userData: demoUserData,
                                onCelebration: _triggerCelebration,
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 2.h),
                        DemoAchievementsWidget(achievements: demoAchievements),
                        SizedBox(height: 2.h),
                        DemoFeaturesWidget(
                          announcements: demoAnnouncements,
                          referralCode: demoUserData['referralCode'],
                        ),
                        SizedBox(height: 10.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Tutorial Overlay
            if (_showTutorial)
              DemoTutorialOverlayWidget(
                onDismiss: () {
                  setState(() {
                    _showTutorial = false;
                  });
                },
              ),

            // Explore Features FAB
            Positioned(
              bottom: 12.h,
              right: 4.w,
              child: FloatingActionButton.extended(
                onPressed: _exploreFeatures,
                backgroundColor: const Color(0xFF2196F3),
                foregroundColor: Colors.white,
                elevation: 8,
                icon: CustomIconWidget(
                  iconName: 'explore',
                  color: Colors.white,
                  size: 5.w,
                ),
                label: Text(
                  'Explore Features',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ),
          ],
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
          selectedItemColor: const Color(0xFF4CAF50),
          unselectedItemColor: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
          items: [
            BottomNavigationBarItem(
              icon: CustomIconWidget(
                iconName: 'dashboard',
                color: _currentIndex == 0
                    ? const Color(0xFF4CAF50)
                    : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                size: 6.w,
              ),
              label: 'Demo Dashboard',
            ),
            BottomNavigationBarItem(
              icon: CustomIconWidget(
                iconName: 'card_giftcard',
                color: _currentIndex == 1
                    ? const Color(0xFF4CAF50)
                    : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                size: 6.w,
              ),
              label: 'Sample Rewards',
            ),
            BottomNavigationBarItem(
              icon: CustomIconWidget(
                iconName: 'leaderboard',
                color: _currentIndex == 2
                    ? const Color(0xFF4CAF50)
                    : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                size: 6.w,
              ),
              label: 'Demo Leaderboard',
            ),
            BottomNavigationBarItem(
              icon: CustomIconWidget(
                iconName: 'person',
                color: _currentIndex == 3
                    ? const Color(0xFF4CAF50)
                    : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                size: 6.w,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _resetDemo,
        backgroundColor: const Color(0xFFFF9800),
        foregroundColor: Colors.white,
        elevation: 8,
        icon: CustomIconWidget(
          iconName: 'refresh',
          color: Colors.white,
          size: 5.w,
        ),
        label: Text(
          'Reset Demo',
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        // Stay on demo dashboard
        break;
      case 1:
        _showDemoFeature('Sample Rewards');
        break;
      case 2:
        _showDemoFeature('Demo Leaderboard - You\'re #3!');
        break;
      case 3:
        Navigator.pushNamed(
          context,
          '/profile-screen',
          arguments: {'role': 'demo'},
        );
        break;
    }
  }

  Future<void> _handleDemoRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    Fluttertoast.showToast(
      msg: "Demo data refreshed! All sample statistics updated.",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: const Color(0xFF4CAF50),
      textColor: Colors.white,
    );
    HapticFeedback.lightImpact();
  }

  void _exploreFeatures() {
    setState(() {
      _showTutorial = true;
    });
    Fluttertoast.showToast(
      msg: "Starting guided tour of platform features...",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: const Color(0xFF2196F3),
      textColor: Colors.white,
    );
  }

  void _resetDemo() {
    _celebrationController.reset();
    _celebrationController.forward();

    Fluttertoast.showToast(
      msg: "Demo reset to initial state. Explore again!",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: const Color(0xFFFF9800),
      textColor: Colors.white,
    );
    HapticFeedback.mediumImpact();
  }

  void _triggerCelebration() {
    _celebrationController.reset();
    _celebrationController.forward();
    HapticFeedback.heavyImpact();
  }

  void _showDemoFeature(String feature) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              CustomIconWidget(
                iconName: 'info',
                color: const Color(0xFF2196F3),
                size: 6.w,
              ),
              SizedBox(width: 2.w),
              const Text('Demo Feature'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(feature),
              SizedBox(height: 2.h),
              Container(
                padding: EdgeInsets.all(3.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3E5F5),
                  borderRadius: BorderRadius.circular(3.w),
                ),
                child: Text(
                  'This is a demo feature showcasing platform capabilities. In the real app, this would show actual data and functionality.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: const Color(0xFF9C27B0),
                      ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Got it!'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showSignUpPrompt();
              },
              child: const Text('Create Real Account'),
            ),
          ],
        );
      },
    );
  }

  void _showSignUpPrompt() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ready to Get Started?'),
          content: const Text(
            'Create your real account to start fundraising and unlock all features with actual data and functionality.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Continue Demo'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/sign-up-screen');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF50),
              ),
              child: const Text('Sign Up Now'),
            ),
          ],
        );
      },
    );
  }
}
