# Lottie Streak Celebration Animation

## Overview
Enhanced Lottie-based streak celebration animation for German healthcare apps, designed to provide emotional, rewarding, and playful user feedback while maintaining a trustworthy medical tone.

## Features
- **Configurable Brand Colors**: Easy color customization for multiple apps
- **Barlow Typography**: Professional medical-appropriate font family
- **Smooth Animations**: 120-frame celebration sequence with particle effects
- **Dynamic Text**: Streak count updates automatically
- **Healthcare-Appropriate**: Maintains professional tone while being engaging

## Files Structure
```
assets/
├── animations/
│   ├── streak_celebration.json          # Original animation
│   └── streak_celebration_enhanced.json  # Enhanced version (recommended)
└── fonts/
    ├── Barlow-Regular.ttf
    ├── Barlow-Medium.ttf
    ├── Barlow-SemiBold.ttf
    └── Barlow-Bold.ttf
```

## Brand Configuration

### Predefined Brands
```dart
// Vera App (Purple theme)
AppBrands.vera  // Primary: #60558A, Secondary: #8B7DB0

// Endo-Plan App (Green theme)  
AppBrands.endoPlan  // Primary: #2E7D32, Secondary: #66BB6A

// Symptome App (Blue theme)
AppBrands.symptome  // Primary: #1565C0, Secondary: #42A5F5
```

### Custom Brand
```dart
const AppBrand customApp = AppBrand(
  primary: Color(0xFFYOUR_COLOR),
  secondary: Color(0xFFYOUR_SECONDARY),
  accent: Color(0xFFYOUR_ACCENT),
  name: 'YourAppName',
);
```

## Usage

### Basic Implementation
```dart
class YourWidget extends StatefulWidget {
  @override
  _YourWidgetState createState() => _YourWidgetState();
}

class _YourWidgetState extends State<YourWidget> with TickerProviderStateMixin {
  late AnimationController _controller;
  AppBrand currentBrand = AppBrands.vera; // Choose your brand
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    );
  }
  
  void showStreakCelebration(int streakCount) {
    StreakCelebrationOverlay(
      controller: _controller,
      scaleAnimation: _scaleAnimation,
      fadeAnimation: _fadeAnimation,
      counterAnimation: _counterAnimation,
      streakCount: streakCount,
      brand: currentBrand,
      onClose: () => Navigator.of(context).pop(),
    ).show(context);
    
    _controller.forward();
  }
}
```

### Integration with Existing Code
Replace your current streak celebration with:
```dart
if (showStreakAnimation)
  StreakCelebrationOverlay(
    controller: _controller,
    scaleAnimation: _scaleAnimation,
    fadeAnimation: _fadeAnimation,
    counterAnimation: _counterAnimation,
    streakCount: currentStreak,
    brand: currentBrand, // Add this line
    onClose: () {
      setState(() {
        showStreakAnimation = false;
      });
    },
  ),
```

## Animation Timeline
- **0-15 frames**: Background glow fades in, icon scales up
- **15-30 frames**: Icon rotation and particle effects start
- **25-40 frames**: Streak number animates in
- **35-50 frames**: "TAGE" text appears
- **45-60 frames**: Subtitle text fades in
- **60-90 frames**: Full celebration display
- **90-120 frames**: Smooth fade out

## Color Customization
The animation uses Lottie delegates for dynamic color replacement:

```dart
Lottie.asset(
  'assets/animations/streak_celebration_enhanced.json',
  delegates: LottieDelegates(
    values: [
      ValueDelegate.color(
        const ['**'], // Target all color properties
        value: yourBrand.primary,
      ),
    ],
  ),
)
```

## Performance Notes
- **File Size**: ~5KB (optimized for mobile)
- **Frame Rate**: 30 FPS (smooth but battery-efficient)
- **Memory**: Low impact with proper controller disposal
- **Compatibility**: iOS 9+, Android API 16+

## Font Requirements
Ensure Barlow font files are placed in `assets/fonts/`:
- Barlow-Regular.ttf
- Barlow-Medium.ttf  
- Barlow-SemiBold.ttf
- Barlow-Bold.ttf

## Testing
```dart
// Test different streak counts
showStreakCelebration(1);   // First streak
showStreakCelebration(7);   // Week milestone
showStreakCelebration(30);  // Month milestone

// Test different brands
currentBrand = AppBrands.vera;
currentBrand = AppBrands.endoPlan;
currentBrand = AppBrands.symptome;
```

## Troubleshooting

### Animation Not Showing
1. Verify Lottie dependency in pubspec.yaml
2. Check animation file path in assets
3. Ensure controller is properly initialized

### Colors Not Applying
1. Check Lottie delegate configuration
2. Verify color property paths in JSON
3. Test with hardcoded colors first

### Font Not Loading
1. Confirm font files exist in assets/fonts/
2. Check pubspec.yaml font configuration
3. Run `flutter clean` and rebuild

## Future Enhancements
- Milestone-specific animations (7, 30, 100 days)
- Sound effects integration
- Haptic feedback
- Personalized messages based on streak length
- A/B testing different animation styles

## Support
For long-term animation support and custom healthcare app animations, contact the development team for partnership opportunities.
