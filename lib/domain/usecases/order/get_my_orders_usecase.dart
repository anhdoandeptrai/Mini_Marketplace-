import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/order_entity.dart';
import '../../repositories/order_repository.dart';

class GetMyOrdersUseCase implements UseCase<List<OrderEntity>, String> {
  final OrderRepository repository;

  GetMyOrdersUseCase(this.repository);

  @override
  Future<Either<Failure, List<OrderEntity>>> call(String userId) async {
    return await repository.getMyOrders(userId);
  }
}
