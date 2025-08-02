import 'package:flutter/material.dart';
import '../presentation/splash_screen/splash_screen.dart';
import '../presentation/leaderboard_screen/leaderboard_screen.dart';
import '../presentation/announcements_screen/announcements_screen.dart';
import '../presentation/login_screen/login_screen.dart';
import '../presentation/dashboard/dashboard.dart';
import '../presentation/sign_up_screen/sign_up_screen.dart';
import '../presentation/admin_dashboard/admin_dashboard.dart';
import '../presentation/demo_user_dashboard/demo_user_dashboard.dart';
import '../presentation/profile_screen/profile_screen.dart';

class AppRoutes {
  // TODO: Add your routes here
  static const String initial = '/';
  static const String splash = '/splash-screen';
  static const String leaderboard = '/leaderboard-screen';
  static const String announcements = '/announcements-screen';
  static const String login = '/login-screen';
  static const String dashboard = '/dashboard';
  static const String signUp = '/sign-up-screen';
  static const String adminDashboard = '/admin-dashboard';
  static const String demoUserDashboard = '/demo-user-dashboard';
  static const String profile = '/profile-screen';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => const SplashScreen(),
    splash: (context) => const SplashScreen(),
    leaderboard: (context) => const LeaderboardScreen(),
    announcements: (context) => const AnnouncementsScreen(),
    login: (context) => const LoginScreen(),
    dashboard: (context) => const Dashboard(),
    signUp: (context) => const SignUpScreen(),
    adminDashboard: (context) => const AdminDashboard(),
    demoUserDashboard: (context) => const DemoUserDashboard(),
    profile: (context) => const ProfileScreen(),
    // TODO: Add your other routes here
  };
}
