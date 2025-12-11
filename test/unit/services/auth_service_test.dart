import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:gauva_userapp/domain/interfaces/auth_service_interface.dart';

class MockAuthService extends Mock implements IAuthService {}

void main() {
  group(
    'AuthService',
    () {
      late MockAuthService authService;

      setUp(() {
        authService = MockAuthService();
      });

      test('login should return a successful response and handle failure', () async {
        // Arrange: Define the behavior of the mocked method for success
        when(() => authService.login(phone: '1234567890', countryCode: '880')).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(),
            data: {
              'success': true,
              'data': [],
            },
            statusCode: 200,
          ),
        );

        // Act: Call the method for success scenario
        final result = await authService.login(phone: '1234567890', countryCode: '880');

        // Assert: Verify the result for success
        expect(result.statusCode, 200);
        expect(result.data, {'success': true, 'data': []});

        // Verify that the method was called once for success
        verify(() => authService.login(phone: '1234567890', countryCode: '880')).called(1);

        // Clear any previous interactions
        clearInteractions(authService);

        // Arrange: Define the behavior of the mocked method for failure
        when(() => authService.login(phone: '1234567890', countryCode: '880')).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(),
            data: {
              'success': false,
              'message': 'Invalid phone number',
            },
            statusCode: 400,
          ),
        );

        // Act: Call the method for failure scenario
        final result2 = await authService.login(phone: '1234567890', countryCode: '880');

        // Assert: Verify the result for failure
        expect(result2.statusCode, 400);
        expect(result2.data, {'success': false, 'message': 'Invalid phone number'});

        // Verify that the method was called once for failure
        verify(() => authService.login(phone: '1234567890', countryCode: '880')).called(1);
      });
    },
  );
}
