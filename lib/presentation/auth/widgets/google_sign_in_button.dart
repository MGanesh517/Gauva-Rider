import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gauva_userapp/core/config/environment.dart';
import 'package:gauva_userapp/core/utils/app_colors.dart';
import 'package:gauva_userapp/core/widgets/is_ios.dart';
import 'package:gauva_userapp/presentation/account_page/provider/theme_provider.dart';
import 'package:gauva_userapp/presentation/auth/provider/auth_providers.dart';
import 'package:gauva_userapp/presentation/auth/view_model/auth_notifier.dart';

class GoogleSignInButton extends ConsumerWidget {
  const GoogleSignInButton({super.key});

  Future<void> _handleGoogleSignIn(BuildContext context, WidgetRef ref, GoogleSignInNotifier stateNotifier) async {
    print('');
    print('🔵 ═══════════════════════════════════════════════════════');
    print('🔵 GOOGLE SIGN-IN BUTTON - Starting');
    print('🔵 ═══════════════════════════════════════════════════════');

    try {
      print('📱 Step 1: Initializing Google Sign In...');
      // Initialize Google Sign In - do this on a separate isolate if possible
      // Use web client ID from google-services.json (client_type: 3)
      // This is the OAuth 2.0 client ID for web applications
      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: ['email', 'profile'],
        // Removed serverClientId to use Android OAuth client from google-services.json
        // This will automatically use the Android client with matching SHA-1
      );
      print('✅ Step 1: Google Sign In initialized');
      print('   🔑 Using Web Client ID: ${Environment.GOOGLE_WEB_CLIENT_ID}');

      print('📱 Step 2: Opening Google Sign In dialog...');
      // Sign in with Google - this opens native activity
      // The frame skipping is expected during this transition
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      print('📱 Step 2: Google Sign In dialog closed');

      if (googleUser == null) {
        print('⚠️ Step 2: User cancelled Google Sign In');
        // User cancelled the sign-in - no error needed
        return;
      }

      print('✅ Step 2: User selected Google account');
      print('   👤 Name: ${googleUser.displayName}');
      print('   📧 Email: ${googleUser.email}');
      print('   🆔 ID: ${googleUser.id}');

      print('📱 Step 3: Getting authentication details...');
      // Get authentication details
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      print('✅ Step 3: Authentication details received');

      // Get the ID token
      final String? idToken = googleAuth.idToken;
      print('📱 Step 4: Checking ID token...');
      print('   🔑 ID Token: ${idToken != null ? "${idToken.substring(0, 30)}..." : "NULL"}');
      print(
        '   🔑 Access Token: ${googleAuth.accessToken != null ? "${googleAuth.accessToken!.substring(0, 30)}..." : "NULL"}',
      );

      if (idToken == null) {
        print('❌ Step 4: ID token is NULL - Cannot proceed');
        // Handle error - ID token is null
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to get Google authentication token'), duration: Duration(seconds: 3)),
          );
        }
        return;
      }

      print('✅ Step 4: ID token received (length: ${idToken.length})');

      // Extract user information from Google account
      final String? name = googleUser.displayName;
      final String? email = googleUser.email;
      // Phone number is not available from Google Sign-In, so it will be null
      final String? phone = null;

      print('📱 Step 5: Preparing data for API call...');
      print('   👤 Name: $name');
      print('   📧 Email: $email');
      print('   📱 Phone: $phone (not available from Google)');

      print('📱 Step 6: Calling sign-in notifier...');
      // Call the sign-in notifier with the ID token and user info
      // This will handle the API call and state management
      await stateNotifier.signInWithGoogle(idToken: idToken, name: name, email: email, phone: phone);
      print('✅ Step 6: Sign-in notifier completed');
      print('🔵 ═══════════════════════════════════════════════════════');
      print('');
    } catch (e, stackTrace) {
      print('');
      print('🔴 ═══════════════════════════════════════════════════════');
      print('🔴 GOOGLE SIGN-IN BUTTON - ERROR');
      print('🔴 Error: $e');
      print('🔴 Stack Trace: $stackTrace');
      print('🔴 ═══════════════════════════════════════════════════════');
      print('');
      // Handle error gracefully
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Google sign-in failed: ${e.toString()}'), duration: const Duration(seconds: 4)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(googleSignInNotifierProvider);
    final stateNotifier = ref.read(googleSignInNotifierProvider.notifier);
    final isDark = ref.read(themeModeProvider.notifier).isDarkMode();

    final isLoading = state.when(
      initial: () => false,
      loading: () => true,
      success: (data) => false,
      error: (e) => false,
    );

    return SafeArea(
      bottom: !isIos(),
      child: Container(
        height: 80.h,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(color: isDark ? AppColors.surface : Colors.white),
        child: ElevatedButton(
          onPressed: isLoading
              ? null
              : () {
                  // Use unawaited to prevent blocking, but handle in try-catch
                  _handleGoogleSignIn(context, ref, stateNotifier);
                },
          style: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, 48.h),
            padding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 16.w),
            backgroundColor: isDark ? AppColors.surface : Colors.white,
            foregroundColor: isDark ? Colors.white : Colors.black87,
            elevation: 1,
            shadowColor: Colors.black.withOpacity(0.1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: isDark ? Colors.grey.shade700 : Colors.grey.shade300, width: 1),
            ),
          ),
          child: isLoading
              ? SizedBox(
                  height: 24.h,
                  width: 24.w,
                  child: ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFF397098), Color(0xFF942FAF)],
                    ).createShader(bounds),
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(isDark ? Colors.white : Colors.black87),
                    ),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Google icon - proper multi-colored G logo
                    SizedBox(
                      width: 20.w,
                      height: 20.h,
                      child: CustomPaint(painter: GoogleLogoPainter()),
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      'Sign in with Google',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

// Custom painter for Google logo
class GoogleLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Draw the Google 'G' logo with proper colors
    // Blue arc (top right)
    paint.color = const Color(0xFF4285F4);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -0.5 * 3.14159, // -90 degrees
      1.5 * 3.14159, // 270 degrees
      true,
      paint,
    );

    // Red arc (top left)
    paint.color = const Color(0xFFEA4335);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -0.5 * 3.14159, // -90 degrees
      0.5 * 3.14159, // 90 degrees
      true,
      paint,
    );

    // Yellow arc (bottom left)
    paint.color = const Color(0xFFFBBC05);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      0.0, // 0 degrees
      0.5 * 3.14159, // 90 degrees
      true,
      paint,
    );

    // Green arc (bottom right)
    paint.color = const Color(0xFF34A853);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      0.5 * 3.14159, // 90 degrees
      0.5 * 3.14159, // 90 degrees
      true,
      paint,
    );

    // Draw white center circle to create the 'G' shape
    paint.color = Colors.white;
    canvas.drawCircle(center, radius * 0.5, paint);

    // Draw the horizontal bar of the 'G'
    paint.color = const Color(0xFF4285F4);
    final barRect = Rect.fromLTWH(center.dx, center.dy - radius * 0.15, radius, radius * 0.3);
    canvas.drawRect(barRect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
