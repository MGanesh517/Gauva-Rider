import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:gauva_userapp/core/errors/failure.dart';
import 'package:gauva_userapp/data/models/create_order_response/create_order_response.dart';
import 'package:gauva_userapp/data/models/order_response/order_detail/order_detail_model.dart';
import 'package:gauva_userapp/data/models/order_response/tip_model/trip_model.dart';
import 'package:gauva_userapp/data/repositories/interfaces/order_repo_interface.dart';

import '../../domain/interfaces/order_service_interface.dart';
import 'base_repository.dart';

class OrderRepoImpl extends BaseRepository implements IOrderRepo {
  final IOrderService orderService;

  OrderRepoImpl(this.orderService);
  @override
  Future<Either<Failure, CreateOrderResponse>> createOrder({required Map<String, dynamic> data}) async =>
      await safeApiCall(() async {
        debugPrint('🚗 CREATE ORDER - Data: $data');
        final response = await orderService.createOrder(data: data);
        debugPrint('📥 CREATE ORDER Response: ${response.data}');
        try {
          dynamic responseData = response.data;
          debugPrint('🔍 CREATE ORDER - Response type: ${responseData.runtimeType}');
          debugPrint('🔍 CREATE ORDER - Is List: ${responseData is List}');
          debugPrint('🔍 CREATE ORDER - Is Map: ${responseData is Map}');

          // Handle case where response is an array (List)
          if (responseData is List) {
            debugPrint('📦 CREATE ORDER - Response is an array (List), extracting first element...');
            debugPrint('📦 CREATE ORDER - Array length: ${responseData.length}');
            if (responseData.isNotEmpty) {
              // Extract the first order object from the array
              final firstElement = responseData[0];
              debugPrint('🔍 CREATE ORDER - First element type: ${firstElement.runtimeType}');

              // Convert to Map if it's not already
              Map<String, dynamic> orderObject;
              if (firstElement is Map) {
                orderObject = Map<String, dynamic>.from(firstElement);

                // Extract user ID from order response and store it for Socket.IO connection
                // The API returns user object with id field (UUID string)
                String? userUuid;
                if (orderObject.containsKey('user') && orderObject['user'] is Map) {
                  final userObj = orderObject['user'] as Map<String, dynamic>;
                  userUuid = userObj['id']?.toString();
                  debugPrint('👤 CREATE ORDER - Found user in order response: $userUuid');

                  // Store user UUID in order object for later use
                  // We'll extract it in create_order_notifier for Socket.IO
                  orderObject['_userUuid'] = userUuid;
                }
              } else {
                throw Exception('Order creation failed: First element is not a Map');
              }

              debugPrint('📦 CREATE ORDER - Extracted order object with ID: ${orderObject['id']}');

              // Store user UUID in the data wrapper for later extraction
              String? userUuid;
              if (orderObject.containsKey('user') && orderObject['user'] is Map) {
                final userObj = orderObject['user'] as Map<String, dynamic>;
                userUuid = userObj['id']?.toString();
                debugPrint('👤 CREATE ORDER - Storing user UUID for Socket.IO: $userUuid');
              }

              // Wrap the order object in the expected format
              responseData = <String, dynamic>{
                'data': <String, dynamic>{
                  'order': orderObject,
                  if (userUuid != null) '_userUuid': userUuid, // Store user UUID for Socket.IO
                },
              };
              debugPrint('✅ CREATE ORDER - Wrapped response data, type: ${responseData.runtimeType}');
            } else {
              debugPrint('⚠️ CREATE ORDER - Array is empty');
              throw Exception('Order creation failed: Empty response array');
            }
          }
          // Handle case where response is the order object directly (not wrapped)
          else if (responseData is Map) {
            final responseMap = Map<String, dynamic>.from(responseData);
            if (responseMap.containsKey('id') &&
                !responseMap.containsKey('data') &&
                !responseMap.containsKey('success')) {
              debugPrint('📦 CREATE ORDER - Response is order object directly, wrapping...');
              // Wrap the order object in the expected format
              responseData = <String, dynamic>{
                'data': <String, dynamic>{'order': responseMap},
              };
            }
          } else {
            debugPrint('⚠️ CREATE ORDER - Unexpected response type: ${responseData.runtimeType}');
            throw Exception('Order creation failed: Unexpected response format');
          }

          // Ensure responseData is a Map before parsing
          if (responseData is! Map<String, dynamic>) {
            debugPrint('❌ CREATE ORDER - responseData is not a Map after processing');
            debugPrint('❌ CREATE ORDER - Final type: ${responseData.runtimeType}');
            throw Exception('Order creation failed: Response data is not a Map');
          }

          final result = CreateOrderResponse.fromJson(responseData);
          debugPrint('✅ CREATE ORDER - Parsed successfully');
          debugPrint('✅ Order ID: ${result.data?.order?.id}');
          return result;
        } catch (e, stackTrace) {
          debugPrint('🔴 CREATE ORDER - Parsing error: $e');
          debugPrint('🔴 Stack trace: $stackTrace');
          debugPrint('🔴 Raw response data: ${response.data}');
          rethrow;
        }
      });

