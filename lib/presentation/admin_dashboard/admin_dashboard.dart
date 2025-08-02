import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/admin_controls_widget.dart';
import './widgets/admin_metrics_panel_widget.dart';
import './widgets/audit_trail_widget.dart';
import './widgets/campaign_oversight_widget.dart';
import './widgets/user_management_widget.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  // Mock admin data
  final Map<String, dynamic> adminData = {
    "name": "Admin User",
    "role": "Administrator",
    "systemStatus": "Operational",
    "profileImage":
        "https://images.pexels.com/photos/2182970/pexels-photo-2182970.jpeg?auto=compress&cs=tinysrgb&w=400",
  };

  final Map<String, dynamic> organizationMetrics = {
    "totalFundsRaised": 285000.0,
    "activeCampaigns": 24,
    "userRegistrations": 156,
    "conversionRate": 68.5,
  };

  final List<Map<String, dynamic>> recentInterns = [
    {
      "name": "Priya Sharma",
      "email": "priya@fundraise.com",
      "joinedDate": "2024-01-15",
      "status": "Active",
      "raised": 7500.0,
    },
    {
      "name": "Rohit Kumar",
      "email": "rohit@fundraise.com",
      "joinedDate": "2024-01-20",
      "status": "Pending",
      "raised": 0.0,
    },
    {
      "name": "Anjali Patel",
      "email": "anjali@fundraise.com",
      "joinedDate": "2024-01-18",
      "status": "Active",
      "raised": 12500.0,
    },
  ];

  final List<Map<String, dynamic>> activeCampaigns = [
    {
      "name": "Education for All",
      "progress": 85.0,
      "target": 50000.0,
      "raised": 42500.0,
      "participants": 12,
    },
    {
      "name": "Healthcare Support",
      "progress": 45.0,
      "target": 75000.0,
      "raised": 33750.0,
      "participants": 8,
    },
    {
      "name": "Clean Water Initiative",
      "progress": 92.0,
      "target": 30000.0,
      "raised": 27600.0,
      "participants": 15,
    },
  ];

  final List<Map<String, dynamic>> auditTrail = [
    {
      "action": "User Approved",
      "user": "Admin User",
      "timestamp": "2024-02-01 14:30",
      "details": "Approved intern registration for Priya Sharma",
    },
    {
      "action": "Campaign Created",
      "user": "Admin User",
      "timestamp": "2024-02-01 12:15",
      "details": "Created new campaign: Education for All",
    },
    {
      "action": "Announcement Published",
      "user": "Admin User",
      "timestamp": "2024-02-01 10:45",
      "details": "Published system maintenance announcement",
    },
  ];

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _handleRefresh,
          color: const Color(0xFFFF6B6B), // Coral accent for admin
          child: CustomScrollView(
            slivers: [
              // Admin Header
              SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFF6B6B), Color(0xFFFF8E8E)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(6.w),
                      bottomRight: Radius.circular(6.w),
                    ),
                  ),
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 8.w,
                              backgroundImage:
                                  NetworkImage(adminData['profileImage']),
                            ),
                            SizedBox(width: 4.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        adminData['name'],
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
                                            horizontal: 2.w, vertical: 0.5.h),
                                        decoration: BoxDecoration(
                                          color: Colors.white
                                              .withValues(alpha: 0.2),
                                          borderRadius:
                                              BorderRadius.circular(3.w),
                                        ),
                                        child: Text(
                                          'ADMIN',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall
                                              ?.copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'System Status: ${adminData['systemStatus']}',
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
                            CustomIconWidget(
                              iconName: 'settings',
                              color: Colors.white,
                              size: 6.w,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    children: [
                      SizedBox(height: 2.h),
                      AdminMetricsPanelWidget(metrics: organizationMetrics),
                      SizedBox(height: 2.h),
                      UserManagementWidget(recentInterns: recentInterns),
                      SizedBox(height: 2.h),
                      CampaignOversightWidget(campaigns: activeCampaigns),
                      SizedBox(height: 2.h),
                      AdminControlsWidget(),
                      SizedBox(height: 2.h),
                      AuditTrailWidget(auditTrail: auditTrail),
                      SizedBox(height: 10.h),
                    ],
                  ),
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
          selectedItemColor: const Color(0xFFFF6B6B),
          unselectedItemColor: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
          items: [
            BottomNavigationBarItem(
              icon: CustomIconWidget(
                iconName: 'dashboard',
                color: _currentIndex == 0
                    ? const Color(0xFFFF6B6B)
                    : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                size: 6.w,
              ),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: CustomIconWidget(
                iconName: 'people',
                color: _currentIndex == 1
                    ? const Color(0xFFFF6B6B)
                    : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                size: 6.w,
              ),
              label: 'Users',
            ),
            BottomNavigationBarItem(
              icon: CustomIconWidget(
                iconName: 'campaign',
                color: _currentIndex == 2
                    ? const Color(0xFFFF6B6B)
                    : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                size: 6.w,
              ),
              label: 'Campaigns',
            ),
            BottomNavigationBarItem(
              icon: CustomIconWidget(
                iconName: 'analytics',
                color: _currentIndex == 3
                    ? const Color(0xFFFF6B6B)
                    : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                size: 6.w,
              ),
              label: 'Analytics',
            ),
            BottomNavigationBarItem(
              icon: CustomIconWidget(
                iconName: 'person',
                color: _currentIndex == 4
                    ? const Color(0xFFFF6B6B)
                    : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                size: 6.w,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _publishAnnouncement,
        backgroundColor: const Color(0xFFFF6B6B),
        foregroundColor: Colors.white,
        elevation: 8,
        icon: CustomIconWidget(
          iconName: 'campaign',
          color: Colors.white,
          size: 5.w,
        ),
        label: Text(
          'Announce',
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
        // Stay on admin dashboard
        break;
      case 1:
        // Navigate to user management
        break;
      case 2:
        // Navigate to campaign management
        break;
      case 3:
        // Navigate to analytics
        break;
      case 4:
        Navigator.pushNamed(
          context,
          '/profile-screen',
          arguments: {'role': 'admin'},
        );
        break;
    }
  }

  Future<void> _handleRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    Fluttertoast.showToast(
      msg: "Admin dashboard refreshed successfully!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: const Color(0xFFFF6B6B),
      textColor: Colors.white,
    );
    HapticFeedback.lightImpact();
  }

  void _publishAnnouncement() {
    Fluttertoast.showToast(
      msg: "Publishing new announcement...",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: const Color(0xFFFF6B6B),
      textColor: Colors.white,
    );
    HapticFeedback.mediumImpact();
  }
}
