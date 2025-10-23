part of 'course_bloc.dart';

abstract class CourseEvent extends Equatable {
  const CourseEvent();

  @override
  List<Object?> get props => [];
}

class GetCoursesEvent extends CourseEvent {}

class CreateCourseEvent extends CourseEvent {
  final String title;
  final String description;
  final double price;
  final List<String> tags;
  final String? imagePath;
  final String? youtubeUrl;
  final String? pdfUrl;

  const CreateCourseEvent({
    required this.title,
    required this.description,
    required this.price,
    required this.tags,
    this.imagePath,
    this.youtubeUrl,
    this.pdfUrl,
  });

  @override
  List<Object?> get props => [
    title,
    description,
    price,
    tags,
    imagePath,
    youtubeUrl,
    pdfUrl,
  ];
}

class GetMyCoursesEvent extends CourseEvent {
  final String userId;

  const GetMyCoursesEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}

class ToggleCourseStatusEvent extends CourseEvent {
  final String courseId;
  final bool isActive;

  const ToggleCourseStatusEvent({
    required this.courseId,
    required this.isActive,
  });

  @override
  List<Object?> get props => [courseId, isActive];
}

class UpdateCourseEvent extends CourseEvent {
  final String courseId;
  final String title;
  final String description;
  final double price;
  final List<String> tags;
  final String? imagePath;
  final String? youtubeUrl;
  final String? pdfUrl;

  const UpdateCourseEvent({
    required this.courseId,
    required this.title,
    required this.description,
    required this.price,
    required this.tags,
    this.imagePath,
    this.youtubeUrl,
    this.pdfUrl,
  });

  @override
  List<Object?> get props => [
    courseId,
    title,
    description,
    price,
    tags,
    imagePath,
    youtubeUrl,
    pdfUrl,
  ];
}

class DeleteCourseEvent extends CourseEvent {
  final String courseId;

  const DeleteCourseEvent(this.courseId);

  @override
  List<Object?> get props => [courseId];
}
