import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _fadeController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late ConfettiController _confettiController;

  bool _isLoading = true;
  double _loadingProgress = 0.0;
  String _loadingText = 'Initializing...';

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startSplashSequence();
  }

  void _initializeAnimations() {
    // Logo scale animation controller
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Fade animation controller
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Scale animation for logo
    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.elasticOut,
    ));

    // Fade animation for loading elements
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    // Confetti controller for celebration
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 2),
    );
  }

  Future<void> _startSplashSequence() async {
    // Hide system status bar for full-screen experience
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    // Start logo animation
    _logoController.forward();

    // Wait for logo animation to complete
    await Future.delayed(const Duration(milliseconds: 500));

    // Start fade animation for loading elements
    _fadeController.forward();

    // Simulate app initialization with realistic loading steps
    await _performInitializationTasks();

    // Show confetti celebration
    _confettiController.play();

    // Wait for confetti to finish
    await Future.delayed(const Duration(milliseconds: 2000));

    // Navigate to appropriate screen
    await _navigateToNextScreen();
  }

  Future<void> _performInitializationTasks() async {
    final List<Map<String, dynamic>> initTasks = [
      {'text': 'Loading user preferences...', 'duration': 400},
      {'text': 'Checking authentication...', 'duration': 600},
      {'text': 'Preparing donation data...', 'duration': 500},
      {'text': 'Setting up celebrations...', 'duration': 300},
      {'text': 'Almost ready...', 'duration': 200},
    ];

    for (int i = 0; i < initTasks.length; i++) {
      if (mounted) {
        setState(() {
          _loadingText = initTasks[i]['text'] as String;
          _loadingProgress = (i + 1) / initTasks.length;
        });
      }

      await Future.delayed(
        Duration(milliseconds: initTasks[i]['duration'] as int),
      );
    }

    if (mounted) {
      setState(() {
        _isLoading = false;
        _loadingText = 'Welcome to FundRaise Portal!';
      });
    }
  }

  Future<void> _navigateToNextScreen() async {
    // Restore system UI
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    if (!mounted) return;

    // Check authentication status (mock implementation)
    final bool isAuthenticated = await _checkAuthenticationStatus();

    // Navigate based on authentication status
    if (isAuthenticated) {
      Navigator.pushReplacementNamed(context, '/dashboard');
    } else {
      Navigator.pushReplacementNamed(context, '/login-screen');
    }
  }

  Future<bool> _checkAuthenticationStatus() async {
    // Mock authentication check - in real app, check stored tokens/preferences
    await Future.delayed(const Duration(milliseconds: 100));
    return false; // Always navigate to login for demo purposes
  }

  @override
  void dispose() {
    _logoController.dispose();
    _fadeController.dispose();
    _confettiController.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppTheme.lightTheme.colorScheme.primary,
              AppTheme.lightTheme.colorScheme.primaryContainer,
              AppTheme.lightTheme.colorScheme.secondary.withValues(alpha: 0.8),
            ],
            stops: const [0.0, 0.6, 1.0],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Confetti overlay
              Align(
                alignment: Alignment.topCenter,
                child: ConfettiWidget(
                  confettiController: _confettiController,
                  blastDirection: 1.57, // radians - 90 degrees
                  particleDrag: 0.05,
                  emissionFrequency: 0.05,
                  numberOfParticles: 50,
                  gravity: 0.05,
                  shouldLoop: false,
                  colors: [
                    AppTheme.lightTheme.colorScheme.secondary,
                    AppTheme.lightTheme.colorScheme.tertiary,
                    Colors.white,
                    AppTheme.lightTheme.colorScheme.primaryContainer,
                  ],
                ),
              ),

              // Main content
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo section
                  Expanded(
                    flex: 3,
                    child: Center(
                      child: AnimatedBuilder(
                        animation: _scaleAnimation,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _scaleAnimation.value,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // App logo with Lottie animation
                                Container(
                                  width: 35.w,
                                  height: 35.w,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Colors.black.withValues(alpha: 0.1),
                                        blurRadius: 20,
                                        offset: const Offset(0, 10),
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Stack(
                                      children: [
                                        // Background gradient
                                        Container(
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [
                                                Colors.white,
                                                Colors.white
                                                    .withValues(alpha: 0.9),
                                              ],
                                            ),
                                          ),
                                        ),
                                        // Logo icon
                                        Center(
                                          child: CustomIconWidget(
                                            iconName: 'volunteer_activism',
                                            size: 15.w,
                                            color: AppTheme
                                                .lightTheme.colorScheme.primary,
                                          ),
                                        ),
                                        // Animated overlay
                                        if (_scaleAnimation.value > 0.8)
                                          Positioned.fill(
                                            child: Lottie.asset(
                                              'assets/animations/sparkle.json',
                                              fit: BoxFit.cover,
                                              repeat: true,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return Container(); // Fallback if animation fails
                                              },
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),

                                SizedBox(height: 4.h),

                                // App name
                                Text(
                                  'FundRaise Portal',
                                  style: AppTheme
                                      .lightTheme.textTheme.headlineMedium
                                      ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2,
                                    shadows: [
                                      Shadow(
                                        color:
                                            Colors.black.withValues(alpha: 0.3),
                                        offset: const Offset(0, 2),
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(height: 1.h),

                                // Tagline
                                Text(
                                  'Empowering Change Together',
                                  style: AppTheme.lightTheme.textTheme.bodyLarge
                                      ?.copyWith(
                                    color: Colors.white.withValues(alpha: 0.9),
                                    fontWeight: FontWeight.w300,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  // Loading section
                  Expanded(
                    flex: 1,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Loading progress indicator
                          Container(
                            width: 60.w,
                            height: 6,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(3),
                              child: LinearProgressIndicator(
                                value: _loadingProgress,
                                backgroundColor: Colors.transparent,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 3.h),

                          // Loading text
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: Text(
                              _loadingText,
                              key: ValueKey(_loadingText),
                              style: AppTheme.lightTheme.textTheme.bodyMedium
                                  ?.copyWith(
                                color: Colors.white.withValues(alpha: 0.8),
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),

                          SizedBox(height: 2.h),

                          // Loading dots animation
                          if (_isLoading)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(3, (index) {
                                return AnimatedContainer(
                                  duration: Duration(
                                      milliseconds: 600 + (index * 200)),
                                  curve: Curves.easeInOut,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(
                                      alpha: (_loadingProgress * 10)
                                                  .remainder(3) ==
                                              index
                                          ? 1.0
                                          : 0.4,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                );
                              }),
                            ),
                        ],
                      ),
                    ),
                  ),

                  // Bottom spacing
                  SizedBox(height: 5.h),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
