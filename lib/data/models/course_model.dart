import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/course_entity.dart';

class CourseModel extends CourseEntity {
  const CourseModel({
    required super.id,
    required super.title,
    required super.description,
    required super.price,
    required super.teacherId,
    required super.teacherName,
    super.imageUrl,
    required super.tags,
    required super.createdAt,
    super.enrolledCount,
    super.isActive,
    super.youtubeUrl,
    super.pdfUrl,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      teacherId: json['teacherId'] as String,
      teacherName: json['teacherName'] as String,
      imageUrl: json['imageUrl'] as String?,
      tags: List<String>.from(json['tags'] as List),
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      enrolledCount: json['enrolledCount'] as int? ?? 0,
      isActive: json['isActive'] as bool? ?? true,
      youtubeUrl: json['youtubeUrl'] as String?,
      pdfUrl: json['pdfUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'teacherId': teacherId,
      'teacherName': teacherName,
      'imageUrl': imageUrl,
      'tags': tags,
      'createdAt': Timestamp.fromDate(createdAt),
      'enrolledCount': enrolledCount,
      'isActive': isActive,
      'youtubeUrl': youtubeUrl,
      'pdfUrl': pdfUrl,
    };
  }
}
