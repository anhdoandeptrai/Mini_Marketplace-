import 'package:dartz/dartz.dart';
import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../domain/entities/course_entity.dart';
import '../../domain/repositories/course_repository.dart';
import '../datasources/course_remote_datasource.dart';

class CourseRepositoryImpl implements CourseRepository {
  final CourseRemoteDataSource remoteDataSource;

  CourseRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<CourseEntity>>> getCourses() async {
    try {
      final courses = await remoteDataSource.getCourses();
      return Right(courses);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CourseEntity>> getCourseById(String courseId) async {
    try {
      final course = await remoteDataSource.getCourseById(courseId);
      return Right(course);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CourseEntity>> createCourse(
    String title,
    String description,
    double price,
    List<String> tags,
    String? imagePath,
    String? youtubeUrl,
    String? pdfUrl,
  ) async {
    try {
      final course = await remoteDataSource.createCourse(
        title,
        description,
        price,
        tags,
        imagePath,
        youtubeUrl,
        pdfUrl,
      );
      return Right(course);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CourseEntity>>> getMyCourses(
    String userId,
  ) async {
    try {
      final courses = await remoteDataSource.getMyCourses(userId);
      return Right(courses);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> toggleCourseStatus(
    String courseId,
    bool isActive,
  ) async {
    try {
      await remoteDataSource.toggleCourseStatus(courseId, isActive);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CourseEntity>> updateCourse(
    String courseId,
    String title,
    String description,
    double price,
    List<String> tags,
    String? imagePath,
    String? youtubeUrl,
    String? pdfUrl,
  ) async {
    try {
      final course = await remoteDataSource.updateCourse(
        courseId,
        title,
        description,
        price,
        tags,
        imagePath,
        youtubeUrl,
        pdfUrl,
      );
      return Right(course);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteCourse(String courseId) async {
    try {
      await remoteDataSource.deleteCourse(courseId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
