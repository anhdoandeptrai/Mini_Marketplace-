part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class SendMessageEvent extends ChatEvent {
  final String senderId;
  final String receiverId;
  final String message;

  const SendMessageEvent({
    required this.senderId,
    required this.receiverId,
    required this.message,
  });

  @override
  List<Object> get props => [senderId, receiverId, message];
}

class LoadMessagesEvent extends ChatEvent {
  final String userId;
  final String otherUserId;

  const LoadMessagesEvent({required this.userId, required this.otherUserId});

  @override
  List<Object> get props => [userId, otherUserId];
}
