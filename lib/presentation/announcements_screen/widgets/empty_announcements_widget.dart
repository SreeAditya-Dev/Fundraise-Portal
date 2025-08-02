import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class EmptyAnnouncementsWidget extends StatefulWidget {
  final VoidCallback onRefresh;

  const EmptyAnnouncementsWidget({
    Key? key,
    required this.onRefresh,
  }) : super(key: key);

  @override
  State<EmptyAnnouncementsWidget> createState() =>
      _EmptyAnnouncementsWidgetState();
}

class _EmptyAnnouncementsWidgetState extends State<EmptyAnnouncementsWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return FadeTransition(
            opacity: _fadeAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Illustration container
                  Container(
                    width: 60.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                      color: AppTheme.lightTheme.colorScheme.primary
                          .withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomIconWidget(
                          iconName: 'campaign',
                          color: AppTheme.lightTheme.colorScheme.primary,
                          size: 80,
                        ),
                        SizedBox(height: 2.h),
                        Container(
                          width: 40.w,
                          height: 0.5.h,
                          decoration: BoxDecoration(
                            color: AppTheme.lightTheme.colorScheme.primary
                                .withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Container(
                          width: 30.w,
                          height: 0.5.h,
                          decoration: BoxDecoration(
                            color: AppTheme.lightTheme.colorScheme.primary
                                .withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 4.h),

                  // Empty state text
                  Text(
                    'No announcements yet',
                    style:
                        AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.lightTheme.colorScheme.onSurface,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 1.h),

                  Text(
                    'Check back later for important updates\nand news from your fundraising team',
                    style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 4.h),

                  // Refresh button
                  ElevatedButton.icon(
                    onPressed: widget.onRefresh,
                    icon: CustomIconWidget(
                      iconName: 'refresh',
                      color: AppTheme.lightTheme.colorScheme.onPrimary,
                      size: 20,
                    ),
                    label: Text(
                      'Refresh',
                      style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.onPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.lightTheme.colorScheme.primary,
                      foregroundColor:
                          AppTheme.lightTheme.colorScheme.onPrimary,
                      padding: EdgeInsets.symmetric(
                          horizontal: 6.w, vertical: 1.5.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
