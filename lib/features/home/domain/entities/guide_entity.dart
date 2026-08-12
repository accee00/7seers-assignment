import 'package:equatable/equatable.dart';

class GuideEntity extends Equatable {
  final String id;
  final String title;
  final String subtitle;
  final String content;
  final String imageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int readtime;

  const GuideEntity({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.content,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.readtime,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    subtitle,
    content,
    imageUrl,
    createdAt,
    updatedAt,
    readtime,
  ];
}
