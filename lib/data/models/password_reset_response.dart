class PasswordResetResponse {
  final bool success;
  final String message;

  PasswordResetResponse({required this.success, required this.message});

  factory PasswordResetResponse.fromJson(Map<String, dynamic> json) {
    return PasswordResetResponse(success: json['success'] ?? false, message: json['message'] ?? '');
  }
}
