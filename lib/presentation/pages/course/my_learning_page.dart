import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/order/order_bloc.dart';
import '../../../l10n/app_localizations.dart';
import 'course_detail_page.dart';
import '../../../domain/entities/course_entity.dart';
import '../../../injection_container.dart';
import '../../../domain/usecases/course/get_course_by_id_usecase.dart';

class MyLearningPage extends StatefulWidget {
  const MyLearningPage({super.key});

  @override
  State<MyLearningPage> createState() => _MyLearningPageState();
}

class _MyLearningPageState extends State<MyLearningPage> {
  @override
  void initState() {
    super.initState();
    final authState = context.read<AuthBloc>().state;
    if (authState is Authenticated) {
      context.read<OrderBloc>().add(GetMyOrdersEvent(authState.user.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          if (state is OrderLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is OrderError) {
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
          } else if (state is OrdersLoaded) {
            final purchasedOrders = state.orders
                .where((order) => order.status == 'completed')
                .toList();

            if (purchasedOrders.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.school_outlined,
                      size: 80,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      l10n.noPurchasedCourses,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n.startLearning,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: purchasedOrders.length,
              itemBuilder: (context, index) {
                final order = purchasedOrders[index];

                return _PurchasedCourseCard(
                  courseId: order.courseId,
                  courseName: order.courseName,
                  amount: order.amount,
                );
              },
            );
          }
          return Center(child: Text(l10n.loadingCourses));
        },
      ),
    );
  }
}

class _PurchasedCourseCard extends StatelessWidget {
  final String courseId;
  final String courseName;
  final double amount;

  const _PurchasedCourseCard({
    required this.courseId,
    required this.courseName,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final getCourseByIdUseCase = sl<GetCourseByIdUseCase>();

    return FutureBuilder<CourseEntity?>(
      future: _fetchCourseDetails(courseId, getCourseByIdUseCase),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(child: CircularProgressIndicator()),
            ),
          );
        }

        final course = snapshot.data;
        if (course == null) {
          // Course might have been deleted, show basic info
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            elevation: 2,
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.error_outline,
                  size: 30,
                  color: Colors.grey,
                ),
              ),
              title: Text(
                courseName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Text(
                l10n.error,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          );
        }

        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          elevation: 2,
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: course.imageUrl != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      course.imageUrl!,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.book,
                          size: 30,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  )
                : Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.book, size: 30, color: Colors.blue),
                  ),
            title: Text(
              course.title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  'By ${course.teacherName}',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    if (course.youtubeUrl != null &&
                        course.youtubeUrl!.isNotEmpty)
                      const Icon(
                        Icons.video_library,
                        size: 16,
                        color: Colors.red,
                      ),
                    if (course.youtubeUrl != null &&
                        course.youtubeUrl!.isNotEmpty)
                      const SizedBox(width: 4),
                    if (course.pdfUrl != null && course.pdfUrl!.isNotEmpty)
                      const Icon(
                        Icons.picture_as_pdf,
                        size: 16,
                        color: Colors.orange,
                      ),
                    if (course.pdfUrl != null && course.pdfUrl!.isNotEmpty)
                      const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        l10n.completed,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.play_circle_filled),
              color: Colors.blue,
              iconSize: 40,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        CourseDetailPage(course: course, isPurchased: true),
                  ),
                );
              },
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      CourseDetailPage(course: course, isPurchased: true),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Future<CourseEntity?> _fetchCourseDetails(
    String courseId,
    GetCourseByIdUseCase useCase,
  ) async {
    final result = await useCase(courseId);
    return result.fold((_) => null, (course) => course);
  }
}
