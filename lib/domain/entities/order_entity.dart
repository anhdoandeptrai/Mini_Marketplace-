import 'package:equatable/equatable.dart';

class OrderEntity extends Equatable {
  final String id;
  final String userId;
  final String courseId;
  final String courseName;
  final double amount;
  final String status; // 'pending', 'completed', 'cancelled'
  final DateTime createdAt;

  const OrderEntity({
    required this.id,
    required this.userId,
    required this.courseId,
    required this.courseName,
    required this.amount,
    required this.status,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
    id,
    userId,
    courseId,
    courseName,
    amount,
    status,
    createdAt,
  ];
}
