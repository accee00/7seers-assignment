import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seers_assignment/features/home/data/models/guide_model.dart';

abstract interface class HomeRemoteDataSource {
  Future<List<GuideModel>> getGuides({required int limit, String? lastGuideId});
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final FirebaseFirestore firestore;

  HomeRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<GuideModel>> getGuides({
    required int limit,
    String? lastGuideId,
  }) async {
    try {
      Query query = firestore
          .collection('guides')
          .orderBy('createdAt', descending: true)
          .limit(limit);

      if (lastGuideId != null) {
        final DocumentSnapshot<Map<String, dynamic>> lastDoc = await firestore
            .collection('guides')
            .doc(lastGuideId)
            .get();
        if (lastDoc.exists) {
          query = query.startAfterDocument(lastDoc);
        }
      }

      final QuerySnapshot<Object?> querySnapshot = await query.get();

      return querySnapshot.docs
          .map((doc) => GuideModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch guides: $e');
    }
  }
}
