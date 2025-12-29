class ForgotPasswordRequest {
  final String email;
  final String role;

  ForgotPasswordRequest({required this.email, this.role = 'NORMAL_USER'});

  Map<String, dynamic> toJson() => {'email': email, 'role': role};
}
