import 'package:aether_project/core/constant.dart';
import 'package:aether_project/core/enums/app_status.dart';
import 'package:aether_project/core/theme/app_colors.dart';
import 'package:aether_project/model/world_boss_model/world_boss_model.dart';
import 'package:aether_project/provider/boss_raid_pro.dart';
import 'package:aether_project/provider/raid_join_pro.dart';
import 'package:aether_project/services/raid_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreenSection2 extends StatelessWidget {
  const HomeScreenSection2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: <BoxShadow>[defaultShadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Header with title and joined count
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Icon(Icons.group, color: AppColors.primaryColor, size: 20),
              const SizedBox(width: 8),
              const Text(
                'GEO RAID',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 12),
              const Text(
                '15 SLOTS',
                style: TextStyle(
                  color: Color(0xFF8B7BA8),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              const Icon(Icons.group, color: AppColors.primaryColor, size: 20),
              const SizedBox(width: 4),
              Selector<BossRaidPro, WorldBossModel?>(
                selector: (_, BossRaidPro v) => v.worldBossModel,
                builder: (_, WorldBossModel? v, _) {
                  return Text(
                    '${v?.joinedCount} / 15 JOINED',
                    style: const TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Player Grid
          Selector<BossRaidPro, WorldBossModel?>(
            selector: (_, BossRaidPro v) => v.worldBossModel,
            builder: (_, WorldBossModel? v, _) {
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1,
                ),
                itemCount: v?.capacity ?? 15,
                itemBuilder: (_, int i) {
                  return _buildPlayerSlot(v!.joinedCount > i);
                },
              );
            },
          ),
          const SizedBox(height: 20),
          // Join the Raid Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                //   final List<Future<RaidJoinResult>> values =
                //       <Future<RaidJoinResult>>[];

                //   for (int i = 0; i < 24; i++) {
                //     values.add(
                //       RaidService(
                //         sl<FirebaseFirestore>(),
                //       ).joinRaid(userId: 'user_$i'),
                //     );
                //   }
                // final List<RaidJoinResult> res =   await Future.wait(values);

                final RaidJoinPro read = context.read<RaidJoinPro>();
                if (read.status == AppStatus.loading) return;

                final RaidJoinResult res = await read.joinRaid();
                // ignore: use_build_context_synchronously
                final ScaffoldMessengerState of = ScaffoldMessenger.of(context);
                of.showSnackBar(SnackBar(content: Text(res.message)));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Selector<RaidJoinPro, AppStatus>(
                selector: (_, RaidJoinPro v) => v.status,
                child: const Text(
                  'JOIN THE RAID',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                builder: (_, AppStatus v, Widget? w) {
                  if (v == AppStatus.loading) {
                    return const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    );
                  }
                  return w!;
                },
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Note
          const Row(
            children: <Widget>[
              Icon(Icons.shield, color: AppColors.primaryColor, size: 16),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'First 15 players will join the battle.',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerSlot(bool isSelected) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isSelected ? AppColors.primaryColor : Colors.grey.shade300,
      ),
      child: const CircleAvatar(
        child: Icon(Icons.person_outline_rounded, color: Colors.white),
      ),
    );
  }
}
