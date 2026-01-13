class NotificationModel {
  final int? id;
  final String? title;
  final String? message;
  final String? type;
  final bool? read;
  final DateTime? createdAt;
  final Map<String, dynamic>? data;

  NotificationModel({
    this.id,
    this.title,
    this.message,
    this.type,
    this.read,
    this.createdAt,
    this.data,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as int?,
      title: json['title'] as String?,
      message: json['message'] as String?,
      type: json['type'] as String?,
      read: json['read'] as bool?,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'].toString())
          : null,
      data: json['data'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'type': type,
      'read': read,
      'createdAt': createdAt?.toIso8601String(),
      'data': data,
    };
  }
}
