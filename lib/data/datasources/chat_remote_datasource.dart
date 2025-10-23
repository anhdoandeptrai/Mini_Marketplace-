import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/errors/exceptions.dart';
import '../models/message_model.dart';

abstract class ChatRemoteDataSource {
  Future<void> sendMessage(String senderId, String receiverId, String message);
  Stream<List<MessageModel>> getMessages(String userId, String otherUserId);
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final FirebaseFirestore firestore;

  ChatRemoteDataSourceImpl({required this.firestore});

  String _getChatId(String userId1, String userId2) {
    // Always sort to ensure consistent chatId for same 2 users
    return userId1.compareTo(userId2) < 0
        ? '${userId1}_$userId2'
        : '${userId2}_$userId1';
  }

  @override
  Future<void> sendMessage(
    String senderId,
    String receiverId,
    String message,
  ) async {
    try {
      final chatId = _getChatId(senderId, receiverId);
      final timestamp = DateTime.now();

      // Add message to subcollection
      final messageRef = firestore
          .collection('messages')
          .doc(chatId)
          .collection('chats')
          .doc();

      final messageModel = MessageModel(
        id: messageRef.id,
        senderId: senderId,
        receiverId: receiverId,
        message: message,
        timestamp: timestamp,
        isRead: false,
      );

      // Use batch write for atomicity
      final batch = firestore.batch();

      batch.set(messageRef, messageModel.toJson());

      // Update conversation metadata
      final conversationRef = firestore.collection('messages').doc(chatId);
      batch.set(conversationRef, {
        'participants': [senderId, receiverId],
        'lastMessage': message,
        'lastMessageTime': Timestamp.fromDate(timestamp),
        'lastMessageSenderId': senderId,
        'unreadCount_$receiverId': FieldValue.increment(1),
      }, SetOptions(merge: true));

      await batch.commit();

      // Send notification to receiver
      print('🔔 Attempting to send notification to receiver: $receiverId');
      try {
        // Get sender's name from Firestore
        final senderDoc = await firestore
            .collection('users')
            .doc(senderId)
            .get();
        final senderName = senderDoc.data()?['name'] ?? 'Someone';

        print('👤 Sender name: $senderName');
        print('💬 Message: $message');

        // Notification removed - no longer needed
        print('ℹ️ Notification skipped');
      } catch (e) {
        // Don't fail message sending if notification fails
        print('❌ Failed to send notification: $e');
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Stream<List<MessageModel>> getMessages(String userId, String otherUserId) {
    try {
      final chatId = _getChatId(userId, otherUserId);
      return firestore
          .collection('messages')
          .doc(chatId)
          .collection('chats')
          .orderBy('timestamp', descending: false)
          .snapshots()
          .map(
            (snapshot) => snapshot.docs
                .map((doc) => MessageModel.fromJson(doc.data()))
                .toList(),
          );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
