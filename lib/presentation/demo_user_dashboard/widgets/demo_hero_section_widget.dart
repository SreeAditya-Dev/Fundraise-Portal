import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';

class DemoHeroSectionWidget extends StatefulWidget {
  final Map<String, dynamic> userData;
  final VoidCallback onCelebration;

  const DemoHeroSectionWidget({
    Key? key,
    required this.userData,
    required this.onCelebration,
  }) : super(key: key);

  @override
  State<DemoHeroSectionWidget> createState() => _DemoHeroSectionWidgetState();
}

class _DemoHeroSectionWidgetState extends State<DemoHeroSectionWidget>
    with TickerProviderStateMixin {
  late AnimationController _counterController;
  late Animation<double> _counterAnimation;

  @override
  void initState() {
    super.initState();
    _counterController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _counterAnimation = Tween<double>(
      begin: 0,
      end: widget.userData['totalDonations'].toDouble(),
    ).animate(CurvedAnimation(
      parent: _counterController,
      curve: Curves.easeOutCubic,
    ));

    // Start counter animation
    Future.delayed(const Duration(milliseconds: 500), () {
      _counterController.forward();
    });
  }

  @override
  void dispose() {
    _counterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      padding: EdgeInsets.all(6.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4CAF50), Color(0xFF66BB6A), Color(0xFF81C784)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(6.w),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4CAF50).withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // Demo Badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(4.w),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomIconWidget(
                  iconName: 'science',
                  color: Colors.white,
                  size: 5.w,
                ),
                SizedBox(width: 2.w),
                Text(
                  'DEMO MODE - Sample Data',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),

          SizedBox(height: 3.h),

          // Impressive Statistics
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatCard(
                context,
                'Raised',
                AnimatedBuilder(
                  animation: _counterAnimation,
                  builder: (context, child) {
                    return Text(
                      '₹${_counterAnimation.value.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                    );
                  },
                ),
                Icons.account_balance_wallet,
              ),
              Container(
                width: 1,
                height: 8.h,
                color: Colors.white.withValues(alpha: 0.3),
              ),
              _buildStatCard(
                context,
                'Referrals',
                Text(
                  '${widget.userData['referrals']}',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Icons.people,
              ),
              Container(
                width: 1,
                height: 8.h,
                color: Colors.white.withValues(alpha: 0.3),
              ),
              _buildStatCard(
                context,
                'Tier',
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomIconWidget(
                      iconName: 'emoji_events',
                      color: const Color(0xFFFFD700),
                      size: 8.w,
                    ),
                    SizedBox(width: 1.w),
                    Text(
                      widget.userData['tier'],
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                Icons.star,
              ),
            ],
          ),

          SizedBox(height: 3.h),

          // Progress Bar
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Progress to Goal',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  Text(
                    '85%',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              SizedBox(height: 1.h),
              LinearProgressIndicator(
                value: 0.85,
                backgroundColor: Colors.white.withValues(alpha: 0.3),
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                minHeight: 1.h,
              ),
              SizedBox(height: 1.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '₹85,000 raised',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withValues(alpha: 0.9),
                        ),
                  ),
                  Text(
                    'Goal: ₹1,00,000',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withValues(alpha: 0.9),
                        ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 3.h),

          // Celebration Button
          ElevatedButton.icon(
            onPressed: () {
              widget.onCelebration();
            },
            icon: CustomIconWidget(
              iconName: 'celebration',
              color: const Color(0xFF4CAF50),
              size: 5.w,
            ),
            label: Text(
              'Celebrate Milestone!',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: const Color(0xFF4CAF50),
                    fontWeight: FontWeight.bold,
                  ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3.w),
              ),
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.5.h),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String label,
    Widget value,
    IconData icon,
  ) {
    return Column(
      children: [
        Icon(icon, color: Colors.white.withValues(alpha: 0.8), size: 6.w),
        SizedBox(height: 1.h),
        value,
        SizedBox(height: 0.5.h),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.white.withValues(alpha: 0.8),
              ),
        ),
      ],
    );
  }
}
