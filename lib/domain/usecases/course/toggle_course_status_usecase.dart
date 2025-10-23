import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../repositories/course_repository.dart';

class ToggleCourseStatusUseCase
    implements UseCase<void, ToggleCourseStatusParams> {
  final CourseRepository repository;

  ToggleCourseStatusUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(ToggleCourseStatusParams params) async {
    return await repository.toggleCourseStatus(
      params.courseId,
      params.isActive,
    );
  }
}

class ToggleCourseStatusParams {
  final String courseId;
  final bool isActive;

  ToggleCourseStatusParams({required this.courseId, required this.isActive});
}
