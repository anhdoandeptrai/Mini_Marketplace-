import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/course_entity.dart';
import '../../repositories/course_repository.dart';

class GetCourseByIdUseCase implements UseCase<CourseEntity, String> {
  final CourseRepository repository;

  GetCourseByIdUseCase(this.repository);

  @override
  Future<Either<Failure, CourseEntity>> call(String courseId) async {
    return await repository.getCourseById(courseId);
  }
}
