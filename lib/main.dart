import 'package:aether_project/core/di/injection.dart';
import 'package:aether_project/core/enums/app_status.dart';
import 'package:aether_project/core/theme/app_theme.dart';
import 'package:aether_project/firebase_options.dart';
import 'package:aether_project/provider/boss_raid_pro.dart';
import 'package:aether_project/provider/message_pro.dart';
import 'package:aether_project/provider/raid_join_pro.dart';
import 'package:aether_project/services/message_service.dart';
import 'package:aether_project/services/raid_service.dart';
import 'package:aether_project/services/world_boss_service.dart';
import 'package:aether_project/ui/screens/home_screen/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupDependencies();

  runApp(
    MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider<BossRaidPro>(
          create: (_) => BossRaidPro(sl<WorldBossService>())..init(),
        ),
        ChangeNotifierProvider<RaidJoinPro>(
          create: (_) => RaidJoinPro(sl<RaidService>()),
        ),

        ChangeNotifierProvider<MessagePro>(
          create: (_) => MessagePro(sl<MessageService>())..init(),
        ),
        
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final BossRaidPro bossRaidPro = context.read<BossRaidPro>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: Scaffold(
        body: SafeArea(
          child: Selector<BossRaidPro, AppStatus>(
            selector: (_, BossRaidPro v) => v.status,
            builder: (_, AppStatus v, _) {
              if (v == AppStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (v == AppStatus.error) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 20,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () => bossRaidPro.init(),
                        child: const Text('Retry'),
                      ),
                      Text(
                        bossRaidPro.errorMessage ?? 'An error occurred',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14, color: Colors.red[700]),
                      ),
                    ],
                  ),
                );
              }
              return const HomeScreen();
            },
          ),
        ),
      ),
    );
  }
}
