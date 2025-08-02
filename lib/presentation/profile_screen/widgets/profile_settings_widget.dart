import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ProfileSettingsWidget extends StatelessWidget {
  final String userRole;
  final Color roleColor;

  const ProfileSettingsWidget({
    Key? key,
    required this.userRole,
    required this.roleColor,
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
            'Settings & Preferences',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 2.h),

          // Settings List
          Column(
            children: _getSettingsItems(context),
          ),
        ],
      ),
    );
  }

  List<Widget> _getSettingsItems(BuildContext context) {
    List<Map<String, dynamic>> commonSettings = [
      {
        'title': 'Notifications',
        'subtitle': 'Manage your notification preferences',
        'icon': 'notifications',
        'action': () => _showNotificationSettings(context),
      },
      {
        'title': 'Privacy & Security',
        'subtitle': 'Control your privacy settings',
        'icon': 'security',
        'action': () => _showPrivacySettings(context),
      },
      {
        'title': 'Language',
        'subtitle': 'Choose your preferred language',
        'icon': 'language',
        'action': () => _showLanguageSettings(context),
      },
    ];

    List<Map<String, dynamic>> roleSpecificSettings = [];

    switch (userRole) {
      case 'admin':
        roleSpecificSettings = [
          {
            'title': 'Admin Tools',
            'subtitle': 'Access administrative controls',
            'icon': 'admin_panel_settings',
            'action': () => _showAdminTools(context),
            'isRoleSpecific': true,
          },
          {
            'title': 'System Configuration',
            'subtitle': 'Configure system settings',
            'icon': 'settings',
            'action': () => _showSystemConfig(context),
            'isRoleSpecific': true,
          },
          {
            'title': 'User Management',
            'subtitle': 'Manage user accounts and permissions',
            'icon': 'people',
            'action': () => _showUserManagement(context),
            'isRoleSpecific': true,
          },
        ];
        break;
      case 'demo':
        roleSpecificSettings = [
          {
            'title': 'Demo Features',
            'subtitle': 'Explore available demo features',
            'icon': 'science',
            'action': () => _showDemoFeatures(context),
            'isRoleSpecific': true,
          },
          {
            'title': 'Tutorial Guide',
            'subtitle': 'Restart the interactive tutorial',
            'icon': 'help_outline',
            'action': () => _showTutorialGuide(context),
            'isRoleSpecific': true,
          },
          {
            'title': 'Create Real Account',
            'subtitle': 'Sign up for full platform access',
            'icon': 'person_add',
            'action': () => _showSignUpPrompt(context),
            'isRoleSpecific': true,
          },
        ];
        break;
      default:
        roleSpecificSettings = [
          {
            'title': 'Referral Settings',
            'subtitle': 'Manage your referral preferences',
            'icon': 'share',
            'action': () => _showReferralSettings(context),
            'isRoleSpecific': true,
          },
          {
            'title': 'Payment Methods',
            'subtitle': 'Manage your payment information',
            'icon': 'payment',
            'action': () => _showPaymentSettings(context),
            'isRoleSpecific': true,
          },
        ];
    }

    List<Widget> settingsWidgets = [];

    // Add role-specific settings first if any
    if (roleSpecificSettings.isNotEmpty) {
      for (var setting in roleSpecificSettings) {
        settingsWidgets.add(_buildSettingItem(context, setting));
      }
      settingsWidgets.add(Divider(
        color: AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.2),
        height: 3.h,
      ));
    }

    // Add common settings
    for (var setting in commonSettings) {
      settingsWidgets.add(_buildSettingItem(context, setting));
    }

    return settingsWidgets;
  }

  Widget _buildSettingItem(BuildContext context, Map<String, dynamic> setting) {
    final isRoleSpecific = setting['isRoleSpecific'] as bool? ?? false;

    return Container(
      margin: EdgeInsets.only(bottom: 1.h),
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(2.w),
          decoration: BoxDecoration(
            color: (isRoleSpecific
                    ? roleColor
                    : AppTheme.lightTheme.colorScheme.primary)
                .withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(2.w),
          ),
          child: CustomIconWidget(
            iconName: setting['icon'],
            color: isRoleSpecific
                ? roleColor
                : AppTheme.lightTheme.colorScheme.primary,
            size: 5.w,
          ),
        ),
        title: Text(
          setting['title'],
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: isRoleSpecific ? roleColor : null,
              ),
        ),
        subtitle: Text(
          setting['subtitle'],
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              ),
        ),
        trailing: CustomIconWidget(
          iconName: 'arrow_forward_ios',
          color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
          size: 4.w,
        ),
        onTap: setting['action'],
        contentPadding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2.w),
        ),
      ),
    );
  }

  // Setting actions
  void _showNotificationSettings(BuildContext context) {
    _showSettingModal(context, 'Notifications',
        'Configure your notification preferences here.');
  }

  void _showPrivacySettings(BuildContext context) {
    _showSettingModal(context, 'Privacy & Security',
        'Manage your privacy and security settings.');
  }

  void _showLanguageSettings(BuildContext context) {
    _showSettingModal(context, 'Language', 'Select your preferred language.');
  }

  void _showAdminTools(BuildContext context) {
    _showSettingModal(context, 'Admin Tools',
        'Access to administrative controls and system management tools.');
  }

  void _showSystemConfig(BuildContext context) {
    _showSettingModal(context, 'System Configuration',
        'Configure system-wide settings and parameters.');
  }

  void _showUserManagement(BuildContext context) {
    _showSettingModal(context, 'User Management',
        'Manage user accounts, roles, and permissions.');
  }

  void _showDemoFeatures(BuildContext context) {
    _showSettingModal(context, 'Demo Features',
        'Explore all available demo features and sample data.');
  }

  void _showTutorialGuide(BuildContext context) {
    _showSettingModal(context, 'Tutorial Guide',
        'Restart the interactive tutorial to explore features again.');
  }

  void _showSignUpPrompt(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Create Real Account'),
          content: const Text(
            'Ready to start your real fundraising journey? Create your account to access all features with real data and functionality.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Continue Demo'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/sign-up-screen');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: roleColor,
              ),
              child: const Text('Sign Up Now',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _showReferralSettings(BuildContext context) {
    _showSettingModal(context, 'Referral Settings',
        'Manage your referral code and sharing preferences.');
  }

  void _showPaymentSettings(BuildContext context) {
    _showSettingModal(context, 'Payment Methods',
        'Add or modify your payment methods and billing information.');
  }

  void _showSettingModal(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Fluttertoast.showToast(
                  msg: "$title settings opened",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: roleColor,
                  textColor: Colors.white,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: roleColor,
              ),
              child: const Text('Configure',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}
