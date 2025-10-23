import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/course_entity.dart';
import '../../repositories/course_repository.dart';

class GetCoursesUseCase implements UseCase<List<CourseEntity>, NoParams> {
  final CourseRepository repository;

  GetCoursesUseCase(this.repository);

  @override
  Future<Either<Failure, List<CourseEntity>>> call(NoParams params) async {
    return await repository.getCourses();
  }
}
