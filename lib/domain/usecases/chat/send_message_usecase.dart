import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../repositories/chat_repository.dart';

class SendMessageUseCase implements UseCase<void, SendMessageParams> {
  final ChatRepository repository;

  SendMessageUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(SendMessageParams params) async {
    return await repository.sendMessage(
      params.senderId,
      params.receiverId,
      params.message,
    );
  }
}

class SendMessageParams {
  final String senderId;
  final String receiverId;
  final String message;

  SendMessageParams({
    required this.senderId,
    required this.receiverId,
    required this.message,
  });
}
