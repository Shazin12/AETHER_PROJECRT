// lib/core/di/service_locator.dart
import 'package:aether_project/services/message_service.dart';
import 'package:aether_project/services/raid_service.dart';
import 'package:aether_project/services/world_boss_service.dart';
import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final GetIt sl = GetIt.instance;

Future<void> setupDependencies() async {
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  sl.registerLazySingleton<RaidService>(
    () => RaidService(sl<FirebaseFirestore>()),
  );

  sl.registerLazySingleton<WorldBossService>(
    () => WorldBossService(sl<FirebaseFirestore>()),
  );
  
  sl.registerLazySingleton<MessageService>(
    () => MessageService(sl<FirebaseFirestore>()),
  );
}
