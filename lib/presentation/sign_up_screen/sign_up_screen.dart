import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;
  bool _acceptTerms = false;
  double _passwordStrength = 0.0;
  String _passwordStrengthText = '';
  Color _passwordStrengthColor = Colors.red;

  late AnimationController _confettiController;
  late AnimationController _buttonController;
  late Animation<double> _buttonAnimation;

  @override
  void initState() {
    super.initState();
    _confettiController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _buttonController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _buttonAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _buttonController,
      curve: Curves.easeInOut,
    ));

    _passwordController.addListener(_checkPasswordStrength);
    _confirmPasswordController.addListener(_validateForm);
    _nameController.addListener(_validateForm);
    _emailController.addListener(_validateForm);
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _buttonController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _checkPasswordStrength() {
    final password = _passwordController.text;
    double strength = 0.0;
    String strengthText = '';
    Color strengthColor = AppTheme.errorLight;

    if (password.isEmpty) {
      strength = 0.0;
      strengthText = '';
    } else if (password.length < 6) {
      strength = 0.2;
      strengthText = 'Weak';
      strengthColor = AppTheme.errorLight;
    } else if (password.length < 8) {
      strength = 0.4;
      strengthText = 'Fair';
      strengthColor = AppTheme.warningLight;
    } else {
      bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
      bool hasLowercase = password.contains(RegExp(r'[a-z]'));
      bool hasDigits = password.contains(RegExp(r'[0-9]'));
      bool hasSpecialCharacters =
          password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

      int criteriaCount = 0;
      if (hasUppercase) criteriaCount++;
      if (hasLowercase) criteriaCount++;
      if (hasDigits) criteriaCount++;
      if (hasSpecialCharacters) criteriaCount++;

      if (criteriaCount >= 3) {
        strength = 0.8;
        strengthText = 'Strong';
        strengthColor = AppTheme.successLight;
      } else if (criteriaCount >= 2) {
        strength = 0.6;
        strengthText = 'Good';
        strengthColor = AppTheme.warningLight;
      } else {
        strength = 0.4;
        strengthText = 'Fair';
        strengthColor = AppTheme.warningLight;
      }
    }

    setState(() {
      _passwordStrength = strength;
      _passwordStrengthText = strengthText;
      _passwordStrengthColor = strengthColor;
    });
  }

  void _validateForm() {
    setState(() {});
  }

  bool get _isFormValid {
    return _nameController.text.trim().isNotEmpty &&
        _emailController.text.trim().isNotEmpty &&
        _isValidEmail(_emailController.text.trim()) &&
        _passwordController.text.isNotEmpty &&
        _passwordStrength >= 0.6 &&
        _confirmPasswordController.text.isNotEmpty &&
        _passwordController.text == _confirmPasswordController.text &&
        _acceptTerms;
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  Future<void> _handleSignUp() async {
    if (!_formKey.currentState!.validate() || !_isFormValid) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    // Check for existing email (mock validation)
    if (_emailController.text.trim().toLowerCase() == 'test@example.com') {
      _showErrorSnackBar('Email already exists. Please use a different email.');
      setState(() {
        _isLoading = false;
      });
      return;
    }

    // Success - trigger confetti animation
    _confettiController.forward();

    // Haptic feedback
    HapticFeedback.lightImpact();

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Account created successfully! Welcome aboard!',
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            color: Colors.white,
          ),
        ),
        backgroundColor: AppTheme.successLight,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        duration: const Duration(seconds: 2),
      ),
    );

    // Navigate to dashboard after animation
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/dashboard',
        (route) => false,
      );
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            color: Colors.white,
          ),
        ),
        backgroundColor: AppTheme.errorLight,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Back button
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: EdgeInsets.all(2.w),
                        decoration: BoxDecoration(
                          color: AppTheme.lightTheme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: CustomIconWidget(
                          iconName: 'arrow_back',
                          color: AppTheme.lightTheme.colorScheme.onSurface,
                          size: 24,
                        ),
                      ),
                    ),

                    SizedBox(height: 4.h),

                    // Header illustration
                    Center(
                      child: Container(
                        width: 60.w,
                        height: 20.h,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppTheme.secondaryLight.withValues(alpha: 0.1),
                              AppTheme.primaryLight.withValues(alpha: 0.1),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomIconWidget(
                              iconName: 'person_add',
                              color: AppTheme.primaryLight,
                              size: 48,
                            ),
                            SizedBox(height: 1.h),
                            Text(
                              'Join FundRaise',
                              style: AppTheme.lightTheme.textTheme.titleMedium
                                  ?.copyWith(
                                color: AppTheme.primaryLight,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 4.h),

                    // Welcome text
                    Text(
                      'Create Account',
                      style:
                          AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppTheme.lightTheme.colorScheme.onSurface,
                      ),
                    ),

                    SizedBox(height: 1.h),

                    Text(
                      'Start your fundraising journey today',
                      style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                      ),
                    ),

                    SizedBox(height: 4.h),

                    // Full Name field
                    _buildInputField(
                      controller: _nameController,
                      label: 'Full Name',
                      hint: 'Enter your full name',
                      icon: 'person',
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your full name';
                        }
                        if (value.trim().length < 2) {
                          return 'Name must be at least 2 characters';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 3.h),

                    // Email field
                    _buildInputField(
                      controller: _emailController,
                      label: 'Email Address',
                      hint: 'Enter your email',
                      icon: 'email',
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!_isValidEmail(value.trim())) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 3.h),

                    // Password field
                    _buildPasswordField(
                      controller: _passwordController,
                      label: 'Password',
                      hint: 'Create a strong password',
                      isVisible: _isPasswordVisible,
                      onVisibilityToggle: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),

                    // Password strength indicator
                    if (_passwordController.text.isNotEmpty) ...[
                      SizedBox(height: 1.h),
                      _buildPasswordStrengthIndicator(),
                    ],

                    SizedBox(height: 3.h),

                    // Confirm Password field
                    _buildPasswordField(
                      controller: _confirmPasswordController,
                      label: 'Confirm Password',
                      hint: 'Re-enter your password',
                      isVisible: _isConfirmPasswordVisible,
                      onVisibilityToggle: () {
                        setState(() {
                          _isConfirmPasswordVisible =
                              !_isConfirmPasswordVisible;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 3.h),

                    // Terms and conditions checkbox
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: _acceptTerms,
                          onChanged: (value) {
                            setState(() {
                              _acceptTerms = value ?? false;
                            });
                          },
                          activeColor: AppTheme.primaryLight,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(top: 1.h),
                            child: RichText(
                              text: TextSpan(
                                style: AppTheme.lightTheme.textTheme.bodyMedium
                                    ?.copyWith(
                                  color: AppTheme
                                      .lightTheme.colorScheme.onSurfaceVariant,
                                ),
                                children: [
                                  const TextSpan(text: 'I agree to the '),
                                  TextSpan(
                                    text: 'Terms and Conditions',
                                    style: TextStyle(
                                      color: AppTheme.primaryLight,
                                      fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  const TextSpan(text: ' and '),
                                  TextSpan(
                                    text: 'Privacy Policy',
                                    style: TextStyle(
                                      color: AppTheme.primaryLight,
                                      fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 4.h),

                    // Create Account button
                    AnimatedBuilder(
                      animation: _buttonAnimation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _buttonAnimation.value,
                          child: SizedBox(
                            width: double.infinity,
                            height: 7.h,
                            child: ElevatedButton(
                              onPressed: _isFormValid && !_isLoading
                                  ? () async {
                                      await _buttonController.forward();
                                      await _buttonController.reverse();
                                      _handleSignUp();
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _isFormValid
                                    ? AppTheme.primaryLight
                                    : AppTheme
                                        .lightTheme.colorScheme.onSurfaceVariant
                                        .withValues(alpha: 0.3),
                                foregroundColor: Colors.white,
                                elevation: _isFormValid ? 4 : 0,
                                shadowColor: AppTheme.primaryLight
                                    .withValues(alpha: 0.3),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: _isLoading
                                  ? SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          Colors.white,
                                        ),
                                      ),
                                    )
                                  : Text(
                                      'Create Account',
                                      style: AppTheme
                                          .lightTheme.textTheme.titleMedium
                                          ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                            ),
                          ),
                        );
                      },
                    ),

                    SizedBox(height: 3.h),

                    // Login link
                    Center(
                      child: RichText(
                        text: TextSpan(
                          style: AppTheme.lightTheme.textTheme.bodyMedium
                              ?.copyWith(
                            color: AppTheme
                                .lightTheme.colorScheme.onSurfaceVariant,
                          ),
                          children: [
                            const TextSpan(text: 'Already have an account? '),
                            WidgetSpan(
                              child: GestureDetector(
                                onTap: () => Navigator.pushReplacementNamed(
                                    context, '/login-screen'),
                                child: Text(
                                  'Sign In',
                                  style: AppTheme
                                      .lightTheme.textTheme.bodyMedium
                                      ?.copyWith(
                                    color: AppTheme.primaryLight,
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 4.h),
                  ],
                ),
              ),
            ),

            // Confetti overlay
            if (_confettiController.isAnimating)
              Positioned.fill(
                child: IgnorePointer(
                  child: AnimatedBuilder(
                    animation: _confettiController,
                    builder: (context, child) {
                      return CustomPaint(
                        painter: ConfettiPainter(_confettiController.value),
                        size: Size.infinite,
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required String icon,
    required TextInputType keyboardType,
    required String? Function(String?) validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        style: AppTheme.lightTheme.textTheme.bodyLarge,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: Padding(
            padding: EdgeInsets.all(3.w),
            child: CustomIconWidget(
              iconName: icon,
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              size: 24,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: AppTheme.primaryLight,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: AppTheme.errorLight,
              width: 1,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: AppTheme.errorLight,
              width: 2,
            ),
          ),
          filled: true,
          fillColor: AppTheme.lightTheme.colorScheme.surface,
          contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required bool isVisible,
    required VoidCallback onVisibilityToggle,
    required String? Function(String?) validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        obscureText: !isVisible,
        validator: validator,
        style: AppTheme.lightTheme.textTheme.bodyLarge,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: Padding(
            padding: EdgeInsets.all(3.w),
            child: CustomIconWidget(
              iconName: 'lock',
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              size: 24,
            ),
          ),
          suffixIcon: GestureDetector(
            onTap: onVisibilityToggle,
            child: Padding(
              padding: EdgeInsets.all(3.w),
              child: CustomIconWidget(
                iconName: isVisible ? 'visibility' : 'visibility_off',
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                size: 24,
              ),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: AppTheme.primaryLight,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: AppTheme.errorLight,
              width: 1,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: AppTheme.errorLight,
              width: 2,
            ),
          ),
          filled: true,
          fillColor: AppTheme.lightTheme.colorScheme.surface,
          contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        ),
      ),
    );
  }

  Widget _buildPasswordStrengthIndicator() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                height: 4,
                decoration: BoxDecoration(
                  color: AppTheme.lightTheme.colorScheme.outline
                      .withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: _passwordStrength,
                  child: Container(
                    decoration: BoxDecoration(
                      color: _passwordStrengthColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 2.w),
            Text(
              _passwordStrengthText,
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                color: _passwordStrengthColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        if (_passwordStrength < 0.6 && _passwordController.text.isNotEmpty) ...[
          SizedBox(height: 0.5.h),
          Text(
            'Use uppercase, lowercase, numbers, and special characters',
            style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ],
    );
  }
}

class ConfettiPainter extends CustomPainter {
  final double progress;

  ConfettiPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final colors = [
      AppTheme.primaryLight,
      AppTheme.secondaryLight,
      AppTheme.successLight,
      AppTheme.warningLight,
    ];

    for (int i = 0; i < 50; i++) {
      final x = (i * 37.0) % size.width;
      final y = (progress * size.height + (i * 23.0) % 100) % size.height;

      paint.color = colors[i % colors.length];
      canvas.drawCircle(
        Offset(x, y),
        3.0 + (i % 3),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
