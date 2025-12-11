import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';
import 'package:gauva_userapp/core/utils/exit_app_dialogue.dart';
import 'package:gauva_userapp/data/services/local_storage_service.dart';
import 'package:gauva_userapp/presentation/account_page/provider/country_list_provider.dart';
import 'package:gauva_userapp/presentation/booking/provider/order_providers.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  VideoPlayerController? _videoController;
  bool _isVideoInitialized = false;
  bool _hasNavigated = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(countryListProvider.notifier).getCountryList());
    _checkToken(); // Check token every time splash screen loads
    _initializeVideo();
  }

  /// Check and validate token on splash screen
  Future<void> _checkToken() async {
    try {
      debugPrint('🔑 SPLASH - Checking token...');
      final token = await LocalStorageService().getToken();
      final refreshToken = await LocalStorageService().getRefreshToken();

      if (token != null && token.isNotEmpty) {
        debugPrint('✅ SPLASH - Token found (${token.length} chars)');
        debugPrint('   - Token preview: ${token.length > 20 ? token.substring(0, 20) + "..." : token}');

        // Check if refresh token exists
        if (refreshToken != null && refreshToken.isNotEmpty) {
          debugPrint('✅ SPLASH - Refresh token found (${refreshToken.length} chars)');
        } else {
          debugPrint('⚠️ SPLASH - No refresh token found');
        }

        // TODO: Add token expiry validation if needed
        // You can decode JWT and check expiry: exp claim
      } else {
        debugPrint('⚠️ SPLASH - No token found in storage');
        debugPrint('   - User will be redirected to login');
      }
    } catch (e, stackTrace) {
      debugPrint('❌ SPLASH - Error checking token: $e');
      debugPrint('❌ Stack trace: $stackTrace');
    }
  }

  Future<void> _initializeVideo() async {
    try {
      _videoController = VideoPlayerController.asset('assets/gauva.mp4');
      await _videoController!.initialize();

      if (mounted) {
        setState(() {
          _isVideoInitialized = true;
        });

        // Set looping to false
        _videoController!.setLooping(false);

        // Listen for video completion
        _videoController!.addListener(_videoListener);

        // Play video
        await _videoController!.play();

        // Also set a timeout as backup (11 seconds + buffer)
        Future.delayed(const Duration(seconds: 12), () {
          if (mounted && !_hasNavigated) {
            _hasNavigated = true;
            _videoController?.removeListener(_videoListener);
            ref.read(tripActivityNotifierProvider.notifier).checkTripActivity();
          }
        });
      }
    } catch (e) {
      debugPrint('Error initializing video: $e');
      // If video fails, proceed with normal flow
      if (mounted) {
        Future.microtask(() {
          ref.read(tripActivityNotifierProvider.notifier).checkTripActivity();
        });
      }
    }
  }

  void _videoListener() {
    if (_videoController != null &&
        _videoController!.value.isInitialized &&
        _videoController!.value.position >= _videoController!.value.duration &&
        _videoController!.value.duration > Duration.zero &&
        !_hasNavigated) {
      _hasNavigated = true;
      _videoController!.removeListener(_videoListener);

      // Video completed, check trip activity
      if (mounted) {
        Future.microtask(() {
          ref.read(tripActivityNotifierProvider.notifier).checkTripActivity();
        });
      }
    }
  }

  @override
  void dispose() {
    _videoController?.removeListener(_videoListener);
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ExitAppWrapper(
    child: Scaffold(
      backgroundColor: Colors.black,
      body: ref
          .watch(tripActivityNotifierProvider)
          .when(initial: () => _body(), loading: () => _body(), success: (d) => _body(), error: (e) => _body()),
    ),
  );

  Widget _body() {
    if (_isVideoInitialized && _videoController != null) {
      return SizedBox.expand(
        child: FittedBox(
          fit: BoxFit.cover,
          alignment: Alignment.center,
          child: SizedBox(
            width: _videoController!.value.size.width,
            height: _videoController!.value.size.height,
            child: VideoPlayer(_videoController!),
          ),
        ),
      );
    } else {
      // Show black screen while video is loading
      return Container(color: Colors.black);
    }
  }

  // // ANIMATED SPLASH SCREEN CODE (COMMENTED OUT)
  // class _SplashPageState extends ConsumerState<SplashPage> with TickerProviderStateMixin {
  //   bool _hasNavigated = false;
  //   late AnimationController _gradientController;
  //   late AnimationController _letterController;
  //   late Animation<double> _gradientAnimation;
  //   final String _text = 'Guava';
  //   int _visibleLetters = 0;

  //   @override
  //   void initState() {
  //     super.initState();
  //     Future.microtask(() => ref.read(countryListProvider.notifier).getCountryList());

  //     // Initialize gradient animation
  //     _gradientController = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this)
  //       ..repeat(reverse: true);

  //     _gradientAnimation = Tween<double>(
  //       begin: 0.0,
  //       end: 1.0,
  //     ).animate(CurvedAnimation(parent: _gradientController, curve: Curves.easeInOut));

  //     // Initialize letter animation controller
  //     _letterController = AnimationController(
  //       duration: Duration(milliseconds: _text.length * 200 + 500), // 200ms per letter + 500ms buffer
  //       vsync: this,
  //     );

  //     // Animate letters one by one
  //     _letterController.addListener(() {
  //       final newVisibleLetters = (_letterController.value * _text.length).floor();
  //       if (newVisibleLetters != _visibleLetters && mounted) {
  //         setState(() {
  //           _visibleLetters = newVisibleLetters.clamp(0, _text.length);
  //         });
  //       }
  //     });

  //     // Start letter animation
  //     _letterController.forward();

  //     // Navigate after all animations complete
  //     Future.delayed(const Duration(milliseconds: 2500), () {
  //       if (mounted && !_hasNavigated) {
  //         _hasNavigated = true;
  //         ref.read(tripActivityNotifierProvider.notifier).checkTripActivity();
  //       }
  //     });
  //   }

  //   @override
  //   void dispose() {
  //     _gradientController.dispose();
  //     _letterController.dispose();
  //     super.dispose();
  //   }

  //   Widget _body() {
  //     return AnimatedBuilder(
  //       animation: _gradientAnimation,
  //       builder: (context, child) {
  //         return Container(
  //           decoration: BoxDecoration(
  //             gradient: LinearGradient(
  //               begin: Alignment.topLeft,
  //               end: Alignment.bottomRight,
  //               colors: [
  //                 Color.lerp(const Color(0xFF397098), const Color(0xFF1469B5), _gradientAnimation.value)!,
  //                 Color.lerp(const Color(0xFF942FAF), const Color(0xFFB84DD1), _gradientAnimation.value)!,
  //               ],
  //             ),
  //           ),
  //           child: Center(
  //             child: ShaderMask(
  //               shaderCallback: (bounds) => LinearGradient(
  //                 begin: Alignment.topLeft,
  //                 end: Alignment.bottomRight,
  //                 colors: [Colors.white, Colors.white.withOpacity(0.9)],
  //               ).createShader(bounds),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: List.generate(_text.length, (index) {
  //                   final letter = _text[index];
  //                   final isVisible = index < _visibleLetters;
  //                   return TweenAnimationBuilder<double>(
  //                     tween: Tween(begin: 0.0, end: isVisible ? 1.0 : 0.0),
  //                     duration: const Duration(milliseconds: 600),
  //                     curve: Curves.elasticOut,
  //                     builder: (context, value, child) {
  //                       final clampedValue = value.clamp(0.0, 1.0);
  //                       return Transform(
  //                         transform: Matrix4.identity()
  //                           ..scale(clampedValue)
  //                           ..rotateZ((1 - clampedValue) * 0.5) // Rotation effect
  //                           ..translate(0.0, (1 - clampedValue) * -50), // Bounce up effect
  //                         child: Opacity(
  //                           opacity: clampedValue,
  //                           child: Text(
  //                             letter,
  //                             style: TextStyle(
  //                               fontSize: 64,
  //                               fontWeight: FontWeight.bold,
  //                               color: Colors.white,
  //                               letterSpacing: 4,
  //                               shadows: [
  //                                 Shadow(
  //                                   color: Colors.white.withOpacity((0.3 * clampedValue).clamp(0.0, 1.0)),
  //                                   blurRadius: 20 * clampedValue,
  //                                 ),
  //                               ],
  //                             ),
  //                           ),
  //                         ),
  //                       );
  //                     },
  //                   );
  //                 }),
  //               ),
  //             ),
  //           ),
  //         );
  //       },
  //     );
  //   }
  // }
}
