class CommonResponse {
  final bool? success;
  final String? message;

  CommonResponse({required this.success, required this.message});

  factory CommonResponse.fromMap(Map<String, dynamic> json) => CommonResponse(
      success: json['success'],
      message: json['message'],
    );
}
