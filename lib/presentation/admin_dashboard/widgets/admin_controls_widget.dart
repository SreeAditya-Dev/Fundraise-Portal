import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class AdminControlsWidget extends StatelessWidget {
  const AdminControlsWidget({Key? key}) : super(key: key);

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
            'Administrative Controls',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 2.h),

          // Quick Actions Grid
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 3.w,
            mainAxisSpacing: 2.h,
            childAspectRatio: 2.5,
            children: [
              _buildControlButton(
                context,
                'Send Notification',
                Icons.notifications_active,
                const Color(0xFF2196F3),
                () => _sendNotification(context),
              ),
              _buildControlButton(
                context,
                'Export Reports',
                Icons.file_download,
                const Color(0xFF4CAF50),
                () => _exportReports(context),
              ),
              _buildControlButton(
                context,
                'Approve Requests',
                Icons.check_circle,
                const Color(0xFFFF9800),
                () => _approveRequests(context),
              ),
              _buildControlButton(
                context,
                'System Settings',
                Icons.settings,
                const Color(0xFF9C27B0),
                () => _openSettings(context),
              ),
            ],
          ),

          SizedBox(height: 3.h),

          // Emergency Controls
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF3E0),
              borderRadius: BorderRadius.circular(3.w),
              border: Border.all(
                color: const Color(0xFFFF9800).withValues(alpha: 0.3),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'warning',
                      color: const Color(0xFFFF9800),
                      size: 5.w,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      'Emergency Controls',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFFF9800),
                          ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => _systemMaintenance(context),
                        icon: CustomIconWidget(
                          iconName: 'build',
                          color: Colors.white,
                          size: 4.w,
                        ),
                        label: Text(
                          'Maintenance',
                          style:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF9800),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2.w),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 3.w),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => _userSupport(context),
                        icon: CustomIconWidget(
                          iconName: 'support_agent',
                          color: Colors.white,
                          size: 4.w,
                        ),
                        label: Text(
                          'User Support',
                          style:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2196F3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2.w),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton(
    BuildContext context,
    String title,
    IconData icon,
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
          Icon(icon, size: 6.w),
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

  void _sendNotification(BuildContext context) {
    Fluttertoast.showToast(
      msg: "Sending bulk notification to all users...",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: const Color(0xFF2196F3),
      textColor: Colors.white,
    );
  }

  void _exportReports(BuildContext context) {
    Fluttertoast.showToast(
      msg: "Generating comprehensive reports...",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: const Color(0xFF4CAF50),
      textColor: Colors.white,
    );
  }

  void _approveRequests(BuildContext context) {
    Fluttertoast.showToast(
      msg: "Processing pending approval requests...",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: const Color(0xFFFF9800),
      textColor: Colors.white,
    );
  }

  void _openSettings(BuildContext context) {
    Fluttertoast.showToast(
      msg: "Opening system configuration...",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: const Color(0xFF9C27B0),
      textColor: Colors.white,
    );
  }

  void _systemMaintenance(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'System Maintenance',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          content: const Text(
            'This will put the system in maintenance mode. Are you sure you want to continue?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Fluttertoast.showToast(
                  msg: "System maintenance mode activated",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: const Color(0xFFFF9800),
                  textColor: Colors.white,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF9800),
              ),
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  void _userSupport(BuildContext context) {
    Fluttertoast.showToast(
      msg: "Opening user support dashboard...",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: const Color(0xFF2196F3),
      textColor: Colors.white,
    );
  }
}
