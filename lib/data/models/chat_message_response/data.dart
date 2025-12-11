import 'chat_message.dart';

class ChatData {
  final List<Message> data;

  ChatData({required this.data});

  factory ChatData.fromJson(Map<String, dynamic> json) => ChatData(
      data: List<Message>.from(json['data'].map((e) => Message.fromJson(e))),
    );
}
