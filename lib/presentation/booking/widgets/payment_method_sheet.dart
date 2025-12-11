// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:gauva_userapp/common/error_view.dart';
// import 'package:gauva_userapp/common/loading_view.dart';
// import 'package:gauva_userapp/core/extensions/extensions.dart';
// import 'package:gauva_userapp/core/theme/color_palette.dart';
// import 'package:gauva_userapp/core/utils/network_image.dart';
// import 'package:gauva_userapp/data/services/navigation_service.dart';
// import 'package:gauva_userapp/presentation/payment_method/provider/provider.dart';

// import '../../../data/services/local_storage_service.dart';
// import '../../../generated/l10n.dart';
// import '../../stripe_payment/provier/payment_confirm_provider.dart';

// void showPaymentMethodSheet({
//   required BuildContext context,
// }) {
//   showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//     ),
//     builder: (context) => SafeArea(
//       child: Consumer(
//           builder: (context, ref, _) {
//             final state = ref.watch(paymentMethodsNotifierProvider);
//             final selectPaymentMethod = ref.read(selectedPayMethodProvider.notifier);
//             final selectPaymentMethodState = ref.watch(selectedPayMethodProvider);
      
//             return state.when(
//               initial: () {
//                 // Call API only once
//                 WidgetsBinding.instance.addPostFrameCallback((_) {
//                   ref.read(paymentMethodsNotifierProvider.notifier).getPaymentMethods();
//                 });
//                 return const LoadingView();
//               },
//               loading: () => const LoadingView(height: 100, width: 100, ),
//               success: (methods) => Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       const SizedBox(height: 16),
//                        Text(
//                          AppLocalizations.of(context).select_payment_method,
//                         style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                       const Divider(),
//                       ...methods.map((method) {
//                         final isSelected = selectPaymentMethodState?.id == method.id;
//                         return Padding(
//                           padding: const EdgeInsets.only(bottom: 8.0),
//                           child: ListTile(
//                             shape:  OutlineInputBorder(
//                               borderSide: BorderSide(color: isSelected ? ColorPalette.primary50 : Colors.grey)
//                             ),
//                             leading: buildNetworkImage(
//                                 imageUrl: method.logo, height: 24, width: 70, fit: BoxFit.fill),
//                             title: Text(method.value?.capitalize() ?? '', style: context.bodyLarge?.copyWith(fontWeight: FontWeight.bold),),
//                             trailing: isSelected ? const Icon(Icons.check_circle, color: Colors.green) : null,
//                             onTap: () async{

//                               selectPaymentMethod.selectPaymentMethod(method);
//                               NavigationService.pop();
//                               // final paymentMethod = method.value?.toLowerCase();
//                               // if(paymentMethod == null)return;
//                               // final orderId = await LocalStorageService().getOrderId() ?? 0;
//                               // ref
//                               //     .read(paymentConfirmNotifierProvider.notifier)
//                               //     .paymentConfirm(orderId: orderId, paymentMethodName: method.value?.toLowerCase() ?? '');
//                             },
//                           ),
//                         );
//                       }),
//                       const SizedBox(height: 16),
//                     ],
//                   ),
//                 ),
//               error: (e) => ErrorView(message: e.message),
//             );
//           },
//         ),
//     ),
//   );
// }

