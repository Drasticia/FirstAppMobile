import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingService {
  // Create instance of all methods
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // Function to initialiaze notifications
  Future<void> initNotifications() async {
    // Request permission for sending notifications
    await _firebaseMessaging.requestPermission();
    // Fetch FCM token for this device
    final FCMToken = await _firebaseMessaging.getToken();
    // Print the token
    print('Token: $FCMToken');
    await FirebaseFirestore.instance.collection('user').add({
      'fcmToken': FCMToken.toString()
    });
  }

  // Function to handle received message
  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    // Navigate to new screen when message is received and user taps notification
  }

  Future initPushNotifications() async {
    // Handle notification if the app was terminated and now opened
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    
    // Attach event listeners for when a notification opens the app
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }

}