  @override
  Future<Either<Failure, OrderDetailModel>> orderDetails({required int orderId}) async => await safeApiCall(() async {
    debugPrint('📋 ORDER DETAILS - Order ID: $orderId');
    final response = await orderService.orderDetails(orderId: orderId);
    debugPrint('📥 ORDER DETAILS Response: ${response.data}');
    debugPrint('📥 ORDER DETAILS Response Type: ${response.data.runtimeType}');
    
    try {
      dynamic responseData = response.data;
      
      // Handle case where response is the order object directly
      if (responseData is Map && responseData.containsKey('id') && !responseData.containsKey('data')) {
        debugPrint('📦 ORDER DETAILS - Response is order object directly, wrapping...');
        final orderMap = Map<String, dynamic>.from(responseData);
        responseData = <String, dynamic>{
          'success': true,
          'message': 'Order details retrieved',
          'data': orderMap,
        };
      }
      // Handle case where response is an array (shouldn't happen, but handle it)
      else if (responseData is List && responseData.isNotEmpty) {
        debugPrint('📦 ORDER DETAILS - Response is array, extracting first element...');
        final firstElement = responseData[0];
        final orderMap = firstElement is Map 
            ? Map<String, dynamic>.from(firstElement)
            : firstElement;
        responseData = <String, dynamic>{
          'success': true,
          'message': 'Order details retrieved',
          'data': orderMap,
        };
      }
      
      final result = OrderDetailModel.fromJson(responseData);
      debugPrint('✅ ORDER DETAILS - Parsed successfully');
      debugPrint('✅ Order ID: ${result.data?.id}');
      debugPrint('✅ Order Status: ${result.data?.status}');
      debugPrint('✅ Driver: ${result.data?.driver?.name ?? "N/A"}');
      debugPrint('✅ Pickup: ${result.data?.addresses?.pickupAddress ?? "N/A"}');
      debugPrint('✅ Drop: ${result.data?.addresses?.dropAddress ?? "N/A"}');
      debugPrint('✅ Distance: ${result.data?.distance}');
      debugPrint('✅ Duration: ${result.data?.duration}');
      return result;
    } catch (e, stackTrace) {
      debugPrint('🔴 ORDER DETAILS - Parsing error: $e');
      debugPrint('🔴 Stack trace: $stackTrace');
      debugPrint('🔴 Raw response data: ${response.data}');
      rethrow;
    }
  });

  @override
  Future<Either<Failure, TripModel>> checkActiveTrip() async => await safeApiCall(() async {
    debugPrint('🔍 CHECK ACTIVE TRIP');
    final response = await orderService.checkActiveTrip();
    debugPrint('📥 CHECK ACTIVE TRIP Response: ${response.data}');
    debugPrint('📥 Response Type: ${response.data.runtimeType}');

    try {
      // Handle empty array response (no active trips)
      if (response.data is List && (response.data as List).isEmpty) {
        debugPrint('✅ CHECK ACTIVE TRIP - No active trips (empty array)');
        return TripModel(message: 'No active trips', data: null);
      }

      // Handle array with data
      if (response.data is List && (response.data as List).isNotEmpty) {
        debugPrint('📦 CHECK ACTIVE TRIP - Array response with data');
        // Wrap array response in expected format
        final wrappedData = {
          'message': 'Active trips found',
          'data': {'order': (response.data as List).first},
        };
        final result = TripModel.fromJson(wrappedData);
        debugPrint('✅ CHECK ACTIVE TRIP - Parsed from array successfully');
        debugPrint('✅ Active order: ${result.data?.order?.id}');
        return result;
      }

      // Handle normal object response
      final result = TripModel.fromJson(response.data);
      debugPrint('✅ CHECK ACTIVE TRIP - Parsed successfully');
      debugPrint('✅ Active order: ${result.data?.order?.id ?? "None"}');
      return result;
    } catch (e, stackTrace) {
      debugPrint('🔴 CHECK ACTIVE TRIP - Parsing error: $e');
      debugPrint('🔴 Stack trace: $stackTrace');
      debugPrint('🔴 Raw response data: ${response.data}');
      // Return empty trip model on error
      return TripModel(message: 'No active trips', data: null);
    }
  });
}
