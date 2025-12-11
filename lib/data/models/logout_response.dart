class LogoutResponse {
  final bool? success;
  final String? message;

  LogoutResponse({required this.success, required this.message});

  factory LogoutResponse.fromMap(Map<String, dynamic> map) => LogoutResponse(
      success: map['success'],
      message: map['message'],
    );
}
