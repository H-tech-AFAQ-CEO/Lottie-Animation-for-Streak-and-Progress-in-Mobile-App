import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vera App',
      theme: ThemeData(
        primaryColor: Color(0xFF60558A), // Brand purple
        useMaterial3: true,
      ),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  bool showStreakAnimation = false;
  int currentStreak = 5;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _counterAnimation;
  AppBrand currentBrand = AppBrands.vera; // Change this to switch brands

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: const Duration(milliseconds: 3000), // 3 seconds for working animation
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _counterAnimation = Tween<double>(begin: 0, end: currentStreak.toDouble()).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.3, 1.0, curve: Curves.easeOut),
      ),
    );
    
    _controller.reset();
  }

  void triggerStreakAnimation() {
    setState(() {
      showStreakAnimation = true;
      currentStreak++;
    });
    
    _controller.reset();
    _controller.forward().then((_) {
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          showStreakAnimation = false;
        });
      });
    });
  }

  void triggerTestAnimation() {
    setState(() {
      showStreakAnimation = true;
    });
    
    _controller.reset();
    _controller.forward().then((_) {
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          showStreakAnimation = false;
        });
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Vera App', style: TextStyle(fontWeight: FontWeight.w600)),
        backgroundColor: Color(0xFF60558A),
        actions: [
          IconButton(
            icon: Icon(Icons.celebration),
            onPressed: triggerTestAnimation,
            tooltip: 'Test animation',
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // App content based on screenshots
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Guten Tag', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300)),
                      Text('Lena', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                      SizedBox(height: 24),
                      
                      // Streak calendar section
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('1 Tag in Folge "aktiv"', 
                                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                Icon(Icons.calendar_today, color: Color(0xFF60558A)),
                              ],
                            ),
                            SizedBox(height: 16),
                            
                            // Calendar days
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(5, (index) {
                                return Column(
                                  children: [
                                    Text(['Mo', 'Di', 'Mi', 'Do', 'Fr'][index],
                                        style: TextStyle(color: Colors.grey[600])),
                                    SizedBox(height: 4),
                                    Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        color: index < currentStreak - 1 
                                            ? Color(0xFF60558A) 
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                          color: index < currentStreak - 1 
                                              ? Color(0xFF60558A) 
                                              : Colors.grey[300]!,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '${21 + index}',
                                          style: TextStyle(
                                            color: index < currentStreak - 1 
                                                ? Colors.white 
                                                : Colors.grey[600],
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                            ),
                            SizedBox(height: 8),
                            
                            // Today's circle (highlighted)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Text('Sa', style: TextStyle(color: Colors.grey[600])),
                                    SizedBox(height: 4),
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF60558A).withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: Color(0xFF60558A),
                                          width: 2,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '26',
                                          style: TextStyle(
                                            color: Color(0xFF60558A),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      
                      SizedBox(height: 24),
                      
                      // Daily exercise card
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Color(0xFF60558A).withOpacity(0.05),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Color(0xFF60558A).withOpacity(0.2)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Übung des Tages', 
                                 style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                            SizedBox(height: 8),
                            Text('Workout Beine', 
                                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(Icons.timer_outlined, size: 16, color: Colors.grey[600]),
                                SizedBox(width: 4),
                                Text('7 Minuten', style: TextStyle(color: Colors.grey[600])),
                              ],
                            ),
                            SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: triggerStreakAnimation,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF60558A),
                                foregroundColor: Colors.white,
                                minimumSize: Size(double.infinity, 48),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text('Übung abschließen', 
                                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                            ),
                          ],
                        ),
                      ),
                      
                      SizedBox(height: 32),
                      
                      // Other sections from screenshots
                      Text('Übungen', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      SizedBox(height: 16),
                      
                      // Stimmung section
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Stimmung', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            SizedBox(height: 8),
                            Text('Akzeptiere dich selbst', style: TextStyle(fontSize: 16)),
                            SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(Icons.timer_outlined, size: 16, color: Colors.grey[600]),
                                SizedBox(width: 4),
                                Text('15 Minuten', style: TextStyle(color: Colors.grey[600])),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Streak Celebration Animation
          if (showStreakAnimation)
            StreakCelebrationOverlay(
              controller: _controller,
              scaleAnimation: _scaleAnimation,
              fadeAnimation: _fadeAnimation,
              counterAnimation: _counterAnimation,
              streakCount: currentStreak,
              brand: currentBrand,
              onClose: () {
                setState(() {
                  showStreakAnimation = false;
                });
              },
            ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Auswerten',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Entdecken',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Für dich',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Color(0xFF60558A),
        unselectedItemColor: Colors.grey[600],
      ),
    );
  }
}

