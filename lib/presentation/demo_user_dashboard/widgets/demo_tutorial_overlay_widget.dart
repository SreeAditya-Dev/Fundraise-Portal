import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';

class DemoTutorialOverlayWidget extends StatefulWidget {
  final VoidCallback onDismiss;

  const DemoTutorialOverlayWidget({
    Key? key,
    required this.onDismiss,
  }) : super(key: key);

  @override
  State<DemoTutorialOverlayWidget> createState() =>
      _DemoTutorialOverlayWidgetState();
}

class _DemoTutorialOverlayWidgetState extends State<DemoTutorialOverlayWidget>
    with TickerProviderStateMixin {
  int _currentStep = 0;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  final List<Map<String, dynamic>> _tutorialSteps = [
    {
      "title": "Welcome to Demo Mode!",
      "description":
          "This demo showcases all platform features with sample data. Explore freely!",
      "position": Offset(50.w, 20.h),
    },
    {
      "title": "Sample Statistics",
      "description":
          "These impressive numbers demonstrate what users can achieve on our platform.",
      "position": Offset(50.w, 35.h),
    },
    {
      "title": "Interactive Features",
      "description":
          "Click buttons and explore - all interactions show realistic functionality.",
      "position": Offset(50.w, 50.h),
    },
    {
      "title": "Navigation Demo",
      "description":
          "Use the bottom navigation to see different demo sections.",
      "position": Offset(50.w, 85.h),
    },
  ];

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withValues(alpha: 0.7),
      child: Stack(
        children: [
          GestureDetector(
            onTap: _nextStep,
            child: Container(
              width: double.infinity,
              height: double.infinity,
            ),
          ),

          // Tutorial Card
          Positioned(
            left: _tutorialSteps[_currentStep]['position'].dx - 40.w,
            top: _tutorialSteps[_currentStep]['position'].dy,
            child: AnimatedBuilder(
              animation: _pulseAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _pulseAnimation.value,
                  child: Container(
                    width: 80.w,
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4.w),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(2.w),
                              decoration: BoxDecoration(
                                color: const Color(0xFF2196F3)
                                    .withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(2.w),
                              ),
                              child: CustomIconWidget(
                                iconName: 'help_outline',
                                color: const Color(0xFF2196F3),
                                size: 6.w,
                              ),
                            ),
                            SizedBox(width: 3.w),
                            Expanded(
                              child: Text(
                                _tutorialSteps[_currentStep]['title'],
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF2196F3),
                                    ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          _tutorialSteps[_currentStep]['description'],
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.black87,
                                  ),
                        ),
                        SizedBox(height: 3.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${_currentStep + 1} of ${_tutorialSteps.length}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: Colors.grey[600],
                                  ),
                            ),
                            Row(
                              children: [
                                if (_currentStep > 0)
                                  TextButton(
                                    onPressed: _previousStep,
                                    child: Text(
                                      'Previous',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ),
                                SizedBox(width: 2.w),
                                ElevatedButton(
                                  onPressed:
                                      _currentStep < _tutorialSteps.length - 1
                                          ? _nextStep
                                          : widget.onDismiss,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF2196F3),
                                  ),
                                  child: Text(
                                    _currentStep < _tutorialSteps.length - 1
                                        ? 'Next'
                                        : 'Got it!',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Skip Button
          Positioned(
            top: 5.h,
            right: 4.w,
            child: TextButton(
              onPressed: widget.onDismiss,
              style: TextButton.styleFrom(
                backgroundColor: Colors.white.withValues(alpha: 0.9),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3.w),
                ),
              ),
              child: Text(
                'Skip Tour',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: const Color(0xFF2196F3),
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _nextStep() {
    if (_currentStep < _tutorialSteps.length - 1) {
      setState(() {
        _currentStep++;
      });
    } else {
      widget.onDismiss();
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }
}
