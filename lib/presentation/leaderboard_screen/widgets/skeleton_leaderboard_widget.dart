import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SkeletonLeaderboardWidget extends StatefulWidget {
  const SkeletonLeaderboardWidget({Key? key}) : super(key: key);

  @override
  State<SkeletonLeaderboardWidget> createState() =>
      _SkeletonLeaderboardWidgetState();
}

class _SkeletonLeaderboardWidgetState extends State<SkeletonLeaderboardWidget>
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
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Column(
          children: [
            _buildSkeletonHeader(),
            SizedBox(height: 2.h),
            ...List.generate(5, (index) => _buildSkeletonCard(index + 1)),
          ],
        );
      },
    );
  }

  Widget _buildSkeletonHeader() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      padding: EdgeInsets.all(5.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey.withValues(alpha: 0.2 * _animation.value),
      ),
      child: Column(
        children: [
          Row(
            children: [
              _buildSkeletonCircle(8.w),
              SizedBox(width: 3.w),
              Expanded(child: _buildSkeletonBox(4.h, double.infinity)),
              _buildSkeletonBox(3.h, 15.w),
            ],
          ),
          SizedBox(height: 3.h),
          Row(
            children: [
              Expanded(child: _buildSkeletonStatCard()),
              SizedBox(width: 4.w),
              Expanded(child: _buildSkeletonStatCard()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSkeletonStatCard() {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.15 * _animation.value),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildSkeletonCircle(5.w),
              SizedBox(width: 2.w),
              Expanded(child: _buildSkeletonBox(2.h, double.infinity)),
            ],
          ),
          SizedBox(height: 1.h),
          _buildSkeletonBox(3.h, 20.w),
          SizedBox(height: 0.5.h),
          _buildSkeletonBox(2.h, 15.w),
        ],
      ),
    );
  }

  Widget _buildSkeletonCard(int rank) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey.withValues(alpha: 0.1 * _animation.value),
      ),
      child: Row(
        children: [
          _buildSkeletonCircle(12.w),
          SizedBox(width: 3.w),
          _buildSkeletonCircle(14.w),
          SizedBox(width: 4.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSkeletonBox(2.5.h, 40.w),
                SizedBox(height: 0.5.h),
                _buildSkeletonBox(2.h, 25.w),
                SizedBox(height: 1.h),
                _buildSkeletonBox(1.h, double.infinity),
                SizedBox(height: 0.5.h),
                _buildSkeletonBox(0.8.h, double.infinity),
              ],
            ),
          ),
          SizedBox(width: 2.w),
          _buildSkeletonCircle(8.w),
        ],
      ),
    );
  }

  Widget _buildSkeletonBox(double height, double width) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.3 * _animation.value),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  Widget _buildSkeletonCircle(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey.withValues(alpha: 0.3 * _animation.value),
      ),
    );
  }
}
