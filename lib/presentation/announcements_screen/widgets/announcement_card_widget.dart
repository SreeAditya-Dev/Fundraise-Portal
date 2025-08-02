import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class AnnouncementCardWidget extends StatefulWidget {
  final Map<String, dynamic> announcement;
  final bool isRead;
  final VoidCallback onTap;
  final VoidCallback onLike;
  final VoidCallback onShare;
  final VoidCallback onBookmark;
  final VoidCallback? onMarkAsRead;

  const AnnouncementCardWidget({
    Key? key,
    required this.announcement,
    required this.isRead,
    required this.onTap,
    required this.onLike,
    required this.onShare,
    required this.onBookmark,
    this.onMarkAsRead,
  }) : super(key: key);

  @override
  State<AnnouncementCardWidget> createState() => _AnnouncementCardWidgetState();
}

class _AnnouncementCardWidgetState extends State<AnnouncementCardWidget>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  bool _isRecent() {
    final DateTime publishDate = widget.announcement['publishDate'] as DateTime;
    final DateTime now = DateTime.now();
    return now.difference(publishDate).inHours < 24;
  }

  void _showContextMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.outline,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName:
                    widget.isRead ? 'mark_email_unread' : 'mark_email_read',
                color: AppTheme.lightTheme.colorScheme.primary,
                size: 24,
              ),
              title: Text(
                widget.isRead ? 'Mark as Unread' : 'Mark as Read',
                style: AppTheme.lightTheme.textTheme.bodyLarge,
              ),
              onTap: () {
                Navigator.pop(context);
                widget.onMarkAsRead?.call();
              },
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'share',
                color: AppTheme.lightTheme.colorScheme.primary,
                size: 24,
              ),
              title: Text(
                'Share',
                style: AppTheme.lightTheme.textTheme.bodyLarge,
              ),
              onTap: () {
                Navigator.pop(context);
                widget.onShare();
              },
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'report',
                color: AppTheme.lightTheme.colorScheme.error,
                size: 24,
              ),
              title: Text(
                'Report Issue',
                style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.error,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Issue reported successfully'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String category = widget.announcement['category'] as String;
    final String headline = widget.announcement['headline'] as String;
    final String previewText = widget.announcement['previewText'] as String;
    final String fullContent = widget.announcement['fullContent'] as String;
    final DateTime publishDate = widget.announcement['publishDate'] as DateTime;
    final int likes = widget.announcement['likes'] as int;
    final bool isLiked = widget.announcement['isLiked'] as bool;
    final bool isBookmarked = widget.announcement['isBookmarked'] as bool;

    return GestureDetector(
      onLongPress: () => _showContextMenu(context),
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        elevation: widget.isRead ? 2 : 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: widget.isRead
              ? BorderSide.none
              : BorderSide(
                  color: AppTheme.lightTheme.colorScheme.secondary,
                  width: 2,
                ),
        ),
        child: InkWell(
          onTap: () {
            widget.onTap();
            _toggleExpansion();
          },
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: EdgeInsets.all(4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with category and date
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 2.w,
                            vertical: 0.5.h,
                          ),
                          decoration: BoxDecoration(
                            color: _getCategoryColor(category)
                                .withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            category,
                            style: AppTheme.lightTheme.textTheme.labelSmall
                                ?.copyWith(
                              color: _getCategoryColor(category),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        if (_isRecent()) ...[
                          SizedBox(width: 2.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 2.w,
                              vertical: 0.5.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.lightTheme.colorScheme.secondary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'New',
                              style: AppTheme.lightTheme.textTheme.labelSmall
                                  ?.copyWith(
                                color:
                                    AppTheme.lightTheme.colorScheme.onSecondary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    Text(
                      _formatDate(publishDate),
                      style: AppTheme.lightTheme.textTheme.bodySmall,
                    ),
                  ],
                ),
                SizedBox(height: 2.h),

                // Headline
                Text(
                  headline,
                  style: widget.isRead
                      ? AppTheme.lightTheme.textTheme.titleMedium
                      : AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 1.h),

                // Preview text or full content
                AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: Text(
                    _isExpanded ? fullContent : previewText,
                    style: AppTheme.lightTheme.textTheme.bodyMedium,
                    maxLines: _isExpanded ? null : 3,
                    overflow: _isExpanded ? null : TextOverflow.ellipsis,
                  ),
                ),

                // Read More button
                if (!_isExpanded &&
                    fullContent.length > previewText.length) ...[
                  SizedBox(height: 1.h),
                  GestureDetector(
                    onTap: _toggleExpansion,
                    child: Text(
                      'Read More',
                      style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],

                SizedBox(height: 2.h),

                // Action buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        // Like button
                        GestureDetector(
                          onTap: widget.onLike,
                          child: Row(
                            children: [
                              CustomIconWidget(
                                iconName:
                                    isLiked ? 'favorite' : 'favorite_border',
                                color: isLiked
                                    ? AppTheme.lightTheme.colorScheme.secondary
                                    : AppTheme.lightTheme.colorScheme
                                        .onSurfaceVariant,
                                size: 20,
                              ),
                              SizedBox(width: 1.w),
                              Text(
                                likes.toString(),
                                style: AppTheme.lightTheme.textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 6.w),

                        // Share button
                        GestureDetector(
                          onTap: widget.onShare,
                          child: CustomIconWidget(
                            iconName: 'share',
                            color: AppTheme
                                .lightTheme.colorScheme.onSurfaceVariant,
                            size: 20,
                          ),
                        ),
                      ],
                    ),

                    // Bookmark button
                    GestureDetector(
                      onTap: widget.onBookmark,
                      child: CustomIconWidget(
                        iconName: isBookmarked ? 'bookmark' : 'bookmark_border',
                        color: isBookmarked
                            ? AppTheme.lightTheme.colorScheme.primary
                            : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'general':
        return AppTheme.lightTheme.colorScheme.primary;
      case 'achievements':
        return AppTheme.lightTheme.colorScheme.tertiary;
      case 'events':
        return AppTheme.lightTheme.colorScheme.secondary;
      case 'updates':
        return const Color(0xFFF59E0B);
      default:
        return AppTheme.lightTheme.colorScheme.primary;
    }
  }

  String _formatDate(DateTime date) {
    final DateTime now = DateTime.now();
    final Duration difference = now.difference(date);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        return '${difference.inMinutes}m ago';
      }
      return '${difference.inHours}h ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}
