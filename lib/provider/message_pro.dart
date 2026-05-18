import 'dart:async';

import 'package:aether_project/core/enums/app_status.dart';
import 'package:aether_project/model/message_model/message_model.dart';
import 'package:aether_project/services/message_service.dart';
import 'package:flutter/foundation.dart';

class MessagePro extends ChangeNotifier {
  final MessageService _service;
  MessagePro(MessageService service) : _service = service;
  ValueNotifier<List<MessageModel>> messages =
      ValueNotifier<List<MessageModel>>(<MessageModel>[]);

  AppStatus status = AppStatus.none;
  AppStatus moreLoadstatus = AppStatus.none;
  bool _endReached = false;

  StreamSubscription<List<MessageModel>>? subscription;

  Future<void> init() async {
    status = AppStatus.loading;
    moreLoadstatus = AppStatus.none;
    _endReached = false;
    notifyListeners();
    messages.value = <MessageModel>[];
    await Future.wait(<Future<void>>[_getLatestMessages(), _startListening()]);
    status = AppStatus.success;
    notifyListeners();
  }

  void loadMore() async {
    if (messages.value.isEmpty) return;
    if (moreLoadstatus == AppStatus.loading) return;
    if (_endReached) return;
    moreLoadstatus = AppStatus.loading;
    notifyListeners();
    final DateTime lastTimestamp =
        messages.value[messages.value.length - 1].timestamp;
    final List<MessageModel> res = await _service.loadMore(lastTimestamp, 10);
    if (res.isEmpty) _endReached = true;
    _addMessage(res);
    moreLoadstatus = AppStatus.none;
    notifyListeners();
  }

  Future<void> _getLatestMessages() async {
    final List<MessageModel> res = await _service.loadLastMessages(10);
    _addMessage(res.reversed.toList());
  }

  Future<void> _startListening() async {
    cancelListening();
    final Completer<void> completer = Completer<void>();
    subscription = _service.listen().listen((List<MessageModel> e) {
      if (!completer.isCompleted) completer.complete();
      _addMessage(e);
    });
    await completer.future;
  }

  void cancelListening() {
    subscription?.cancel();
    subscription = null;
    notifyListeners();
  }

  void sendMessage(String msg) {
    final MessageModel res = _service.sendMessage("test_user_1", msg);
    _addMessage(<MessageModel>[res]);
  }

  void _addMessage(List<MessageModel> msg) {
    final List<MessageModel> freshMsg = <MessageModel>[];
    for (MessageModel element in msg) {
      if (!messages.value.any((MessageModel e) => e.id == element.id)) {
        freshMsg.add(element);
      }
    }
    messages.value = <MessageModel>[...messages.value, ...freshMsg];
    notifyListeners();
  }
}
