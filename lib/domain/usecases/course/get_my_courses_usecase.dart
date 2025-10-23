import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/course_entity.dart';
import '../../repositories/course_repository.dart';

class GetMyCoursesUseCase implements UseCase<List<CourseEntity>, String> {
  final CourseRepository repository;

  GetMyCoursesUseCase(this.repository);

  @override
  Future<Either<Failure, List<CourseEntity>>> call(String userId) async {
    return await repository.getMyCourses(userId);
  }
}
