import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seers_assignment/features/home/domain/entities/guide_entity.dart';

class GuideModel extends GuideEntity {
  const GuideModel({
    required super.id,
    required super.title,
    required super.subtitle,
    required super.content,
    required super.imageUrl,
    required super.createdAt,
    required super.updatedAt,
    required super.readtime,
  });

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'subtitle': subtitle,
      'content': content,
      'imageUrl': imageUrl,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'readtime': readtime,
    };
  }

  factory GuideModel.fromJson(Map<String, dynamic> json) {
    return GuideModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      subtitle: json['subtitle'] as String? ?? '',
      content: json['content'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
      createdAt: json['createdAt'] is Timestamp
          ? (json['createdAt'] as Timestamp).toDate()
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] is Timestamp
          ? (json['updatedAt'] as Timestamp).toDate()
          : DateTime.parse(json['updatedAt'] as String),
      readtime: json['readtime'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'content': content,
      'imageUrl': imageUrl,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'readtime': readtime,
    };
  }

  GuideModel copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? content,
    String? imageUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? readtime,
  }) {
    return GuideModel(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      readtime: readtime ?? this.readtime,
    );
  }
}