// Configurable brand colors for multiple apps
class AppBrand {
  final Color primary;
  final Color secondary;
  final Color accent;
  final String name;
  
  const AppBrand({
    required this.primary,
    required this.secondary,
    required this.accent,
    required this.name,
  });
}

// Predefined brand configurations
class AppBrands {
  static const AppBrand vera = AppBrand(
    primary: Color(0xFF60558A),
    secondary: Color(0xFF8B7DB0),
    accent: Color(0xFF60558A),
    name: 'Vera',
  );
  
  static const AppBrand endoPlan = AppBrand(
    primary: Color(0xFF2E7D32),
    secondary: Color(0xFF66BB6A),
    accent: Color(0xFF2E7D32),
    name: 'Endo-Plan',
  );
  
  static const AppBrand symptome = AppBrand(
    primary: Color(0xFF1565C0),
    secondary: Color(0xFF42A5F5),
    accent: Color(0xFF1565C0),
    name: 'Symptome',
  );
}

class StreakCelebrationOverlay extends StatefulWidget {
  final AnimationController controller;
  final Animation<double> scaleAnimation;
  final Animation<double> fadeAnimation;
  final Animation<double> counterAnimation;
  final int streakCount;
  final VoidCallback onClose;
  final AppBrand brand;

  const StreakCelebrationOverlay({
    required this.controller,
    required this.scaleAnimation,
    required this.fadeAnimation,
    required this.counterAnimation,
    required this.streakCount,
    required this.onClose,
    this.brand = AppBrands.vera,
  });

  @override
  _StreakCelebrationOverlayState createState() => _StreakCelebrationOverlayState();
}

class _StreakCelebrationOverlayState extends State<StreakCelebrationOverlay> {
  List<Particle> particles = [];
  Random random = Random();

