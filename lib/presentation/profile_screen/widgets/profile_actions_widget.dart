import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ProfileActionsWidget extends StatelessWidget {
  final String userRole;
  final Color roleColor;
  final VoidCallback onLogout;

  const ProfileActionsWidget({
    Key? key,
    required this.userRole,
    required this.roleColor,
    required this.onLogout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(4.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Actions',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 2.h),

          // Action Buttons Grid
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 3.w,
            mainAxisSpacing: 2.h,
            childAspectRatio: 2.5,
            children: _getActionButtons(context),
          ),

          SizedBox(height: 3.h),

          // Logout Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: onLogout,
              icon: CustomIconWidget(
                iconName: 'logout',
                color: Colors.white,
                size: 5.w,
              ),
              label: Text(
                userRole == 'demo' ? 'Exit Demo' : 'Logout',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF44336),
                padding: EdgeInsets.symmetric(vertical: 2.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3.w),
                ),
              ),
            ),
          ),

          if (userRole == 'demo') ...[
            SizedBox(height: 2.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color: roleColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(3.w),
                border: Border.all(
                  color: roleColor.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  CustomIconWidget(
                    iconName: 'info',
                    color: roleColor,
                    size: 5.w,
                  ),
                  SizedBox(width: 2.w),
                  Expanded(
                    child: Text(
                      'Demo mode allows you to explore all features. Create a real account to start fundraising!',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: roleColor,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  List<Widget> _getActionButtons(BuildContext context) {
    List<Map<String, dynamic>> actions = [];

    switch (userRole) {
      case 'admin':
        actions = [
          {
            'title': 'Export Data',
            'icon': 'file_download',
            'color': const Color(0xFF2196F3),
            'action': () => _exportData(context),
          },
          {
            'title': 'System Reports',
            'icon': 'analytics',
            'color': const Color(0xFF4CAF50),
            'action': () => _viewReports(context),
          },
          {
            'title': 'Send Announcement',
            'icon': 'campaign',
            'color': const Color(0xFFFF9800),
            'action': () => _sendAnnouncement(context),
          },
          {
            'title': 'Backup System',
            'icon': 'backup',
            'color': const Color(0xFF9C27B0),
            'action': () => _backupSystem(context),
          },
        ];
        break;
      case 'demo':
        actions = [
          {
            'title': 'Reset Demo',
            'icon': 'refresh',
            'color': const Color(0xFFFF9800),
            'action': () => _resetDemo(context),
          },
          {
            'title': 'Share Demo',
            'icon': 'share',
            'color': const Color(0xFF2196F3),
            'action': () => _shareDemo(context),
          },
          {
            'title': 'View Tutorial',
            'icon': 'help_outline',
            'color': const Color(0xFF9C27B0),
            'action': () => _viewTutorial(context),
          },
          {
            'title': 'Feedback',
            'icon': 'feedback',
            'color': const Color(0xFF4CAF50),
            'action': () => _sendFeedback(context),
          },
        ];
        break;
      default:
        actions = [
          {
            'title': 'Share Profile',
            'icon': 'share',
            'color': const Color(0xFF2196F3),
            'action': () => _shareProfile(context),
          },
          {
            'title': 'View Stats',
            'icon': 'analytics',
            'color': const Color(0xFF4CAF50),
            'action': () => _viewStats(context),
          },
          {
            'title': 'Help & Support',
            'icon': 'help_outline',
            'color': const Color(0xFF9C27B0),
            'action': () => _getHelp(context),
          },
          {
            'title': 'Referral Code',
            'icon': 'qr_code',
            'color': const Color(0xFFFF9800),
            'action': () => _showReferralCode(context),
          },
        ];
    }

    return actions.map((action) {
      return _buildActionButton(
        context,
        action['title'],
        action['icon'],
        action['color'],
        action['action'],
      );
    }).toList();
  }

  Widget _buildActionButton(
    BuildContext context,
    String title,
    String icon,
    Color color,
    VoidCallback onPressed,
  ) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color.withValues(alpha: 0.1),
        foregroundColor: color,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3.w),
          side: BorderSide(color: color.withValues(alpha: 0.3)),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomIconWidget(
            iconName: icon,
            color: color,
            size: 6.w,
          ),
          SizedBox(height: 0.5.h),
          Text(
            title,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Action implementations
  void _exportData(BuildContext context) {
    Fluttertoast.showToast(
      msg: "Exporting admin data...",
      backgroundColor: roleColor,
      textColor: Colors.white,
    );
  }

  void _viewReports(BuildContext context) {
    Fluttertoast.showToast(
      msg: "Opening system reports...",
      backgroundColor: roleColor,
      textColor: Colors.white,
    );
  }

  void _sendAnnouncement(BuildContext context) {
    Fluttertoast.showToast(
      msg: "Opening announcement composer...",
      backgroundColor: roleColor,
      textColor: Colors.white,
    );
  }

  void _backupSystem(BuildContext context) {
    Fluttertoast.showToast(
      msg: "Initiating system backup...",
      backgroundColor: roleColor,
      textColor: Colors.white,
    );
  }

  void _resetDemo(BuildContext context) {
    Fluttertoast.showToast(
      msg: "Demo reset to initial state!",
      backgroundColor: roleColor,
      textColor: Colors.white,
    );
  }

  void _shareDemo(BuildContext context) {
    Fluttertoast.showToast(
      msg: "Sharing demo experience...",
      backgroundColor: roleColor,
      textColor: Colors.white,
    );
  }

  void _viewTutorial(BuildContext context) {
    Fluttertoast.showToast(
      msg: "Starting interactive tutorial...",
      backgroundColor: roleColor,
      textColor: Colors.white,
    );
  }

  void _sendFeedback(BuildContext context) {
    Fluttertoast.showToast(
      msg: "Opening feedback form...",
      backgroundColor: roleColor,
      textColor: Colors.white,
    );
  }

  void _shareProfile(BuildContext context) {
    Fluttertoast.showToast(
      msg: "Sharing your profile...",
      backgroundColor: roleColor,
      textColor: Colors.white,
    );
  }

  void _viewStats(BuildContext context) {
    Fluttertoast.showToast(
      msg: "Opening detailed statistics...",
      backgroundColor: roleColor,
      textColor: Colors.white,
    );
  }

  void _getHelp(BuildContext context) {
    Fluttertoast.showToast(
      msg: "Opening help & support...",
      backgroundColor: roleColor,
      textColor: Colors.white,
    );
  }

  void _showReferralCode(BuildContext context) {
    Fluttertoast.showToast(
      msg: "Displaying referral QR code...",
      backgroundColor: roleColor,
      textColor: Colors.white,
    );
  }
}
