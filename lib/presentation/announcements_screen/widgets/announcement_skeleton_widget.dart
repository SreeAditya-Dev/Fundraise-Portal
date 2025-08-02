import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class AnnouncementSkeletonWidget extends StatefulWidget {
  const AnnouncementSkeletonWidget({Key? key}) : super(key: key);

  @override
  State<AnnouncementSkeletonWidget> createState() =>
      _AnnouncementSkeletonWidgetState();
}

class _AnnouncementSkeletonWidgetState extends State<AnnouncementSkeletonWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0.3,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header skeleton
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _animation.value,
                      child: Container(
                        width: 20.w,
                        height: 3.h,
                        decoration: BoxDecoration(
                          color: AppTheme.lightTheme.colorScheme.outline
                              .withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    );
                  },
                ),
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _animation.value,
                      child: Container(
                        width: 15.w,
                        height: 2.h,
                        decoration: BoxDecoration(
                          color: AppTheme.lightTheme.colorScheme.outline
                              .withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 2.h),

            // Title skeleton
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Opacity(
                  opacity: _animation.value,
                  child: Container(
                    width: 80.w,
                    height: 2.5.h,
                    decoration: BoxDecoration(
                      color: AppTheme.lightTheme.colorScheme.outline
                          .withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 1.h),

            // Content skeleton lines
            ...List.generate(
                3,
                (index) => Column(
                      children: [
                        AnimatedBuilder(
                          animation: _animation,
                          builder: (context, child) {
                            return Opacity(
                              opacity: _animation.value,
                              child: Container(
                                width: index == 2 ? 60.w : 85.w,
                                height: 2.h,
                                decoration: BoxDecoration(
                                  color: AppTheme.lightTheme.colorScheme.outline
                                      .withValues(alpha: 0.3),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 0.5.h),
                      ],
                    )),

            SizedBox(height: 2.h),

            // Action buttons skeleton
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        return Opacity(
                          opacity: _animation.value,
                          child: Container(
                            width: 12.w,
                            height: 3.h,
                            decoration: BoxDecoration(
                              color: AppTheme.lightTheme.colorScheme.outline
                                  .withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(width: 6.w),
                    AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        return Opacity(
                          opacity: _animation.value,
                          child: Container(
                            width: 6.w,
                            height: 3.h,
                            decoration: BoxDecoration(
                              color: AppTheme.lightTheme.colorScheme.outline
                                  .withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _animation.value,
                      child: Container(
                        width: 6.w,
                        height: 3.h,
                        decoration: BoxDecoration(
                          color: AppTheme.lightTheme.colorScheme.outline
                              .withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
