import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/course/course_bloc.dart';
import 'create_course_page.dart';
import 'edit_course_page.dart';
import '../../../l10n/app_localizations.dart';

class MyCoursesPage extends StatefulWidget {
  const MyCoursesPage({super.key});

  @override
  State<MyCoursesPage> createState() => _MyCoursesPageState();
}

class _MyCoursesPageState extends State<MyCoursesPage> {
  @override
  void initState() {
    super.initState();
    final authState = context.read<AuthBloc>().state;
    if (authState is Authenticated) {
      context.read<CourseBloc>().add(GetMyCoursesEvent(authState.user.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: BlocConsumer<CourseBloc, CourseState>(
        listener: (context, state) {
          if (state is CourseStatusToggled) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(l10n.courseStatusUpdated)));
            // Reload courses
            final authState = context.read<AuthBloc>().state;
            if (authState is Authenticated) {
              context.read<CourseBloc>().add(
                GetMyCoursesEvent(authState.user.id),
              );
            }
          } else if (state is CourseUpdated) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(l10n.courseUpdated)));
            // Reload courses
            final authState = context.read<AuthBloc>().state;
            if (authState is Authenticated) {
              context.read<CourseBloc>().add(
                GetMyCoursesEvent(authState.user.id),
              );
            }
          } else if (state is CourseDeleted) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(l10n.courseDeleted)));
            // Reload courses
            final authState = context.read<AuthBloc>().state;
            if (authState is Authenticated) {
              context.read<CourseBloc>().add(
                GetMyCoursesEvent(authState.user.id),
              );
            }
          }
        },
        builder: (context, state) {
          if (state is CourseLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CourseError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '${l10n.error}: ${state.message}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is CourseLoaded) {
            if (state.courses.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.book_outlined,
                      size: 80,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      l10n.noCourses,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n.createFirstCourse,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.courses.length,
              itemBuilder: (context, index) {
                final course = state.courses[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  elevation: 2,
                  child: Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: course.isActive
                              ? Colors.green
                              : Colors.grey,
                          child: Icon(
                            course.isActive ? Icons.check_circle : Icons.lock,
                            color: Colors.white,
                          ),
                        ),
                        title: Text(
                          course.title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 4),
                            Text(
                              '${course.price.toStringAsFixed(0)} VNĐ • ${course.enrolledCount} ${l10n.students}',
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: course.isActive
                                    ? Colors.green.withOpacity(0.1)
                                    : Colors.grey.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                course.isActive ? l10n.active : l10n.locked,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: course.isActive
                                      ? Colors.green
                                      : Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          EditCoursePage(course: course),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.edit, size: 18),
                                label: Text(l10n.edit),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.blue,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () {
                                  _showToggleDialog(
                                    context,
                                    course.id,
                                    course.isActive,
                                    course.title,
                                  );
                                },
                                icon: Icon(
                                  course.isActive
                                      ? Icons.lock_open
                                      : Icons.lock,
                                  size: 18,
                                ),
                                label: Text(
                                  course.isActive ? l10n.lock : l10n.unlock,
                                ),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: course.isActive
                                      ? Colors.grey
                                      : Colors.green,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () {
                                  _showDeleteDialog(
                                    context,
                                    course.id,
                                    course.title,
                                  );
                                },
                                icon: const Icon(Icons.delete, size: 18),
                                label: Text(l10n.delete),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
          return const Center(child: Text('Đang tải khóa học của bạn'));
        },
      ),
      floatingActionButton: Builder(
        builder: (context) {
          final l10n = AppLocalizations.of(context)!;
          return FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CreateCoursePage()),
              ).then((_) {
                final authState = context.read<AuthBloc>().state;
                if (authState is Authenticated) {
                  context.read<CourseBloc>().add(
                    GetMyCoursesEvent(authState.user.id),
                  );
                }
              });
            },
            icon: const Icon(Icons.add),
            label: Text(l10n.createCourse),
          );
        },
      ),
    );
  }

  void _showToggleDialog(
    BuildContext context,
    String courseId,
    bool currentStatus,
    String courseTitle,
  ) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          currentStatus ? l10n.lockCourseConfirm : l10n.unlockCourseConfirm,
        ),
        content: Text(
          currentStatus ? l10n.studentsCannotAccess : l10n.studentsCanAccess,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.read<CourseBloc>().add(
                ToggleCourseStatusEvent(
                  courseId: courseId,
                  isActive: !currentStatus,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: currentStatus ? Colors.grey : Colors.green,
            ),
            child: Text(currentStatus ? l10n.lock : l10n.unlock),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(
    BuildContext context,
    String courseId,
    String courseTitle,
  ) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.confirmDelete),
        content: Text(l10n.confirmDeleteCourse),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.read<CourseBloc>().add(DeleteCourseEvent(courseId));
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text(l10n.delete),
          ),
        ],
      ),
    );
  }
}