  @override
  void initState() {
    super.initState();
    // Initialize particles
    for (int i = 0; i < 30; i++) {
      particles.add(Particle(
        x: 140,
        y: 140,
        vx: (random.nextDouble() - 0.5) * 10,
        vy: (random.nextDouble() - 0.5) * 10,
        color: Color(0xFF60558A),
        size: random.nextDouble() * 6 + 4,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onClose,
      child: Container(
        color: Colors.black.withOpacity(0.4),
        child: Center(
          child: AnimatedBuilder(
            animation: widget.controller,
            builder: (context, child) {
              return Opacity(
                opacity: widget.fadeAnimation.value,
                child: Transform.scale(
                  scale: widget.scaleAnimation.value,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Lottie animation background
                      Container(
                        width: 375,
                        height: 300,
                        child: Lottie.asset(
                          'assets/animations/Success.json',
                          controller: widget.controller,
                          onLoaded: (composition) {
                            widget.controller.duration = composition.duration;
                          },
                          delegates: LottieDelegates(
                            values: [
                              ValueDelegate.color(
                                const ['**'], // Target all color properties
                                value: widget.brand.primary,
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      // Streak count overlay with dynamic text
                      Positioned(
                        top: 120,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: AnimatedSwitcher(
                            duration: Duration(milliseconds: 300),
                            transitionBuilder: (child, animation) {
                              return ScaleTransition(
                                scale: animation,
                                child: child,
                              );
                            },
                            child: Text(
                              '${widget.streakCount}',
                              key: ValueKey<int>(widget.streakCount),
                              style: TextStyle(
                                fontSize: 64,
                                fontWeight: FontWeight.bold,
                                color: widget.brand.primary,
                                height: 0.8,
                                fontFamily: 'Barlow',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class Particle {
  double x, y;
  double vx, vy;
  Color color;
  double size;
  double life;

  Particle({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.color,
    required this.size,
    this.life = 1.0,
  });
}

class StreakCelebrationCard extends StatelessWidget {
  final int streakCount;
  final double animationProgress;
  final VoidCallback onClose;

  const StreakCelebrationCard({
    required this.streakCount,
    required this.animationProgress,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 30,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Animated flame icon
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Color(0xFF60558A).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 500),
                width: 60 + 10 * sin(animationProgress * 10),
                height: 60 + 10 * sin(animationProgress * 10),
                child: CustomPaint(
                  painter: FlamePainter(animationProgress),
                ),
              ),
            ],
          ),
          
          SizedBox(height: 24),
          
          // Title with gradient text
          ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [
                Color(0xFF60558A),
                Color(0xFF8B7DB0),
              ],
            ).createShader(bounds),
            child: Text(
              'STREAK GESCHAFFT!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.1,
              ),
            ),
          ),
          
          SizedBox(height: 16),
          
          // Streak count with animated number
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                transitionBuilder: (child, animation) {
                  return ScaleTransition(
                    scale: animation,
                    child: child,
                  );
                },
                child: Text(
                  '${streakCount}',
                  key: ValueKey<int>(streakCount),
                  style: TextStyle(
                    fontSize: 64,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF60558A),
                    height: 0.8,
                  ),
                ),
              ),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tage',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF60558A),
                    ),
                  ),
                  Text(
                    'in Folge aktiv',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          SizedBox(height: 8),
          
          // Progress bar
          Container(
            height: 6,
            width: 200,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(3),
            ),
            child: Stack(
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 1000),
                  width: 200 * (streakCount % 7 / 7),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF60558A),
                        Color(0xFF8B7DB0),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: 16),
          
          // Motivational message
          Text(
            'Du bleibst am Ball! Deine Gesundheit\ndankt es dir. 💜',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              height: 1.4,
            ),
          ),
          
          SizedBox(height: 16),
          
          // Close button
          TextButton(
            onPressed: onClose,
            style: TextButton.styleFrom(
              foregroundColor: Color(0xFF60558A),
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            ),
            child: Text(
              'Weiter',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FlamePainter extends CustomPainter {
  final double animationProgress;

  FlamePainter(this.animationProgress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFF60558A)
      ..style = PaintingStyle.fill;
    
    final paintOutline = Paint()
      ..color = Color(0xFF8B7DB0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    
    // Animated flame shape
    double wave = sin(animationProgress * 20) * 0.1;
    
    Path path = Path();
    path.moveTo(size.width * 0.5, size.height * 0.1);
    path.quadraticBezierTo(
      size.width * 0.8 + wave * 10,
      size.height * 0.3,
      size.width * 0.6,
      size.height * 0.6,
    );
    path.quadraticBezierTo(
      size.width * 0.5,
      size.height * 0.8,
      size.width * 0.4,
      size.height * 0.6,
    );
    path.quadraticBezierTo(
      size.width * 0.2 - wave * 10,
      size.height * 0.3,
      size.width * 0.5,
      size.height * 0.1,
    );
    
    canvas.drawPath(path, paint);
    canvas.drawPath(path, paintOutline);
    
    // Inner flame animation
    if (animationProgress > 0.2) {
      final innerPaint = Paint()
        ..color = Colors.orange.withOpacity(0.3 * animationProgress)
        ..style = PaintingStyle.fill;
      
      Path innerPath = Path();
      innerPath.moveTo(size.width * 0.5, size.height * 0.2);
      innerPath.quadraticBezierTo(
        size.width * 0.7,
        size.height * 0.4,
        size.width * 0.55,
        size.height * 0.55,
      );
      innerPath.quadraticBezierTo(
        size.width * 0.5,
        size.height * 0.65,
        size.width * 0.45,
        size.height * 0.55,
      );
      innerPath.quadraticBezierTo(
        size.width * 0.3,
        size.height * 0.4,
        size.width * 0.5,
        size.height * 0.2,
      );
      
      canvas.drawPath(innerPath, innerPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}