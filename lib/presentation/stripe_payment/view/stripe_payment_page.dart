// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:gauva_userapp/data/services/navigation_service.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
//
// import '../../../core/config/environment.dart';
// import '../provier/payment_confirm_provider.dart';
//
// class StripePaymentWebView extends ConsumerStatefulWidget {
//   final String paymentUrl;
//   final VoidCallback? onPaymentSuccess;
//
//   const StripePaymentWebView({
//     super.key,
//     required this.paymentUrl,
//     this.onPaymentSuccess,
//   });
//
//   @override
//   ConsumerState<StripePaymentWebView> createState() => _StripePaymentWebViewState();
// }
//
// class _StripePaymentWebViewState extends ConsumerState<StripePaymentWebView> {
//   late InAppWebViewController _webViewController;
//   final GlobalKey _webViewKey = GlobalKey();
//
//   @override
//   Widget build(BuildContext context) {
//     final successUrl = '${Environment.baseUrl}/payment-success';
//     final cancelUrl = '${Environment.baseUrl}/payment-cancel';
//
//     return SafeArea(
//       child: SizedBox(
//         height: MediaQuery.of(context).size.height,
//         child: InAppWebView(
//           key: _webViewKey,
//           initialUrlRequest: URLRequest(url: WebUri(widget.paymentUrl)),
//           initialOptions: InAppWebViewGroupOptions(
//             crossPlatform: InAppWebViewOptions(
//               javaScriptEnabled: true,
//               useShouldOverrideUrlLoading: true,
//             ),
//             android: AndroidInAppWebViewOptions(
//               useHybridComposition: true,
//             ),
//             ios: IOSInAppWebViewOptions(
//               allowsInlineMediaPlayback: true,
//             ),
//           ),
//           onWebViewCreated: (controller) {
//             _webViewController = controller;
//           },
//           shouldOverrideUrlLoading: (controller, navigationAction) async {
//             final uri = navigationAction.request.url;
//             if (uri != null) {
//               final urlStr = uri.toString();
//               if (urlStr.contains(successUrl)) {
//                 ref.read(hitSuccessUrlProvider.notifier).hitSuccessUrl(url: urlStr);
//                 // Prevent loading further
//                 return NavigationActionPolicy.CANCEL;
//               }
//               if (urlStr.contains(cancelUrl) || urlStr.contains('cancel')) {
//                 Future.delayed(const Duration(milliseconds: 300), () {
//                   NavigationService.pop();
//                 });
//                 return NavigationActionPolicy.CANCEL;
//               }
//             }
//             return NavigationActionPolicy.ALLOW;
//           },
//           onLoadStart: (controller, url) {
//             // optional: handle on load start
//           },
//           onLoadStop: (controller, url) async {
//             // optional: handle on load stop
//           },
//           onReceivedServerTrustAuthRequest:
//               (controller, challenge) async {
//             // handle SSL trust if needed
//             return ServerTrustAuthResponse(
//                 action: ServerTrustAuthResponseAction.PROCEED);
//           },
//
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gauva_userapp/data/services/navigation_service.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';

import '../../../core/config/environment.dart';
import '../provier/payment_confirm_provider.dart';

class StripePaymentWebView extends ConsumerStatefulWidget {
  final String paymentUrl;
  final VoidCallback? onPaymentSuccess;

  const StripePaymentWebView({super.key, required this.paymentUrl, this.onPaymentSuccess});

  @override
  ConsumerState<StripePaymentWebView> createState() => _StripePaymentWebViewState();
}

class _StripePaymentWebViewState extends ConsumerState<StripePaymentWebView> {
  late final WebViewController _controller;
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
          onPageStarted: (url) {},
          onPageFinished: (url) {},
          onWebResourceError: (error) {},
          onNavigationRequest: (request) {
            final successUrl = '${Environment.baseUrl}/payment-success';
            final cancelUrl = '${Environment.baseUrl}/payment-cancel';
            if (request.url.contains(successUrl)) {
              ref.read(hitSuccessUrlProvider.notifier).hitSuccessUrl(url: request.url);

              return NavigationDecision.prevent;
            }

            if (request.url.contains(cancelUrl) || request.url.contains('cancel')) {
              Future.delayed(const Duration(milliseconds: 300), () {
                NavigationService.pop();
              });
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentUrl));
  }

  @override
  Widget build(BuildContext context) => SafeArea(
    child: SizedBox(
      height: MediaQuery.of(context).size.height,
      child: WebViewWidget(controller: _controller),
    ),
  );
}
