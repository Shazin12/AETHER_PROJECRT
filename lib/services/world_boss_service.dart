import 'package:aether_project/core/constant.dart';
import 'package:aether_project/model/world_boss_model/world_boss_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WorldBossService {
  final FirebaseFirestore _firestore;
  WorldBossService(this._firestore);

  Stream<WorldBossModel?> listern() {
    final DocumentReference<Map<String, dynamic>> doc = _firestore
        .collection(mainCollection)
        .doc(mainDocID);
    return doc.snapshots().map((DocumentSnapshot<Map<String, dynamic>> e) {
      if (!e.exists) return null;
      return WorldBossModel.fromJson(e.data()!);
    });
  }

  Future<({WorldBossModel? model, String mes})> getWorldBossInfo() async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> res = await _firestore
          .collection(mainCollection)
          .doc(mainDocID)
          .get();

      if (res.data() == null) {
        return (model: null, mes: "World boss info not found");
      }
      return (model: WorldBossModel.fromJson(res.data()!), mes: "Success");
    } catch (e) {
      print("Error fetching world boss info: $e");
      return (model: null, mes: "Error fetching world boss info $e");
    }
  }
}
