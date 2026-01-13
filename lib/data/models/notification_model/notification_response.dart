import 'notification_model.dart';

class NotificationResponse {
  final List<NotificationModel>? content;
  final int? totalElements;
  final int? totalPages;
  final int? size;
  final int? number;
  final bool? first;
  final bool? last;

  NotificationResponse({
    this.content,
    this.totalElements,
    this.totalPages,
    this.size,
    this.number,
    this.first,
    this.last,
  });

  factory NotificationResponse.fromJson(Map<String, dynamic> json) {
    return NotificationResponse(
      content: (json['content'] as List<dynamic>?)
          ?.map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalElements: json['totalElements'] as int?,
      totalPages: json['totalPages'] as int?,
      size: json['size'] as int?,
      number: json['number'] as int?,
      first: json['first'] as bool?,
      last: json['last'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content?.map((e) => e.toJson()).toList(),
      'totalElements': totalElements,
      'totalPages': totalPages,
      'size': size,
      'number': number,
      'first': first,
      'last': last,
    };
  }
}
