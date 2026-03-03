import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/app_assets.dart';
import '../../core/routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  // Gradient panel slides from 0 (full screen) to off-screen top
  late Animation<double> _slideAnim;

  // Logo fades in when panel is mostly gone
  late Animation<double> _logoFadeAnim;

  // Logo scales in slightly
  late Animation<double> _logoScaleAnim;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    );

    // Slide starts after 0.15 interval (brief hold at start)
    _slideAnim = Tween<double>(begin: 0.0, end: -1.25).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.15, 1.0, curve: Curves.easeInOut),
      ),
    );

    // Logo fades in as panel passes center
    _logoFadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.40, 0.70, curve: Curves.easeOut),
      ),
    );

    // Logo scales from 0.85 → 1.0
    _logoScaleAnim = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.40, 0.72, curve: Curves.easeOut),
      ),
    );

    // Start rotation of logo if needed, but here we just follow design
    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) _controller.forward();
    });

    // Navigate to home after full animation + small pause
    Future.delayed(const Duration(milliseconds: 3800), () {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed(AppRoutes.home);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // ─── White background + Logo (always behind the panel) ────────
          Center(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Opacity(
                  opacity: _logoFadeAnim.value,
                  child: Transform.scale(
                    scale: _logoScaleAnim.value,
                    child: child,
                  ),
                );
              },
              child: _buildLogo(),
            ),
          ),

          // ─── Gradient panel (slides upward) ───────────────────────────
          AnimatedBuilder(
            animation: _slideAnim,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, _slideAnim.value * screenHeight),
                child: child,
              );
            },
            child: SizedBox(
              width: double.infinity,
              height: screenHeight * 1.15,
              child: ClipPath(
                clipper: _BottomWaveClipper(),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF13C2C2), Color(0xFF5E29CD)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: _buildGradientDecoration(screenHeight),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Palm-tree decoration shown on the gradient panel
  Widget _buildGradientDecoration(double screenHeight) {
    return Stack(
      children: [
        Positioned(
          bottom: 20.h,
          left: 0,
          right: 0,
          child: Opacity(
            opacity: 0.3,
            child: Image.asset(
              AppAssets.palmTrees,
              fit: BoxFit.contain,
              height: 220.h,
            ),
          ),
        ),
      ],
    );
  }

  /// Actual Logo Revealed
  Widget _buildLogo() {
    return Image.asset(
      AppAssets.logo,
      width: 180.w, // Reduced size
      fit: BoxFit.contain,
    );
  }
}

class _BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 70);
    path.quadraticBezierTo(
      size.width / 2,
      size.height + 55,
      size.width,
      size.height - 70,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
