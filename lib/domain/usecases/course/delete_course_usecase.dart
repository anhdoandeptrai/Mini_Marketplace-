import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../repositories/course_repository.dart';

class DeleteCourseUseCase implements UseCase<void, String> {
  final CourseRepository repository;

  DeleteCourseUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(String courseId) async {
    return await repository.deleteCourse(courseId);
  }
}
