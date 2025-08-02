# 🚀 Fundraise Portal

[![Flutter](https://img.shields.io/badge/Flutter-3.0+-blue.svg)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-3.0+-brightgreen.svg)](https://dart.dev/)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A modern, feature-rich fundraising portal built with Flutter, designed to facilitate seamless donation campaigns, user referrals, and reward systems. This comprehensive mobile application provides both administrative and user-facing functionality for managing fundraising activities.

**Developed by:** [Sree Aditya](https://github.com/SreeAditya-Dev)

## ✨ Features

### 🎯 User Features
- **Modern Authentication System** - Secure login with email and password
- **Interactive Dashboard** - Personalized user dashboard with campaign overview
- **Campaign Management** - Browse, view, and donate to active campaigns
- **QR Code Generation** - Generate QR codes for easy referral sharing
- **Referral System** - Track referrals and earn commissions
- **Rewards Program** - Earn and redeem points for various rewards
- **Profile Management** - Comprehensive user profile with statistics
- **Real-time Analytics** - Track personal donations and earnings

### 👥 Admin Features
- **Admin Dashboard** - Comprehensive analytics and system overview
- **User Management** - Monitor and manage user accounts
- **Campaign Oversight** - Create, monitor, and manage fundraising campaigns
- **Financial Metrics** - Track donations, earnings, and financial reports
- **System Analytics** - Charts and visualizations for key metrics
- **User Activity Monitoring** - Track user engagement and participation

### 🎨 Technical Features
- **Responsive Design** - Optimized for all screen sizes
- **Dark/Light Theme** - Toggle between light and dark modes
- **Smooth Animations** - Beautiful transitions and micro-interactions
- **Offline Support** - Local data caching for better performance
- **Material Design 3** - Modern Google Material Design implementation

## 🔐 Default Credentials

The application comes with pre-configured test accounts for immediate testing:

### Administrator Account
```
Email: admin@fundraise.com
Password: admin123
Role: Administrator
```
**Features:** Full access to admin dashboard, user management, campaign oversight, and system analytics.

### User Accounts
```
Email: demo@fundraise.com
Password: demo123
Role: Regular User
```

```
Email: user2@fundraise.com
Password: user123
Role: Regular User
```

```
Email: user3@fundraise.com
Password: user123
Role: Regular User
```

**Features:** Access to personal dashboard, campaign donations, referral system, and rewards program.

## 🚀 Quick Start

### Prerequisites

Ensure you have the following installed:
- **Flutter SDK** (^3.0.0)
- **Dart SDK** (^3.0.0)
- **Android Studio** or **VS Code** with Flutter extensions
- **Android SDK** for Android development
- **Xcode** for iOS development (macOS only)

### Installation

1. **Clone the repository:**
```bash
git clone https://github.com/SreeAditya-Dev/Fundraise-Portal.git
cd Fundraise-Portal
```

2. **Install dependencies:**
```bash
flutter pub get
```

3. **Run the application:**
```bash
flutter run
```

4. **Build for production:**
```bash
# Android APK
flutter build apk --release

# iOS (macOS only)
flutter build ios --release
```

## 📱 How to Test

1. **Launch the Application**
   - Run the app using `flutter run` or your IDE
   - The app will open to the login screen

2. **Login Process**
   - Use any of the provided credentials above
   - The app automatically redirects based on user role
   - Admin users → Admin Dashboard
   - Regular users → User Dashboard

3. **Explore Features**
   - **Admin Testing:** Login as admin to access analytics, user management, and system controls
   - **User Testing:** Login as any user to test donations, referrals, and rewards
   - **Mock Data:** All features use safe mock data for testing

## 🏗️ Project Structure

```
fundraise_portal/
├── lib/
│   ├── core/                   # Core utilities and constants
│   ├── models/                 # Data models
│   │   ├── user_model.dart
│   │   ├── campaign_model.dart
│   │   ├── referral_model.dart
│   │   └── reward_model.dart
│   ├── services/               # Business logic and data services
│   │   └── app_data_service.dart
│   ├── presentation/           # UI screens and widgets
│   │   ├── login_screen/
│   │   ├── admin_dashboard/
│   │   ├── profile_screen/
│   │   └── announcements_screen/
│   ├── screens/                # Main application screens
│   │   ├── main_dashboard_screen.dart
│   │   ├── admin_dashboard_screen.dart
│   │   ├── user_dashboard_screen.dart
│   │   ├── campaign_details_screen.dart
│   │   ├── referral_screen.dart
│   │   ├── rewards_screen.dart
│   │   └── profile_screen.dart
│   ├── widgets/                # Reusable UI components
│   ├── utils/                  # Utility classes and helpers
│   ├── theme/                  # Theme configuration
│   ├── routes/                 # Application routing
│   └── main.dart              # Application entry point
├── assets/                     # Static assets
│   └── images/
├── android/                    # Android configuration
├── ios/                        # iOS configuration
└── pubspec.yaml               # Dependencies and configuration
```

## 🎯 Key Technologies

- **Frontend:** Flutter & Dart
- **State Management:** Provider Pattern
- **UI/UX:** Material Design 3
- **Charts:** FL Chart for analytics
- **QR Codes:** QR Flutter for generation
- **Animations:** Flutter Animate
- **Fonts:** Google Fonts
- **Responsive Design:** Sizer package

## 📊 Features Breakdown

### User Dashboard
- Personal statistics overview
- Active campaign listings
- Quick action buttons
- Referral code display and sharing
- Recent activity timeline

### Admin Dashboard
- User management interface
- Campaign analytics with charts
- Financial metrics and reports
- System health monitoring
- Real-time statistics

### Campaign System
- Campaign creation and management
- Progress tracking with visual indicators
- Category-based organization
- Contributor tracking
- Target vs. current amount visualization

### Referral Program
- Unique referral code generation
- QR code sharing capabilities
- Commission tracking
- Referral history and analytics
- Social sharing integration

### Rewards System
- Point-based reward system
- Multiple reward categories
- Redemption tracking
- Achievement badges
- Progress indicators

## 🔧 Configuration

The app uses a centralized configuration system:

```dart
// Mock data configuration
class AppDataService {
  // User authentication
  Map<String, String> _userPasswords = {
    'admin@fundraise.com': 'admin123',
    'demo@fundraise.com': 'demo123',
    'user2@fundraise.com': 'user123',
    'user3@fundraise.com': 'user123',
  };
  
  // Campaign settings
  // Referral settings
  // Reward system configuration
}
```

## 📈 Analytics & Metrics

The application tracks comprehensive metrics:

- **User Engagement:** Login frequency, session duration
- **Campaign Performance:** Donation amounts, contributor counts
- **Referral Effectiveness:** Conversion rates, commission earnings
- **Reward Usage:** Point accumulation, redemption patterns
- **System Health:** Active users, campaign success rates

## 🎨 UI/UX Design

- **Material Design 3** implementation
- **Responsive layouts** for all screen sizes
- **Smooth animations** and transitions
- **Intuitive navigation** with bottom navigation
- **Accessibility features** for inclusive design
- **Dark/Light theme** support
- **Custom color schemes** and typography

## 📱 Testing

All features include comprehensive mock data for safe testing:

- **No real transactions** - All donations use mock data
- **Safe user accounts** - Pre-configured test users
- **Complete feature coverage** - Every feature can be tested
- **Realistic data** - Mock data reflects real-world scenarios

## 🤝 Contributing

Contributions are welcome! Please feel free to submit issues, feature requests, or pull requests.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Developer

**Sree Aditya**
- GitHub: [@SreeAditya-Dev](https://github.com/SreeAditya-Dev)
- Email: [Your Email]

## 🙏 Acknowledgments

- Built with ❤️ using [Flutter](https://flutter.dev)
- UI components inspired by Material Design 3
- Charts powered by [FL Chart](https://pub.dev/packages/fl_chart)
- QR code generation by [QR Flutter](https://pub.dev/packages/qr_flutter)
- Animations by [Flutter Animate](https://pub.dev/packages/flutter_animate)

## 📞 Support

For support, email your-email@example.com or create an issue in this repository.

---

**Made with ❤️ by Sree Aditya | Built with Flutter & Dart**
