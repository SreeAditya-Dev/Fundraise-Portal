import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class LoginFormWidget extends StatefulWidget {
  final Function(String email, String password) onLogin;
  final bool isLoading;

  const LoginFormWidget({
    Key? key,
    required this.onLogin,
    this.isLoading = false,
  }) : super(key: key);

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isFormValid = false;
  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _shakeAnimation = Tween<double>(
      begin: 0,
      end: 10,
    ).animate(CurvedAnimation(
      parent: _shakeController,
      curve: Curves.elasticIn,
    ));

    _emailController.addListener(_validateForm);
    _passwordController.addListener(_validateForm);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _shakeController.dispose();
    super.dispose();
  }

  void _validateForm() {
    final isValid = _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _isValidEmail(_emailController.text);

    if (_isFormValid != isValid) {
      setState(() {
        _isFormValid = isValid;
      });
    }
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  void _triggerShakeAnimation() {
    _shakeController.forward().then((_) {
      _shakeController.reverse();
    });
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate() && _isFormValid) {
      widget.onLogin(_emailController.text, _passwordController.text);
    } else {
      _triggerShakeAnimation();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _shakeAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_shakeAnimation.value, 0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Email Field
                Container(
                  decoration: BoxDecoration(
                    color: AppTheme.lightTheme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppTheme.lightTheme.colorScheme.outline,
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    style: AppTheme.lightTheme.textTheme.bodyLarge,
                    decoration: InputDecoration(
                      hintText: 'Enter your email',
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(3.w),
                        child: CustomIconWidget(
                          iconName: 'email',
                          color:
                              AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                          size: 20,
                        ),
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 4.w,
                        vertical: 2.h,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!_isValidEmail(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 2.h),

                // Password Field
                Container(
                  decoration: BoxDecoration(
                    color: AppTheme.lightTheme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppTheme.lightTheme.colorScheme.outline,
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    textInputAction: TextInputAction.done,
                    style: AppTheme.lightTheme.textTheme.bodyLarge,
                    decoration: InputDecoration(
                      hintText: 'Enter your password',
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(3.w),
                        child: CustomIconWidget(
                          iconName: 'lock',
                          color:
                              AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                          size: 20,
                        ),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                        icon: CustomIconWidget(
                          iconName: _isPasswordVisible
                              ? 'visibility'
                              : 'visibility_off',
                          color:
                              AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                          size: 20,
                        ),
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 4.w,
                        vertical: 2.h,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                    onFieldSubmitted: (_) => _handleLogin(),
                  ),
                ),
                SizedBox(height: 1.h),

                // Forgot Password Link
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Handle forgot password
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Forgot password feature coming soon!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    child: Text(
                      'Forgot Password?',
                      style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 3.h),

                // Login Button
                Container(
                  width: double.infinity,
                  height: 6.h,
                  decoration: BoxDecoration(
                    gradient: _isFormValid && !widget.isLoading
                        ? AppTheme.primaryGradient
                        : LinearGradient(
                            colors: [
                              AppTheme.lightTheme.colorScheme.outline,
                              AppTheme.lightTheme.colorScheme.outline,
                            ],
                          ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: _isFormValid && !widget.isLoading
                        ? [
                            BoxShadow(
                              color: AppTheme.lightTheme.colorScheme.primary
                                  .withValues(alpha: 0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : null,
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: _isFormValid && !widget.isLoading
                          ? _handleLogin
                          : null,
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        alignment: Alignment.center,
                        child: widget.isLoading
                            ? SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    AppTheme.lightTheme.colorScheme.onPrimary,
                                  ),
                                ),
                              )
                            : Text(
                                'Login',
                                style: AppTheme.lightTheme.textTheme.titleMedium
                                    ?.copyWith(
                                  color: _isFormValid
                                      ? AppTheme
                                          .lightTheme.colorScheme.onPrimary
                                      : AppTheme.lightTheme.colorScheme
                                          .onSurfaceVariant,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
