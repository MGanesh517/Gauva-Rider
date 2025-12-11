import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gauva_userapp/core/utils/app_colors.dart';
import 'package:gauva_userapp/core/widgets/is_ios.dart';
import 'package:gauva_userapp/presentation/account_page/provider/theme_provider.dart';
import 'package:gauva_userapp/presentation/auth/provider/auth_providers.dart';

class GoogleSignInButton extends ConsumerWidget {
  const GoogleSignInButton({super.key});

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
              : () async {
                  try {
                    // Initialize Google Sign In
                    final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);

                    // Sign in with Google
                    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

                    if (googleUser == null) {
                      // User cancelled the sign-in
                      return;
                    }

                    // Get authentication details
                    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

                    // Get the ID token
                    final String? idToken = googleAuth.idToken;

                    if (idToken == null) {
                      // Handle error - ID token is null
                      if (context.mounted) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(const SnackBar(content: Text('Failed to get Google authentication token')));
                      }
                      return;
                    }

                    // Extract user information from Google account
                    final String? name = googleUser.displayName;
                    final String? email = googleUser.email;
                    // Phone number is not available from Google Sign-In, so it will be null
                    final String? phone = null;

                    // Call the sign-in notifier with the ID token and user info
                    await stateNotifier.signInWithGoogle(idToken: idToken, name: name, email: email, phone: phone);
                  } catch (e) {
                    // Handle error
                    if (context.mounted) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text('Google sign-in failed: ${e.toString()}')));
                    }
                  }
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
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(isDark ? Colors.white : Colors.black87),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Google icon - using a simple colored circle with "G"
                    Container(
                      width: 20.w,
                      height: 20.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade300, width: 0.5),
                      ),
                      child: Center(
                        child: Text(
                          'G',
                          style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.blue.shade700),
                        ),
                      ),
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
