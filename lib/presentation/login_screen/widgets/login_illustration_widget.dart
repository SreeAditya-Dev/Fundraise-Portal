import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class LoginIllustrationWidget extends StatefulWidget {
  const LoginIllustrationWidget({Key? key}) : super(key: key);

  @override
  State<LoginIllustrationWidget> createState() =>
      _LoginIllustrationWidgetState();
}

class _LoginIllustrationWidgetState extends State<LoginIllustrationWidget>
    with TickerProviderStateMixin {
  late AnimationController _floatingController;
  late Animation<double> _floatingAnimation;
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Floating animation
    _floatingController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _floatingAnimation = Tween<double>(
      begin: -10,
      end: 10,
    ).animate(CurvedAnimation(
      parent: _floatingController,
      curve: Curves.easeInOut,
    ));

    // Scale animation
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    ));

    // Start scale animation
    _scaleController.forward();
  }

  @override
  void dispose() {
    _floatingController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.h,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background gradient circle
          AnimatedBuilder(
            animation: _scaleAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: Container(
                  width: 60.w,
                  height: 60.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: AppTheme.primaryGradient.scale(0.3),
                  ),
                ),
              );
            },
          ),

          // Floating illustration
          AnimatedBuilder(
            animation: _floatingAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, _floatingAnimation.value),
                child: AnimatedBuilder(
                  animation: _scaleAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _scaleAnimation.value,
                      child: Container(
                        width: 50.w,
                        height: 50.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTheme.lightTheme.colorScheme.surface,
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.lightTheme.colorScheme.primary
                                  .withValues(alpha: 0.2),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Main illustration
                            CustomImageWidget(
                              imageUrl:
                                  'https://images.unsplash.com/photo-1551434678-e076c223a692?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3',
                              width: 35.w,
                              height: 35.w,
                              fit: BoxFit.cover,
                            ),

                            // Overlay with fundraising icon
                            Container(
                              width: 35.w,
                              height: 35.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppTheme.lightTheme.colorScheme.primary
                                    .withValues(alpha: 0.8),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomIconWidget(
                                    iconName: 'volunteer_activism',
                                    color: AppTheme
                                        .lightTheme.colorScheme.onPrimary,
                                    size: 40,
                                  ),
                                  SizedBox(height: 1.h),
                                  Text(
                                    'FundRaise',
                                    style: AppTheme
                                        .lightTheme.textTheme.titleMedium
                                        ?.copyWith(
                                      color: AppTheme
                                          .lightTheme.colorScheme.onPrimary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Portal',
                                    style: AppTheme
                                        .lightTheme.textTheme.bodySmall
                                        ?.copyWith(
                                      color: AppTheme
                                          .lightTheme.colorScheme.onPrimary,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),

          // Decorative elements
          Positioned(
            top: 5.h,
            left: 10.w,
            child: AnimatedBuilder(
              animation: _floatingController,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _floatingController.value * 0.5,
                  child: Container(
                    width: 8.w,
                    height: 8.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.lightTheme.colorScheme.secondary
                          .withValues(alpha: 0.6),
                    ),
                  ),
                );
              },
            ),
          ),

          Positioned(
            bottom: 8.h,
            right: 15.w,
            child: AnimatedBuilder(
              animation: _floatingController,
              builder: (context, child) {
                return Transform.rotate(
                  angle: -_floatingController.value * 0.3,
                  child: Container(
                    width: 6.w,
                    height: 6.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: AppTheme.lightTheme.colorScheme.tertiary
                          .withValues(alpha: 0.7),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

extension on LinearGradient {
  LinearGradient scale(double opacity) {
    return LinearGradient(
      colors: colors.map((color) => color.withValues(alpha: opacity)).toList(),
      begin: begin,
      end: end,
    );
  }
}
