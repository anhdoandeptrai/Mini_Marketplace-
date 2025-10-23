import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/order_entity.dart';
import '../../repositories/order_repository.dart';

class CreateOrderUseCase implements UseCase<OrderEntity, CreateOrderParams> {
  final OrderRepository repository;

  CreateOrderUseCase(this.repository);

  @override
  Future<Either<Failure, OrderEntity>> call(CreateOrderParams params) async {
    return await repository.createOrder(
      params.userId,
      params.courseId,
      params.courseName,
      params.amount,
    );
  }
}

class CreateOrderParams {
  final String userId;
  final String courseId;
  final String courseName;
  final double amount;

  CreateOrderParams({
    required this.userId,
    required this.courseId,
    required this.courseName,
    required this.amount,
  });
}
