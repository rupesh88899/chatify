class MessageModel {
  final String senderId;
  final String message;
  final DateTime timestamp;
  final String? id;

  MessageModel({
   this.id,

    required this.senderId,
    required this.message,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'message': message,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map,[String?id]) {
    return MessageModel(
      id: id,
      senderId: map['senderId'],
      message: map['message'],
      timestamp: DateTime.parse(map['timestamp']),
    );
  }
}
