class ResetPasswordRequest {
  final String email;
  final String role;
  final String otp;
  final String newPassword;

  ResetPasswordRequest({required this.email, required this.otp, required this.newPassword, this.role = 'NORMAL_USER'});

  Map<String, dynamic> toJson() => {'email': email, 'role': role, 'otp': otp, 'newPassword': newPassword};
}
