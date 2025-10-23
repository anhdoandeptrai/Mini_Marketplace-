import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/order_entity.dart';

abstract class OrderRepository {
  Future<Either<Failure, OrderEntity>> createOrder(
    String userId,
    String courseId,
    String courseName,
    double amount,
  );
  Future<Either<Failure, List<OrderEntity>>> getMyOrders(String userId);
}
