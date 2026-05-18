import 'dart:async';

import 'package:aether_project/core/constant.dart';
import 'package:aether_project/core/enums/app_status.dart';
import 'package:aether_project/model/message_model/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class MessageService {
  final FirebaseFirestore _firestore;
  MessageService(FirebaseFirestore firestore) : _firestore = firestore;

  CollectionReference<Map<String, dynamic>> _doc() {
    return _firestore
        .collection(mainCollection)
        .doc(mainDocID)
        .collection("messages");
  }

  MessageModel sendMessage(String userID, String message) {
    final ValueNotifier<AppStatus> processing = ValueNotifier<AppStatus>(
      AppStatus.loading,
    );
    final String id = DateTime.now().millisecondsSinceEpoch.toString();

    final MessageModel msg = MessageModel(
      timestamp: DateTime.now(),
      id: id,
      content: message,
      senderId: userID,
      processingStatus: processing,
    );

    _doc()
        .doc(id)
        .set(msg.toJson())
        .then((_) {
          processing.value = AppStatus.success;
        })
        .catchError((dynamic e) {
          processing.value = AppStatus.error;
        });

    return msg;
  }

  Stream<List<MessageModel>> listen() {
    return _doc()
        .orderBy("timestamp", descending: true)
        .where("timestamp", isGreaterThanOrEqualTo: DateTime.now())
        .snapshots()
        .map((QuerySnapshot<Map<String, dynamic>> e) {
          return e.docs.map((QueryDocumentSnapshot<Map<String, dynamic>> e) {
            return MessageModel.fromJson(e.data());
          }).toList();
        });
  }

  Future<List<MessageModel>> loadMore(DateTime lastTimestamp, int limit) async {
    final QuerySnapshot<Map<String, dynamic>> res = await _doc()
        .orderBy("timestamp", descending: true)
        .where("timestamp", isLessThan: lastTimestamp)
        .limit(limit)
        .get();

    return res.docs
        .map(
          (QueryDocumentSnapshot<Map<String, dynamic>> e) =>
              MessageModel.fromJson(e.data()),
        )
        .toList();
  }

  Future<List<MessageModel>> loadLastMessages(int limit) async {
    final QuerySnapshot<Map<String, dynamic>> res = await _doc()
        .orderBy("timestamp", descending: true)
        .limit(limit)
        .get();

    return res.docs
        .map(
          (QueryDocumentSnapshot<Map<String, dynamic>> e) =>
              MessageModel.fromJson(e.data()),
        )
        .toList();
  }
}
