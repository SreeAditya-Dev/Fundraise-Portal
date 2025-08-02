import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class DemoFeaturesWidget extends StatelessWidget {
  final List<Map<String, dynamic>> announcements;
  final String referralCode;

  const DemoFeaturesWidget({
    Key? key,
    required this.announcements,
    required this.referralCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Demo Referral Code Card
        Container(
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF2196F3), Color(0xFF42A5F5)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(4.w),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF2196F3).withValues(alpha: 0.3),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  CustomIconWidget(
                    iconName: 'share',
                    color: Colors.white,
                    size: 6.w,
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Text(
                      'Demo Referral Code',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(2.w),
                    ),
                    child: Text(
                      'SAMPLE',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              Container(
                padding: EdgeInsets.all(3.w),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(3.w),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      referralCode,
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                              ),
                    ),
                    GestureDetector(
                      onTap: () => _copyDemoCode(context),
                      child: Container(
                        padding: EdgeInsets.all(2.w),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(2.w),
                        ),
                        child: CustomIconWidget(
                          iconName: 'copy',
                          color: Colors.white,
                          size: 5.w,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.h),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _simulateShare(context, 'social'),
                      icon: CustomIconWidget(
                        iconName: 'share',
                        color: const Color(0xFF2196F3),
                        size: 4.w,
                      ),
                      label: Text(
                        'Share Demo',
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: const Color(0xFF2196F3),
                                ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2.w),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _simulateShare(context, 'whatsapp'),
                      icon: Icon(
                        Icons.message,
                        color: const Color(0xFF25D366),
                        size: 4.w,
                      ),
                      label: Text(
                        'WhatsApp',
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: const Color(0xFF25D366),
                                ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
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

        SizedBox(height: 2.h),

        // Sample Announcements
        Container(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Sample Announcements',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF9800).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(2.w),
                    ),
                    child: Text(
                      'Demo',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: const Color(0xFFFF9800),
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),

              // Announcement Cards
              Column(
                children: announcements.map((announcement) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 2.h),
                    padding: EdgeInsets.all(3.w),
                    decoration: BoxDecoration(
                      color: AppTheme
                          .lightTheme.colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(3.w),
                      border: Border.all(
                        color: AppTheme.lightTheme.colorScheme.outline
                            .withValues(alpha: 0.2),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                announcement['title'],
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ),
                            Text(
                              announcement['timestamp'],
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: AppTheme.lightTheme.colorScheme
                                        .onSurfaceVariant,
                                  ),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          announcement['content'],
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: AppTheme.lightTheme.colorScheme
                                        .onSurfaceVariant,
                                  ),
                        ),
                        SizedBox(height: 1.h),
                        Row(
                          children: [
                            CustomIconWidget(
                              iconName: 'favorite',
                              color: const Color(0xFFF44336),
                              size: 4.w,
                            ),
                            SizedBox(width: 1.w),
                            Text(
                              '24 likes',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: AppTheme.lightTheme.colorScheme
                                        .onSurfaceVariant,
                                  ),
                            ),
                            SizedBox(width: 4.w),
                            CustomIconWidget(
                              iconName: 'comment',
                              color: const Color(0xFF2196F3),
                              size: 4.w,
                            ),
                            SizedBox(width: 1.w),
                            Text(
                              '8 comments',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: AppTheme.lightTheme.colorScheme
                                        .onSurfaceVariant,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _copyDemoCode(BuildContext context) {
    Clipboard.setData(ClipboardData(text: referralCode));
    Fluttertoast.showToast(
      msg: "Demo referral code copied! (This is sample functionality)",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: const Color(0xFF2196F3),
      textColor: Colors.white,
    );
    HapticFeedback.lightImpact();
  }

  void _simulateShare(BuildContext context, String platform) {
    String message = platform == 'whatsapp'
        ? "Demo sharing via WhatsApp simulation"
        : "Demo social media sharing simulation";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              CustomIconWidget(
                iconName: 'share',
                color: const Color(0xFF2196F3),
                size: 6.w,
              ),
              SizedBox(width: 2.w),
              const Text('Demo Share'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(message),
              SizedBox(height: 2.h),
              Container(
                padding: EdgeInsets.all(3.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3E5F5),
                  borderRadius: BorderRadius.circular(3.w),
                ),
                child: Text(
                  'In the real app, this would open your device\'s sharing options or the specific app.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: const Color(0xFF9C27B0),
                      ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Got it!'),
            ),
          ],
        );
      },
    );
  }
}
