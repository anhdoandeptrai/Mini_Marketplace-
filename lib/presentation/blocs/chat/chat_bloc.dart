import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/message_entity.dart';
import '../../../domain/usecases/chat/get_messages_usecase.dart';
import '../../../domain/usecases/chat/send_message_usecase.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final SendMessageUseCase sendMessageUseCase;
  final GetMessagesUseCase getMessagesUseCase;

  ChatBloc({required this.sendMessageUseCase, required this.getMessagesUseCase})
    : super(ChatInitial()) {
    on<SendMessageEvent>(_onSendMessage);
    on<LoadMessagesEvent>(_onLoadMessages);
  }

  Future<void> _onSendMessage(
    SendMessageEvent event,
    Emitter<ChatState> emit,
  ) async {
    final result = await sendMessageUseCase(
      SendMessageParams(
        senderId: event.senderId,
        receiverId: event.receiverId,
        message: event.message,
      ),
    );
    result.fold(
      (failure) => emit(ChatError(failure.message)),
      (_) => {}, // Message sent successfully
    );
  }

  Future<void> _onLoadMessages(
    LoadMessagesEvent event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatLoading());
    await emit.forEach(
      getMessagesUseCase(event.userId, event.otherUserId),
      onData: (result) {
        return result.fold(
          (failure) => ChatError(failure.message),
          (messages) => MessagesLoaded(messages),
        );
      },
    );
  }
}
