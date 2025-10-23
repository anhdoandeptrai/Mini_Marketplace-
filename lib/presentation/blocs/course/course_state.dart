part of 'course_bloc.dart';

abstract class CourseState extends Equatable {
  const CourseState();

  @override
  List<Object> get props => [];
}

class CourseInitial extends CourseState {}

class CourseLoading extends CourseState {}

class CourseLoaded extends CourseState {
  final List<CourseEntity> courses;

  const CourseLoaded(this.courses);

  @override
  List<Object> get props => [courses];
}

class CourseCreated extends CourseState {
  final CourseEntity course;

  const CourseCreated(this.course);

  @override
  List<Object> get props => [course];
}

class CourseError extends CourseState {
  final String message;

  const CourseError(this.message);

  @override
  List<Object> get props => [message];
}

class CourseStatusToggled extends CourseState {}

class CourseUpdated extends CourseState {
  final CourseEntity course;

  const CourseUpdated(this.course);

  @override
  List<Object> get props => [course];
}

class CourseDeleted extends CourseState {}
