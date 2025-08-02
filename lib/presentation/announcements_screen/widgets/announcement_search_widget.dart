import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class AnnouncementSearchWidget extends StatefulWidget {
  final Function(String) onSearchChanged;
  final VoidCallback onSearchClear;

  const AnnouncementSearchWidget({
    Key? key,
    required this.onSearchChanged,
    required this.onSearchClear,
  }) : super(key: key);

  @override
  State<AnnouncementSearchWidget> createState() =>
      _AnnouncementSearchWidgetState();
}

class _AnnouncementSearchWidgetState extends State<AnnouncementSearchWidget>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isSearchActive = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _searchController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _toggleSearch() {
    setState(() {
      _isSearchActive = !_isSearchActive;
      if (_isSearchActive) {
        _animationController.forward();
      } else {
        _animationController.reverse();
        _searchController.clear();
        widget.onSearchClear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: Row(
        children: [
          if (!_isSearchActive) ...[
            Expanded(
              child: Text(
                'Announcements',
                style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            GestureDetector(
              onTap: _toggleSearch,
              child: Container(
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  color: AppTheme.lightTheme.colorScheme.primary
                      .withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: CustomIconWidget(
                  iconName: 'search',
                  color: AppTheme.lightTheme.colorScheme.primary,
                  size: 24,
                ),
              ),
            ),
          ] else ...[
            Expanded(
              child: AnimatedBuilder(
                animation: _scaleAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppTheme.lightTheme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppTheme.lightTheme.colorScheme.outline,
                          width: 1,
                        ),
                      ),
                      child: TextField(
                        controller: _searchController,
                        autofocus: true,
                        decoration: InputDecoration(
                          hintText: 'Search announcements...',
                          hintStyle: AppTheme.lightTheme.textTheme.bodyMedium
                              ?.copyWith(
                            color: AppTheme
                                .lightTheme.colorScheme.onSurfaceVariant,
                          ),
                          prefixIcon: CustomIconWidget(
                            iconName: 'search',
                            color: AppTheme
                                .lightTheme.colorScheme.onSurfaceVariant,
                            size: 20,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 4.w,
                            vertical: 1.5.h,
                          ),
                        ),
                        style: AppTheme.lightTheme.textTheme.bodyMedium,
                        onChanged: widget.onSearchChanged,
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(width: 2.w),
            GestureDetector(
              onTap: _toggleSearch,
              child: Container(
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  color: AppTheme.lightTheme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppTheme.lightTheme.colorScheme.outline,
                    width: 1,
                  ),
                ),
                child: CustomIconWidget(
                  iconName: 'close',
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  size: 24,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
