import 'package:aether_project/core/constant.dart';
import 'package:aether_project/core/theme/app_colors.dart';
import 'package:aether_project/model/world_boss_model/world_boss_model.dart';
import 'package:aether_project/provider/boss_raid_pro.dart';
import 'package:aether_project/ui/screens/home_screen/widgets/home_screen_timer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreenSection1 extends StatelessWidget {
  const HomeScreenSection1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xFFE8D4F8),
            Color.fromARGB(255, 169, 116, 238),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: <BoxShadow>[defaultShadow],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Global Pulse Label
          const Row(
            spacing: 8,
            children: <Widget>[
              Icon(Icons.electric_bolt, color: Color(0xFF7C3AED), size: 16),
              Text(
                'GLOBAL PULSE',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // World Boss Title
          const Text(
            'WORLD BOSS ARRIVES IN',
            style: TextStyle(
              color: Color(0xFF1F1D2C),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          // Countdown Timer
          Selector<BossRaidPro, WorldBossModel?>(
            selector: (_, BossRaidPro v) => v.worldBossModel,
            shouldRebuild: (WorldBossModel? prev, WorldBossModel? next) {
              final DateTime start = prev!.bossStartAt;
              final Duration? difference = next?.bossStartAt.difference(start);
              if (difference?.inSeconds == 0) return false;
              print("TIMER REBUILD REQUIRED");
              return true;
            },
            builder: (_, WorldBossModel? v, _) {
              if (v == null) return const SizedBox();
              return HomeScreenTimer(model: v);
            },
          ),

          const SizedBox(height: 16),
          // Updates Label
          const Row(
            spacing: 6,
            children: <Widget>[
              Icon(
                Icons.electric_bolt,
                color: AppColors.primaryColor,
                size: 14,
              ),
              Text(
                'Updates every 100ms',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
