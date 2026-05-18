import 'package:aether_project/core/constant.dart';
import 'package:aether_project/model/world_boss_model/world_boss_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_animate/flutter_animate.dart';

class RaidJoinResult {
  final bool success;
  final String message;

  const RaidJoinResult({required this.success, required this.message});
}

class RaidService {
  RaidService(this._firestore);

  final FirebaseFirestore _firestore;

  static const int _capacity = 15;

  Future<RaidJoinResult> joinRaid({required String userId}) async {
    final DocumentReference<Map<String, dynamic>> raidRef = _firestore
        .collection(mainCollection)
        .doc(mainDocID);

    final DocumentReference<Map<String, dynamic>> participantRef = raidRef
        .collection('participants')
        .doc(userId);

    try {
      await _firestore.runTransaction((Transaction transaction) async {
        final DocumentSnapshot<Map<String, dynamic>> raidSnap =
            await transaction.get(raidRef);

        if (!raidSnap.exists) {
          throw StateError('Raid does not exist');
        }

        final int joinedCount = (raidSnap.data()?['joinedCount'] as int?) ?? 0;

        if (joinedCount >= _capacity) {
          throw StateError('Raid is full');
        }

        final DocumentSnapshot<Map<String, dynamic>> participantSnap =
            await transaction.get(participantRef);

        if (participantSnap.exists) {
          throw StateError('Already joined');
        }
        transaction.update(raidRef, <String, Object>{
          'joinedCount': joinedCount + 1,
        });

        transaction.set(participantRef, <String, Object>{
          'joinedAt': FieldValue.serverTimestamp(),
        });
      });

      return const RaidJoinResult(
        success: true,
        message: 'Joined successfully',
      );
    } on StateError catch (e) {
      return RaidJoinResult(success: false, message: e.message);
    } on FirebaseException catch (e) {
      return RaidJoinResult(
        success: false,
        message: 'Network/Contention Error: ${e.code}',
      );
    } catch (e) {
      return RaidJoinResult(
        success: false,
        message: 'Unknown error occurred $e',
      );
    }
  }

  Future<void> rapidConcurrencyTest() async {
    print("Starting rapid concurrency test with 20...");
    final WorldBossModel worldBossModel = WorldBossModel(
      capacity: 15,
      joinedCount: 0,
      bossStartAt: DateTime.now().add(20.minutes),
    );
    final DocumentReference<Map<String, dynamic>> doc = _firestore
        .collection(mainCollection)
        .doc(mainDocID);

    await doc.set(worldBossModel.toJson());
    print(
      "Initial raid document created with data: ${worldBossModel.toJson()}",
    );

    final List<Future<RaidJoinResult>> jobs = <Future<RaidJoinResult>>[];
    final String date = DateTime.now().toIso8601String();
    for (int i = 0; i < 20; i++) {
      print("👷‍♂️ Adding raid join ${i + 1}");
      jobs.add(joinRaid(userId: 'user_${i}_$date'));
    }
    print("Starting concurrent join requests...");
    final List<RaidJoinResult> res = await Future.wait(jobs);
    print(
      "Join success count is ${res.where((RaidJoinResult e) => e.success).length}",
    );
    print("All join requests completed. Fetching final raid state...");
    final DocumentSnapshot<Map<String, dynamic>> finalSnap = await doc.get();
    print("Final raid document data: ${finalSnap.data()}");
    final WorldBossModel updatedModel = WorldBossModel.fromJson(
      finalSnap.data()!,
    );
    if (updatedModel.joinedCount == 15) {
      print("✅ Test passed: Joined count is correctly capped at capacity.");
    } else {
      print(
        "❌ Test failed: Joined count is ${updatedModel.joinedCount}, expected 15.",
      );
    }
  }
}
