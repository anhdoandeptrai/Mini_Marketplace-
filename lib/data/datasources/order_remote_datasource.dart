import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/errors/exceptions.dart';
import '../models/order_model.dart';

abstract class OrderRemoteDataSource {
  Future<OrderModel> createOrder(
    String userId,
    String courseId,
    String courseName,
    double amount,
  );
  Future<List<OrderModel>> getMyOrders(String userId);
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final FirebaseFirestore firestore;

  OrderRemoteDataSourceImpl({required this.firestore});

  @override
  Future<OrderModel> createOrder(
    String userId,
    String courseId,
    String courseName,
    double amount,
  ) async {
    try {
      final orderRef = firestore.collection('orders').doc();
      final orderModel = OrderModel(
        id: orderRef.id,
        userId: userId,
        courseId: courseId,
        courseName: courseName,
        amount: amount,
        status: 'completed', // Auto-complete for demo
        createdAt: DateTime.now(),
      );

      await orderRef.set(orderModel.toJson());

      // Update course enrolled count
      final courseRef = firestore.collection('courses').doc(courseId);
      await courseRef.update({'enrolledCount': FieldValue.increment(1)});

      // Send notification to teacher who created the course
      try {
        // Get course data to find teacher
        final courseDoc = await courseRef.get();
        final teacherId = courseDoc.data()?['teacherId'];

        if (teacherId != null) {
          // Notification removed - no longer needed
          print('ℹ️ Order notification skipped for teacher $teacherId');
        }
      } catch (e) {
        // Don't fail order creation if notification fails
        print('Failed to send notification: $e');
      }

      return orderModel;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<OrderModel>> getMyOrders(String userId) async {
    try {
      final snapshot = await firestore
          .collection('orders')
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => OrderModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
