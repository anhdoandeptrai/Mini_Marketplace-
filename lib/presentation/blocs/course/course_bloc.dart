import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/usecases/usecase.dart';
import '../../../domain/entities/course_entity.dart';
import '../../../domain/usecases/course/create_course_usecase.dart';
import '../../../domain/usecases/course/get_courses_usecase.dart';
import '../../../domain/usecases/course/get_my_courses_usecase.dart';
import '../../../domain/usecases/course/toggle_course_status_usecase.dart';
import '../../../domain/usecases/course/update_course_usecase.dart';
import '../../../domain/usecases/course/delete_course_usecase.dart';

part 'course_event.dart';
part 'course_state.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final GetCoursesUseCase getCoursesUseCase;
  final CreateCourseUseCase createCourseUseCase;
  final GetMyCoursesUseCase getMyCoursesUseCase;
  final ToggleCourseStatusUseCase toggleCourseStatusUseCase;
  final UpdateCourseUseCase updateCourseUseCase;
  final DeleteCourseUseCase deleteCourseUseCase;

  CourseBloc({
    required this.getCoursesUseCase,
    required this.createCourseUseCase,
    required this.getMyCoursesUseCase,
    required this.toggleCourseStatusUseCase,
    required this.updateCourseUseCase,
    required this.deleteCourseUseCase,
  }) : super(CourseInitial()) {
    on<GetCoursesEvent>(_onGetCourses);
    on<CreateCourseEvent>(_onCreateCourse);
    on<GetMyCoursesEvent>(_onGetMyCourses);
    on<ToggleCourseStatusEvent>(_onToggleCourseStatus);
    on<UpdateCourseEvent>(_onUpdateCourse);
    on<DeleteCourseEvent>(_onDeleteCourse);
  }

  Future<void> _onGetCourses(
    GetCoursesEvent event,
    Emitter<CourseState> emit,
  ) async {
    emit(CourseLoading());
    final result = await getCoursesUseCase(NoParams());
    result.fold(
      (failure) => emit(CourseError(failure.message)),
      (courses) => emit(CourseLoaded(courses)),
    );
  }

  Future<void> _onCreateCourse(
    CreateCourseEvent event,
    Emitter<CourseState> emit,
  ) async {
    emit(CourseLoading());
    final result = await createCourseUseCase(
      CreateCourseParams(
        title: event.title,
        description: event.description,
        price: event.price,
        tags: event.tags,
        imagePath: event.imagePath,
        youtubeUrl: event.youtubeUrl,
        pdfUrl: event.pdfUrl,
      ),
    );
    result.fold(
      (failure) => emit(CourseError(failure.message)),
      (course) => emit(CourseCreated(course)),
    );
  }

  Future<void> _onGetMyCourses(
    GetMyCoursesEvent event,
    Emitter<CourseState> emit,
  ) async {
    emit(CourseLoading());
    final result = await getMyCoursesUseCase(event.userId);
    result.fold(
      (failure) => emit(CourseError(failure.message)),
      (courses) => emit(CourseLoaded(courses)),
    );
  }

  Future<void> _onToggleCourseStatus(
    ToggleCourseStatusEvent event,
    Emitter<CourseState> emit,
  ) async {
    final result = await toggleCourseStatusUseCase(
      ToggleCourseStatusParams(
        courseId: event.courseId,
        isActive: event.isActive,
      ),
    );
    result.fold(
      (failure) => emit(CourseError(failure.message)),
      (_) => emit(CourseStatusToggled()),
    );
  }

  Future<void> _onUpdateCourse(
    UpdateCourseEvent event,
    Emitter<CourseState> emit,
  ) async {
    emit(CourseLoading());
    final result = await updateCourseUseCase(
      UpdateCourseParams(
        courseId: event.courseId,
        title: event.title,
        description: event.description,
        price: event.price,
        tags: event.tags,
        imagePath: event.imagePath,
        youtubeUrl: event.youtubeUrl,
        pdfUrl: event.pdfUrl,
      ),
    );
    result.fold(
      (failure) => emit(CourseError(failure.message)),
      (course) => emit(CourseUpdated(course)),
    );
  }

  Future<void> _onDeleteCourse(
    DeleteCourseEvent event,
    Emitter<CourseState> emit,
  ) async {
    emit(CourseLoading());
    final result = await deleteCourseUseCase(event.courseId);
    result.fold(
      (failure) => emit(CourseError(failure.message)),
      (_) => emit(CourseDeleted()),
    );
  }
}
