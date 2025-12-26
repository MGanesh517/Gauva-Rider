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
}
