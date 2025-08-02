import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DemoWatermarkWidget extends StatelessWidget {
  const DemoWatermarkWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 2.h,
      right: 4.w,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(2.w),
          border: Border.all(
            color: const Color(0xFF4CAF50).withValues(alpha: 0.3),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.visibility,
              color: const Color(0xFF4CAF50),
              size: 4.w,
            ),
            SizedBox(width: 1.w),
            Text(
              'DEMO',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: const Color(0xFF4CAF50),
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
