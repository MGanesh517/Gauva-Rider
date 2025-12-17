import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gauva_userapp/common/loading_view.dart';
import 'package:gauva_userapp/data/services/navigation_service.dart';
import 'package:gauva_userapp/presentation/wallet/provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';

class RazorpayPaymentWebView extends ConsumerStatefulWidget {
  final String paymentLinkUrl;
  final String? transactionId;

  const RazorpayPaymentWebView({super.key, required this.paymentLinkUrl, this.transactionId});

  @override
  ConsumerState<RazorpayPaymentWebView> createState() => _RazorpayPaymentWebViewState();
}

class _RazorpayPaymentWebViewState extends ConsumerState<RazorpayPaymentWebView> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebViewPlatform.instance = AndroidWebViewPlatform();
    }

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() {
              _isLoading = true;
            });
            debugPrint('🌐 Payment page started loading: $url');
          },
          onPageFinished: (url) {
            setState(() {
              _isLoading = false;
            });
            debugPrint('🌐 Payment page finished loading: $url');

            // Check for payment success/failure indicators in URL
            _checkPaymentStatus(url);
          },
          onWebResourceError: (error) {
            debugPrint('🔴 WebView error: ${error.description}');
            setState(() {
              _isLoading = false;
            });
          },
          onNavigationRequest: (request) {
            debugPrint('🌐 Navigation request: ${request.url}');

            // Check for payment completion indicators
            final url = request.url.toLowerCase();
            final uri = Uri.parse(request.url);

            // Razorpay success indicators - check URL parameters
            final paymentStatus = uri.queryParameters['razorpay_payment_link_status'];
            final paymentId = uri.queryParameters['razorpay_payment_id'];

            // Success: status=paid and has payment_id
            if (paymentStatus == 'paid' && paymentId != null && paymentId.isNotEmpty) {
              debugPrint('✅ Payment success detected - Status: $paymentStatus, Payment ID: $paymentId');
              _handlePaymentSuccess(request.url);
              return NavigationDecision.prevent;
            }

            // Also check for success in URL path
            if (url.contains('/wallet/payment/success') ||
                url.contains('payment-success') ||
                (url.contains('success') && paymentStatus == 'paid')) {
              debugPrint('✅ Payment success detected from URL path');
              _handlePaymentSuccess(request.url);
              return NavigationDecision.prevent;
            }

            // Failure indicators
            if (paymentStatus == 'failed' ||
                paymentStatus == 'cancelled' ||
                url.contains('payment-failed') ||
                url.contains('/wallet/payment/failed') ||
                (url.contains('failed') && paymentStatus != null)) {
              debugPrint('❌ Payment failed/cancelled - Status: $paymentStatus');
              _handlePaymentFailure();
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentLinkUrl));
  }

  void _checkPaymentStatus(String url) {
    try {
      final uri = Uri.parse(url);
      final paymentStatus = uri.queryParameters['razorpay_payment_link_status'];
      final paymentId = uri.queryParameters['razorpay_payment_id'];

      // Success: status=paid and has payment_id
      if (paymentStatus == 'paid' && paymentId != null && paymentId.isNotEmpty) {
        debugPrint('✅ Payment success detected from URL params - Status: $paymentStatus');
        _handlePaymentSuccess(url);
        return;
      }

      // Failure
      if (paymentStatus == 'failed' || paymentStatus == 'cancelled') {
        debugPrint('❌ Payment failed from URL params - Status: $paymentStatus');
        _handlePaymentFailure();
        return;
      }

      // Fallback: check URL path
      final lowerUrl = url.toLowerCase();
      if (lowerUrl.contains('/wallet/payment/success') || lowerUrl.contains('payment-success')) {
        _handlePaymentSuccess(url);
      } else if (lowerUrl.contains('/wallet/payment/failed') || lowerUrl.contains('payment-failed')) {
        _handlePaymentFailure();
      }
    } catch (e) {
      debugPrint('⚠️ Error parsing payment status URL: $e');
    }
  }

  void _handlePaymentSuccess(String url) {
    debugPrint('✅ Payment successful! URL: $url');

    // Extract payment details from URL
    try {
      final uri = Uri.parse(url);
      final paymentId = uri.queryParameters['razorpay_payment_id'];
      final paymentLinkId = uri.queryParameters['razorpay_payment_link_id'];
      final status = uri.queryParameters['razorpay_payment_link_status'];

      debugPrint('💳 Payment Details:');
      debugPrint('💳 Payment ID: $paymentId');
      debugPrint('💳 Payment Link ID: $paymentLinkId');
      debugPrint('💳 Status: $status');
    } catch (e) {
      debugPrint('⚠️ Error parsing payment URL: $e');
    }

    // Refresh wallet balance and navigate back
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        // Refresh wallet balance first
        ref.read(walletsNotifierProvider.notifier).getWallets();
        // Then navigate back (no new screen, just pop)
        NavigationService.pop();
      }
    });
  }

  void _handlePaymentFailure() {
    debugPrint('❌ Payment failed or cancelled');
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        NavigationService.pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Complete Payment'),
      leading: IconButton(icon: const Icon(Icons.close), onPressed: () => NavigationService.pop()),
    ),
    body: Stack(
      children: [
        WebViewWidget(controller: _controller),
        if (_isLoading)
          const Center(
            child: LoadingView(),
          ),
      ],
    ),
  );
}
