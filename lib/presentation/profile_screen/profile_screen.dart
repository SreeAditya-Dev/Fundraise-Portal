import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/profile_actions_widget.dart';
import './widgets/profile_header_widget.dart';
import './widgets/profile_settings_widget.dart';
import './widgets/profile_stats_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;

  // Get user role from route arguments or determine based on logged in user
  String _userRole = 'user'; // Default role
  Map<String, dynamic> _userProfile = {};

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));
    _slideController.forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _determineUserRole();
    _loadUserProfile();
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  void _determineUserRole() {
    // Get role from arguments or determine from current route/user state
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null && args.containsKey('role')) {
      _userRole = args['role'];
    } else {
      // Determine role based on current user (this would come from your auth system)
      // For demo purposes, we'll check the current route or use a mock system
      final currentRoute = ModalRoute.of(context)?.settings.name;
      if (currentRoute?.contains('admin') == true) {
        _userRole = 'admin';
      } else if (currentRoute?.contains('demo') == true) {
        _userRole = 'demo';
      } else {
        _userRole = 'user';
      }
    }
  }

  void _loadUserProfile() {
    switch (_userRole) {
      case 'admin':
        _userProfile = {
          "name": "Admin User",
          "email": "admin@fundraise.com",
          "role": "Administrator",
          "profileImage":
              "https://images.pexels.com/photos/2182970/pexels-photo-2182970.jpeg?auto=compress&cs=tinysrgb&w=400",
          "joinedDate": "January 2023",
          "totalUsers": 156,
          "totalCampaigns": 24,
          "systemStatus": "Operational",
          "permissions": [
            "User Management",
            "Campaign Oversight",
            "System Administration"
          ],
          "recentActions": [
            {"action": "Approved user registration", "time": "2 hours ago"},
            {"action": "Created new campaign", "time": "5 hours ago"},
            {"action": "Published announcement", "time": "1 day ago"},
          ],
          "achievements": [
            {"title": "System Administrator", "unlocked": true},
            {"title": "User Manager", "unlocked": true},
            {"title": "Campaign Overseer", "unlocked": true},
          ],
        };
        break;
      case 'demo':
        _userProfile = {
          "name": "Demo User",
          "email": "demo@fundraise.com",
          "role": "Demo Account",
          "profileImage":
              "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=400",
          "joinedDate": "Demo Mode",
          "totalRaised": 85000.0,
          "referrals": 150,
          "tier": "Gold",
          "demoFeatures": [
            "All Platform Features",
            "Sample Data",
            "Interactive Tutorial"
          ],
          "achievements": [
            {"title": "Demo Champion", "unlocked": true},
            {"title": "Feature Explorer", "unlocked": true},
            {"title": "Gold Tier Demo", "unlocked": true},
          ],
        };
        break;
      default:
        _userProfile = {
          "name": "Priya Sharma",
          "email": "priya@fundrai.com",
          "role": "Fundraising Intern",
          "profileImage":
              "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=400",
          "joinedDate": "January 2024",
          "totalRaised": 7500.0,
          "referrals": 12,
          "tier": "Silver",
          "referralCode": "PRIYA2024",
          "achievements": [
            {"title": "First Milestone", "unlocked": true},
            {"title": "Team Player", "unlocked": true},
            {"title": "Silver Badge", "unlocked": true},
          ],
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: CustomIconWidget(
            iconName: 'arrow_back',
            color: AppTheme.lightTheme.colorScheme.onSurface,
            size: 6.w,
          ),
        ),
        title: Text(
          'Profile',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        actions: [
          IconButton(
            onPressed: _editProfile,
            icon: CustomIconWidget(
              iconName: 'edit',
              color: _getRoleColor(),
              size: 6.w,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _handleRefresh,
          color: _getRoleColor(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: SlideTransition(
              position: _slideAnimation,
              child: Column(
                children: [
                  SizedBox(height: 2.h),
                  ProfileHeaderWidget(
                    userProfile: _userProfile,
                    userRole: _userRole,
                    roleColor: _getRoleColor(),
                  ),
                  SizedBox(height: 2.h),
                  ProfileStatsWidget(
                    userProfile: _userProfile,
                    userRole: _userRole,
                    roleColor: _getRoleColor(),
                  ),
                  SizedBox(height: 2.h),
                  ProfileSettingsWidget(
                    userRole: _userRole,
                    roleColor: _getRoleColor(),
                  ),
                  SizedBox(height: 2.h),
                  ProfileActionsWidget(
                    userRole: _userRole,
                    roleColor: _getRoleColor(),
                    onLogout: _handleLogout,
                  ),
                  SizedBox(height: 4.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _getRoleColor() {
    switch (_userRole) {
      case 'admin':
        return const Color(0xFFFF6B6B);
      case 'demo':
        return const Color(0xFF4CAF50);
      default:
        return AppTheme.lightTheme.colorScheme.primary;
    }
  }

  Future<void> _handleRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _loadUserProfile();
    });
    Fluttertoast.showToast(
      msg: "Profile refreshed successfully!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: _getRoleColor(),
      textColor: Colors.white,
    );
    HapticFeedback.lightImpact();
  }

  void _editProfile() {
    Fluttertoast.showToast(
      msg: "Opening profile editor...",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: _getRoleColor(),
      textColor: Colors.white,
    );
  }

  void _handleLogout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: Text(
            _userRole == 'demo'
                ? 'Exit demo mode and return to login?'
                : 'Are you sure you want to logout?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login-screen',
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _getRoleColor(),
              ),
              child: Text(
                _userRole == 'demo' ? 'Exit Demo' : 'Logout',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
