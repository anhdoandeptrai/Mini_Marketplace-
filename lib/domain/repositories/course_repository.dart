import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/course_entity.dart';

abstract class CourseRepository {
  Future<Either<Failure, List<CourseEntity>>> getCourses();
  Future<Either<Failure, CourseEntity>> getCourseById(String courseId);
  Future<Either<Failure, CourseEntity>> createCourse(
    String title,
    String description,
    double price,
    List<String> tags,
    String? imagePath,
    String? youtubeUrl,
    String? pdfUrl,
  );
  Future<Either<Failure, List<CourseEntity>>> getMyCourses(String userId);
  Future<Either<Failure, void>> toggleCourseStatus(
    String courseId,
    bool isActive,
  );
  Future<Either<Failure, CourseEntity>> updateCourse(
    String courseId,
    String title,
    String description,
    double price,
    List<String> tags,
    String? imagePath,
    String? youtubeUrl,
    String? pdfUrl,
  );
  Future<Either<Failure, void>> deleteCourse(String courseId);
}
