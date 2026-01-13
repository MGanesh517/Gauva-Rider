import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gauva_userapp/core/utils/app_colors.dart';
import 'package:gauva_userapp/core/widgets/is_ios.dart';
import 'package:gauva_userapp/presentation/account_page/provider/theme_provider.dart';
import 'package:gauva_userapp/presentation/auth/provider/auth_providers.dart';
import 'package:gauva_userapp/presentation/auth/view_model/auth_notifier.dart';

class GoogleSignInButton extends ConsumerWidget {
  const GoogleSignInButton({super.key});

  Future<void> _handleGoogleSignIn(BuildContext context, WidgetRef ref, GoogleSignInNotifier stateNotifier) async {
    try {
      // Step 1: Initialize Google Sign In (simple, no serverClientId needed for mobile)
      final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);

      // Step 2: Sign in with Google
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        // User cancelled
        return;
      }

      // Step 3: Get Google authentication
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Step 4: Create Firebase credential and sign in to Firebase
      // This gives us a Firebase ID token with correct audience for backend
      final credential = GoogleAuthProvider.credential(accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      // Step 5: Sign in to Firebase Auth to get Firebase ID token
      final UserCredential firebaseUser = await FirebaseAuth.instance.signInWithCredential(credential);

      // Step 6: Get Firebase ID token (this has the correct audience "gauva-15d9a")
      final String? firebaseIdToken = await firebaseUser.user?.getIdToken();

      if (firebaseIdToken == null) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to get authentication token'), duration: Duration(seconds: 3)),
          );
        }
        return;
      }

      // Step 7: Extract user info and send to backend
      final String? name = firebaseUser.user?.displayName;
      final String? email = firebaseUser.user?.email;

      // Step 8: Call backend with Firebase ID token
      await stateNotifier.signInWithGoogle(idToken: firebaseIdToken, name: name, email: email, phone: null);
    } catch (e) {
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
                    // Google icon - using image asset
                    Image.asset('assets/googleImage.png', width: 20.w, height: 20.h, fit: BoxFit.contain),
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
