import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/message_entity.dart';

abstract class ChatRepository {
  Future<Either<Failure, void>> sendMessage(
    String senderId,
    String receiverId,
    String message,
  );
  Stream<Either<Failure, List<MessageEntity>>> getMessages(
    String userId,
    String otherUserId,
  );
}
