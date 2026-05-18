import 'dart:async';

import 'package:aether_project/core/enums/app_status.dart';
import 'package:aether_project/model/world_boss_model/world_boss_model.dart';
import 'package:aether_project/services/world_boss_service.dart';
import 'package:flutter/material.dart';

class BossRaidPro extends ChangeNotifier {
  final WorldBossService _worldBossService;
  BossRaidPro(this._worldBossService);

  AppStatus status = AppStatus.none;
  WorldBossModel? worldBossModel;
  String? errorMessage;

  StreamSubscription<WorldBossModel?>? _worldBossSubscription;

  Future<void> init() async {
    status = AppStatus.loading;
    notifyListeners();
    _worldBossSubscription = _worldBossService.listern().listen(
      (WorldBossModel? model) {
        if (model == null) return;
        if (worldBossModel == model) return;
        if (status != AppStatus.success) {
          status = AppStatus.success;
        }
        worldBossModel = model;
        notifyListeners();
      },
      onError: (dynamic e) {
        errorMessage = "Error fetching world boss info: $e";
        status = AppStatus.error;
        notifyListeners();
      },
    );
  }

  void cancelSubscription() {
    _worldBossSubscription?.cancel();
  }
}
