import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class SocialLoginWidget extends StatelessWidget {
  const SocialLoginWidget({Key? key}) : super(key: key);

  void _handleGoogleLogin(BuildContext context) {
    // Handle Google login
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Google login feature coming soon!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _handleFacebookLogin(BuildContext context) {
    // Handle Facebook login
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Facebook login feature coming soon!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Divider with "Or" text
        Row(
          children: [
            Expanded(
              child: Container(
                height: 1,
                color: AppTheme.lightTheme.colorScheme.outline,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Text(
                'Or',
                style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 1,
                color: AppTheme.lightTheme.colorScheme.outline,
              ),
            ),
          ],
        ),
        SizedBox(height: 3.h),

        // Social Login Buttons
        Row(
          children: [
            // Google Login Button
            Expanded(
              child: Container(
                height: 6.h,
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
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => _handleGoogleLogin(context),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomImageWidget(
                            imageUrl:
                                'https://developers.google.com/identity/images/g-logo.png',
                            width: 20,
                            height: 20,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            'Google',
                            style: AppTheme.lightTheme.textTheme.bodyMedium
                                ?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 3.w),

            // Facebook Login Button
            Expanded(
              child: Container(
                height: 6.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF1877F2),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF1877F2).withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => _handleFacebookLogin(context),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomIconWidget(
                            iconName: 'facebook',
                            color: Colors.white,
                            size: 20,
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            'Facebook',
                            style: AppTheme.lightTheme.textTheme.bodyMedium
                                ?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
