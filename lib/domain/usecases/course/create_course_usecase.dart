import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/course_entity.dart';
import '../../repositories/course_repository.dart';

class CreateCourseUseCase implements UseCase<CourseEntity, CreateCourseParams> {
  final CourseRepository repository;

  CreateCourseUseCase(this.repository);

  @override
  Future<Either<Failure, CourseEntity>> call(CreateCourseParams params) async {
    return await repository.createCourse(
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

class CreateCourseParams {
  final String title;
  final String description;
  final double price;
  final List<String> tags;
  final String? imagePath;
  final String? youtubeUrl;
  final String? pdfUrl;

  CreateCourseParams({
    required this.title,
    required this.description,
    required this.price,
    required this.tags,
    this.imagePath,
    this.youtubeUrl,
    this.pdfUrl,
  });
}
