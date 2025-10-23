part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class CreateOrderEvent extends OrderEvent {
  final String userId;
  final String courseId;
  final String courseName;
  final double amount;

  const CreateOrderEvent({
    required this.userId,
    required this.courseId,
    required this.courseName,
    required this.amount,
  });

  @override
  List<Object> get props => [userId, courseId, courseName, amount];
}

class GetMyOrdersEvent extends OrderEvent {
  final String userId;

  const GetMyOrdersEvent(this.userId);

  @override
  List<Object> get props => [userId];
}
