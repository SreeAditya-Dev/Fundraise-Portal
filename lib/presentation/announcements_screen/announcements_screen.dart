import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/announcement_card_widget.dart';
import './widgets/announcement_filter_widget.dart';
import './widgets/announcement_search_widget.dart';
import './widgets/announcement_skeleton_widget.dart';
import './widgets/empty_announcements_widget.dart';

class AnnouncementsScreen extends StatefulWidget {
  const AnnouncementsScreen({Key? key}) : super(key: key);

  @override
  State<AnnouncementsScreen> createState() => _AnnouncementsScreenState();
}

class _AnnouncementsScreenState extends State<AnnouncementsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isLoading = false;
  String _selectedCategory = 'All';
  String _searchQuery = '';
  int _unreadCount = 3;

  final List<String> _categories = [
    'All',
    'General',
    'Achievements',
    'Events',
    'Updates'
  ];

  final List<Map<String, dynamic>> _announcements = [
    {
      'id': 1,
      'category': 'Achievements',
      'headline': 'Congratulations! New Milestone Reached',
      'previewText':
          'Our fundraising team has successfully crossed the ₹50,000 mark this month! This incredible achievement showcases the dedication and hard work of all our interns.',
      'fullContent':
          'Our fundraising team has successfully crossed the ₹50,000 mark this month! This incredible achievement showcases the dedication and hard work of all our interns. Special recognition goes to the top performers who have consistently exceeded their targets. Keep up the excellent work and let\'s aim for even higher goals in the coming weeks. Your efforts are making a real difference in the lives of those we serve.',
      'publishDate': DateTime.now().subtract(const Duration(hours: 2)),
      'likes': 24,
      'isLiked': false,
      'isBookmarked': false,
      'isRead': false,
    },
    {
      'id': 2,
      'category': 'Events',
      'headline': 'Upcoming Workshop: Advanced Fundraising Techniques',
      'previewText':
          'Join us for an exclusive workshop on advanced fundraising strategies scheduled for next Friday at 3:00 PM. Learn from industry experts and enhance your skills.',
      'fullContent':
          'Join us for an exclusive workshop on advanced fundraising strategies scheduled for next Friday at 3:00 PM. Learn from industry experts and enhance your skills. This workshop will cover topics including donor psychology, effective communication techniques, digital fundraising platforms, and building long-term donor relationships. All interns are encouraged to attend as this will directly impact your performance and career growth. Light refreshments will be provided. Please confirm your attendance by Wednesday.',
      'publishDate': DateTime.now().subtract(const Duration(hours: 6)),
      'likes': 18,
      'isLiked': true,
      'isBookmarked': true,
      'isRead': false,
    },
    {
      'id': 3,
      'category': 'General',
      'headline': 'New Referral Code System Launch',
      'previewText':
          'We\'re excited to announce the launch of our new referral code system that will help you track your progress more effectively and earn additional rewards.',
      'fullContent':
          'We\'re excited to announce the launch of our new referral code system that will help you track your progress more effectively and earn additional rewards. Each intern now has a unique referral code that can be shared with potential donors. When someone makes a donation using your code, you\'ll receive instant credit and bonus points towards your monthly targets. The system also includes real-time analytics so you can monitor your referral performance. Check your dashboard to find your personalized referral code and start sharing it today!',
      'publishDate': DateTime.now().subtract(const Duration(days: 1)),
      'likes': 31,
      'isLiked': false,
      'isBookmarked': false,
      'isRead': false,
    },
    {
      'id': 4,
      'category': 'Updates',
      'headline': 'Monthly Leaderboard Update',
      'previewText':
          'The monthly leaderboard has been updated with the latest donation figures. Check your current ranking and see how you compare with other interns.',
      'fullContent':
          'The monthly leaderboard has been updated with the latest donation figures. Check your current ranking and see how you compare with other interns. This month we\'ve seen exceptional performance across all teams with several interns achieving their Bronze, Silver, and Gold milestones. The competition is fierce, and there\'s still time to climb the rankings before the month ends. Remember, consistent daily efforts lead to significant monthly results. Keep pushing towards your goals!',
      'publishDate': DateTime.now().subtract(const Duration(days: 2)),
      'likes': 15,
      'isLiked': false,
      'isBookmarked': true,
      'isRead': true,
    },
    {
      'id': 5,
      'category': 'General',
      'headline': 'Important: Updated Guidelines for Donor Interaction',
      'previewText':
          'Please review the updated guidelines for donor interaction to ensure we maintain the highest standards of professionalism and effectiveness in our communications.',
      'fullContent':
          'Please review the updated guidelines for donor interaction to ensure we maintain the highest standards of professionalism and effectiveness in our communications. The new guidelines include best practices for initial contact, follow-up procedures, handling objections, and maintaining donor relationships. These updates are based on recent feedback and industry best practices. All interns must familiarize themselves with these guidelines by the end of this week. A quiz will be conducted next Monday to ensure everyone understands the new protocols. Your compliance with these guidelines is crucial for our collective success.',
      'publishDate': DateTime.now().subtract(const Duration(days: 3)),
      'likes': 22,
      'isLiked': true,
      'isBookmarked': false,
      'isRead': true,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadAnnouncements();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadAnnouncements() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 1500));

    setState(() {
      _isLoading = false;
    });
  }

  List<Map<String, dynamic>> _getFilteredAnnouncements() {
    List<Map<String, dynamic>> filtered = _announcements;

    // Filter by category
    if (_selectedCategory != 'All') {
      filtered = filtered
          .where((announcement) =>
              (announcement['category'] as String).toLowerCase() ==
              _selectedCategory.toLowerCase())
          .toList();
    }

    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((announcement) {
        final headline = (announcement['headline'] as String).toLowerCase();
        final content = (announcement['fullContent'] as String).toLowerCase();
        final category = (announcement['category'] as String).toLowerCase();
        final query = _searchQuery.toLowerCase();

        return headline.contains(query) ||
            content.contains(query) ||
            category.contains(query);
      }).toList();
    }

    return filtered;
  }

  void _handleAnnouncementTap(Map<String, dynamic> announcement) {
    setState(() {
      announcement['isRead'] = true;
      if (_unreadCount > 0) {
        _unreadCount--;
      }
    });
  }

  void _handleLike(Map<String, dynamic> announcement) {
    setState(() {
      final bool isLiked = announcement['isLiked'] as bool;
      announcement['isLiked'] = !isLiked;
      announcement['likes'] =
          (announcement['likes'] as int) + (isLiked ? -1 : 1);
    });
  }

  void _handleShare(Map<String, dynamic> announcement) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sharing: ${announcement['headline']}'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  void _handleBookmark(Map<String, dynamic> announcement) {
    setState(() {
      announcement['isBookmarked'] = !(announcement['isBookmarked'] as bool);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          announcement['isBookmarked'] as bool
              ? 'Announcement bookmarked'
              : 'Bookmark removed',
        ),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  void _handleMarkAsRead(Map<String, dynamic> announcement) {
    setState(() {
      final bool wasRead = announcement['isRead'] as bool;
      announcement['isRead'] = !wasRead;
      if (wasRead && _unreadCount < _announcements.length) {
        _unreadCount++;
      } else if (!wasRead && _unreadCount > 0) {
        _unreadCount--;
      }
    });
  }

  void _handleRefresh() async {
    await _loadAnnouncements();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Announcements refreshed'),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredAnnouncements = _getFilteredAnnouncements();

    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.lightTheme.appBarTheme.backgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            CustomIconWidget(
              iconName: 'campaign',
              color: AppTheme.lightTheme.colorScheme.primary,
              size: 28,
            ),
            SizedBox(width: 2.w),
            Text(
              'Announcements',
              style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            if (_unreadCount > 0) ...[
              SizedBox(width: 2.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                decoration: BoxDecoration(
                  color: AppTheme.lightTheme.colorScheme.secondary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _unreadCount.toString(),
                  style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.onSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ],
        ),
        actions: [
          IconButton(
            onPressed: _handleRefresh,
            icon: CustomIconWidget(
              iconName: 'refresh',
              color: AppTheme.lightTheme.colorScheme.primary,
              size: 24,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search widget
            AnnouncementSearchWidget(
              onSearchChanged: (query) {
                setState(() {
                  _searchQuery = query;
                });
              },
              onSearchClear: () {
                setState(() {
                  _searchQuery = '';
                });
              },
            ),

            // Filter chips
            AnnouncementFilterWidget(
              selectedCategory: _selectedCategory,
              onCategorySelected: (category) {
                setState(() {
                  _selectedCategory = category;
                });
              },
              categories: _categories,
            ),

            SizedBox(height: 1.h),

            // Content area
            Expanded(
              child: _isLoading
                  ? ListView.builder(
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return const AnnouncementSkeletonWidget();
                      },
                    )
                  : filteredAnnouncements.isEmpty
                      ? EmptyAnnouncementsWidget(
                          onRefresh: _handleRefresh,
                        )
                      : RefreshIndicator(
                          onRefresh: _loadAnnouncements,
                          color: AppTheme.lightTheme.colorScheme.primary,
                          backgroundColor:
                              AppTheme.lightTheme.colorScheme.surface,
                          child: ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: filteredAnnouncements.length,
                            itemBuilder: (context, index) {
                              final announcement = filteredAnnouncements[index];
                              return AnnouncementCardWidget(
                                announcement: announcement,
                                isRead: announcement['isRead'] as bool,
                                onTap: () =>
                                    _handleAnnouncementTap(announcement),
                                onLike: () => _handleLike(announcement),
                                onShare: () => _handleShare(announcement),
                                onBookmark: () => _handleBookmark(announcement),
                                onMarkAsRead: () =>
                                    _handleMarkAsRead(announcement),
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
}
