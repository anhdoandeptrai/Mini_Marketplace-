import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  // Initialize notifications
  static Future<void> initialize() async {
    // Request permission for iOS
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    }

    // Initialize local notifications for foreground
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsDarwin,
        );

    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        // Handle notification tap
        print('Notification tapped: ${response.payload}');
      },
    );

    // Create notification channel for Android
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showLocalNotification(message);
    });

    // Handle background messages
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Handle notification tap when app is in background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Notification opened: ${message.notification?.title}');
    });
  }

  // Get FCM token and save to Firestore
  static Future<String?> getToken(String userId) async {
    try {
      print('🔑 Getting FCM token for user: $userId');

      String? token = await _messaging.getToken();

      if (token != null) {
        print('✅ FCM Token received: ${token.substring(0, 20)}...');

        // Save token to user document
        await FirebaseFirestore.instance.collection('users').doc(userId).set({
          'fcmToken': token,
        }, SetOptions(merge: true));

        print('✅ FCM Token saved for user: $userId');
        return token;
      } else {
        print('⚠️ FCM Token is null');
        return null;
      }
    } catch (e) {
      print('❌ Error getting FCM token: $e');
      return null;
    }
  }

  // Show local notification when app is in foreground
  static Future<void> _showLocalNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;

    if (notification != null) {
      await _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'high_importance_channel',
            'High Importance Notifications',
            channelDescription:
                'This channel is used for important notifications.',
            importance: Importance.high,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
            showWhen: true,
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        payload: message.data.toString(),
      );
      print('📱 Local notification shown: ${notification.title}');
    }
  }

  // Send notification to specific user
  static Future<void> sendNotificationToUser({
    required String userId,
    required String title,
    required String body,
    Map<String, dynamic>? data,
  }) async {
    try {
      // Get user's FCM token
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      String? fcmToken = userDoc.get('fcmToken');

      if (fcmToken != null) {
        print(
          '🔑 Found FCM token for user $userId: ${fcmToken.substring(0, 20)}...',
        );

        // Save notification to Firestore for history
        await FirebaseFirestore.instance.collection('notifications').add({
          'userId': userId,
          'title': title,
          'body': body,
          'data': data,
          'read': false,
          'createdAt': FieldValue.serverTimestamp(),
        });

        // ⚠️ IMPORTANT: Cannot send FCM push notification without Cloud Functions
        // This method only shows local notification on current device
        //
        // To send to other devices, you need one of these:
        // 1. Firebase Cloud Functions with Admin SDK (RECOMMENDED)
        // 2. Backend server to call FCM API
        //
        // For now, we'll show local notification if app is open
        await _showLocalNotification(
          RemoteMessage(
            notification: RemoteNotification(
              title: title,
              body: body,
              android: const AndroidNotification(
                channelId: 'high_importance_channel',
              ),
            ),
            data: data ?? {},
          ),
        );

        print('✅ Local notification shown (current device only)');
        print('📌 Title: $title');
        print('💬 Body: $body');
        print('⚠️  To send to other devices, deploy Cloud Functions!');
        print('📖 See CLOUD_FUNCTION_SETUP.md for instructions');
      } else {
        print('⚠️ No FCM token found for user: $userId');
      }
    } catch (e) {
      print('❌ Error sending notification: $e');
    }
  }
}

// Top-level function for background message handling
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling background message: ${message.messageId}');
}
