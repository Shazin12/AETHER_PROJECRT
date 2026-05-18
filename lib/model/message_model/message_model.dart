import 'package:aether_project/core/enums/app_status.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class MessageModel {
  final String id;
  final String content;
  final String senderId;
  final DateTime timestamp;
  final ValueNotifier<AppStatus>? processingStatus;

  MessageModel({
    required this.id,
    required this.content,
    required this.senderId,
    required this.timestamp,
    this.processingStatus,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] as String,
      content: json['content'] as String,
      senderId: json['senderId'] as String,
      timestamp: (json['timestamp'] as Timestamp).toDate(),
      processingStatus: ValueNotifier<AppStatus>(AppStatus.success),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'content': content,
      'senderId': senderId,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }
}
