import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/course_entity.dart';
import '../../repositories/course_repository.dart';

class UpdateCourseUseCase implements UseCase<CourseEntity, UpdateCourseParams> {
  final CourseRepository repository;

  UpdateCourseUseCase(this.repository);

  @override
  Future<Either<Failure, CourseEntity>> call(UpdateCourseParams params) async {
    return await repository.updateCourse(
      params.courseId,
      params.title,
      params.description,
      params.price,
      params.tags,
      params.imagePath,
      params.youtubeUrl,
      params.pdfUrl,
    );
  }
}

class UpdateCourseParams {
  final String courseId;
  final String title;
  final String description;
  final double price;
  final List<String> tags;
  final String? imagePath;
  final String? youtubeUrl;
  final String? pdfUrl;

  UpdateCourseParams({
    required this.courseId,
    required this.title,
    required this.description,
    required this.price,
    required this.tags,
    this.imagePath,
    this.youtubeUrl,
    this.pdfUrl,
  });
}
