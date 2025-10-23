import 'package:equatable/equatable.dart';

class CourseEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final double price;
  final String teacherId;
  final String teacherName;
  final String? imageUrl;
  final List<String> tags;
  final DateTime createdAt;
  final int enrolledCount;
  final bool isActive;
  final String? youtubeUrl;
  final String? pdfUrl;

  const CourseEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.teacherId,
    required this.teacherName,
    this.imageUrl,
    required this.tags,
    required this.createdAt,
    this.enrolledCount = 0,
    this.isActive = true,
    this.youtubeUrl,
    this.pdfUrl,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    price,
    teacherId,
    teacherName,
    imageUrl,
    tags,
    createdAt,
    enrolledCount,
    isActive,
    youtubeUrl,
    pdfUrl,
  ];
}
