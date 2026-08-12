import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:seers_assignment/features/home/data/models/guide_model.dart';

abstract interface class HomeLocalDataSource {
  Future<void> cacheGuides(List<GuideModel> guides);
  Future<List<GuideModel>> getCachedGuides();
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  final SharedPreferences _preferences;

  HomeLocalDataSourceImpl({required this._preferences});

  @override
  Future<void> cacheGuides(List<GuideModel> guides) {
    final List<Map<String, dynamic>> data = guides
        .map((guide) => guide.toJson())
        .toList();

    return _preferences.setString("CACHED_GUIDES", json.encode(data));
  }

  @override
  Future<List<GuideModel>> getCachedGuides() async {
    final data = _preferences.getString("CACHED_GUIDES");

    if (data != null) {
      final List<dynamic> decodedData = json.decode(data);
      final guides = decodedData
          .map((guide) => GuideModel.fromJson(guide as Map<String, dynamic>))
          .toList();
      return guides;
    } else {
      return [];
    }
  }
}
