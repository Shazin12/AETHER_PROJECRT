
import 'package:aether_project/core/enums/app_status.dart';
import 'package:aether_project/services/raid_service.dart';
import 'package:flutter/material.dart';

class RaidJoinPro extends ChangeNotifier {
  final RaidService _raidService;
  RaidJoinPro(RaidService raidService) : _raidService = raidService;
  AppStatus status = AppStatus.none;

  Future<RaidJoinResult> joinRaid() async {
    status = AppStatus.loading;
    notifyListeners();
    final RaidJoinResult res = await _raidService.joinRaid(
      userId: "test_user_4",
    );

    status = res.success ? AppStatus.success : AppStatus.error;
    notifyListeners();
    return res;
  }
}
