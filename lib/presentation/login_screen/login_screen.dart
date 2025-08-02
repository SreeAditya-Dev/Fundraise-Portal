import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../theme/app_theme.dart';
import './widgets/login_form_widget.dart';
import './widgets/login_illustration_widget.dart';
import './widgets/social_login_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  bool _isLoading = false;
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;

  // Mock credentials for testing
  final Map<String, Map<String, String>> _mockCredentials = {
    'intern@fundraise.com': {
      'password': 'intern123',
      'role': 'user',
      'route': '/dashboard',
    },
    'admin@fundraise.com': {
      'password': 'admin123',
      'role': 'admin',
      'route': '/admin-dashboard',
    },
    'demo@fundraise.com': {
      'password': 'demo123',
      'role': 'demo',
      'route': '/demo-user-dashboard',
    },
  };

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

    // Start slide animation
    _slideController.forward();
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  void _handleLogin(String email, String password) async {
    setState(() {
      _isLoading = true;
    });

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    // Check mock credentials
    if (_mockCredentials.containsKey(email) &&
        _mockCredentials[email]!['password'] == password) {
      // Success - trigger haptic feedback
      HapticFeedback.lightImpact();

      final userRole = _mockCredentials[email]!['role']!;
      final targetRoute = _mockCredentials[email]!['route']!;

      // Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Login successful! Welcome ${_getRoleDisplayName(userRole)}'),
            backgroundColor: AppTheme.lightTheme.colorScheme.tertiary,
            duration: const Duration(seconds: 2),
          ),
        );

        // Navigate to role-specific dashboard
        await Future.delayed(const Duration(milliseconds: 500));
        if (mounted) {
          Navigator.pushReplacementNamed(
            context,
            targetRoute,
            arguments: {'role': userRole},
          );
        }
      }
    } else {
      // Error - show error message with shake animation
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _mockCredentials.containsKey(email)
                  ? 'Invalid password. Please try again.'
                  : 'Invalid email or password. Please check your credentials.',
            ),
            backgroundColor: AppTheme.lightTheme.colorScheme.error,
            duration: const Duration(seconds: 3),
            action: SnackBarAction(
              label: 'Try Demo',
              textColor: Colors.white,
              onPressed: () {
                // Auto-fill demo credentials
                _fillDemoCredentials();
              },
            ),
          ),
        );
      }
    }

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  String _getRoleDisplayName(String role) {
    switch (role) {
      case 'admin':
        return 'to FundRaise Portal Admin';
      case 'demo':
        return 'to Demo Mode';
      default:
        return 'to FundRaise Portal';
    }
  }

  void _fillDemoCredentials() {
    // This would be handled by the form widget if we passed controllers
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Demo credentials: demo@fundraise.com / demo123'),
        duration: Duration(seconds: 3),
      ),
    );
  }

  void _navigateToSignUp() {
    Navigator.pushNamed(context, '/sign-up-screen');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    MediaQuery.of(context).padding.bottom,
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 4.h),

                      // Welcome Text
                      SlideTransition(
                        position: _slideAnimation,
                        child: Column(
                          children: [
                            Text(
                              'Welcome Back!',
                              style: AppTheme
                                  .lightTheme.textTheme.headlineMedium
                                  ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppTheme.lightTheme.colorScheme.primary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 1.h),
                            Text(
                              'Sign in to continue your fundraising journey',
                              style: AppTheme.lightTheme.textTheme.bodyLarge
                                  ?.copyWith(
                                color: AppTheme
                                    .lightTheme.colorScheme.onSurfaceVariant,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 4.h),

                      // Illustration
                      SlideTransition(
                        position: _slideAnimation,
                        child: const LoginIllustrationWidget(),
                      ),

                      SizedBox(height: 4.h),

                      // Login Form
                      SlideTransition(
                        position: _slideAnimation,
                        child: LoginFormWidget(
                          onLogin: _handleLogin,
                          isLoading: _isLoading,
                        ),
                      ),

                      SizedBox(height: 3.h),

                      // Social Login
                      SlideTransition(
                        position: _slideAnimation,
                        child: const SocialLoginWidget(),
                      ),

                      const Spacer(),

                      // Sign Up Link
                      SlideTransition(
                        position: _slideAnimation,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 2.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'New user? ',
                                style: AppTheme.lightTheme.textTheme.bodyMedium
                                    ?.copyWith(
                                  color: AppTheme
                                      .lightTheme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                              GestureDetector(
                                onTap: _navigateToSignUp,
                                child: Text(
                                  'Sign Up',
                                  style: AppTheme
                                      .lightTheme.textTheme.bodyMedium
                                      ?.copyWith(
                                    color:
                                        AppTheme.lightTheme.colorScheme.primary,
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 2.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
