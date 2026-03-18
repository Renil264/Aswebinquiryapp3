import 'package:antiquewebemquiry/Global/sales.dart';
import 'package:antiquewebemquiry/Global/yearlytotalquantity.dart';
import 'package:antiquewebemquiry/Global/yearlytotalsales.dart';
import 'package:antiquewebemquiry/Services/firebase_options.dart';
import 'package:antiquewebemquiry/Global/username.dart';
import 'package:antiquewebemquiry/Global/vendorid.dart';
import 'package:antiquewebemquiry/app_data.dart';
import 'package:antiquewebemquiry/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io' show Platform;
import 'viewmodel/login_viewmodel.dart';

// ✅ Firebase imports ONLY for Android
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'Services/notification.dart';

// Background message handler - Android only
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  try {
    if (Platform.isAndroid) {
      print('🔔 Background message: ${message.messageId}');
      NotificationService().showNotification(message);
    }
  } catch (e) {
    print('❌ Background handler error: $e');
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Initialize Firebase ONLY on Android
  try {
    if (Platform.isAndroid) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      print('✅ Firebase initialized on Android');
      
      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    }
  } catch (e) {
    print('⚠️ Firebase initialization error: $e');
    // Continue even if Firebase fails - app still works
  }

  // Load user data
  try {
    await Username.loadusername();
    await Vendor.loadVendorId();
    await TotalSales.load();
    await TotalQuantity.load();
    await MonthlyTotalItems.load();
    await DailyTotalItems.load();
    await MonthlyTotalSales.load();
    await DailyTotalSales.load();
    print('✅ User data loaded');
  } catch (e) {
    print('⚠️ Error loading user data: $e');
  }

  runApp(const AntiqueSoftApp());
}

class AntiqueSoftApp extends StatefulWidget {
  const AntiqueSoftApp({super.key});

  @override
  State<AntiqueSoftApp> createState() => _AntiqueSoftAppState();
}

class _AntiqueSoftAppState extends State<AntiqueSoftApp> {
  bool _error = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
  }

  Future<void> _initializeNotifications() async {
    try {
      // ✅ Setup push notifications ONLY on Android
      if (Platform.isAndroid) {
        await _setupAndroidPushNotifications();
        print('✅ Android push notifications ready');
      } else {
        print('ℹ️ iOS detected - Firebase push notifications skipped');
      }

      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      print('⚠️ Notification initialization error: $e');
      // Don't crash - app continues without notifications
      if (mounted) {
        setState(() {
          _error = true;
          _errorMessage = 'Notification setup error (app will still work): $e';
        });
      }
    }
  }

  Future<void> _setupAndroidPushNotifications() async {
    try {
      // Only setup if platform is Android
      if (!Platform.isAndroid) {
        return;
      }

      final messaging = FirebaseMessaging.instance;

      // Request notification permission
      final settings = await messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      print('📱 Android permission status: ${settings.authorizationStatus}');

      // Initialize notification service
      NotificationService notificationService = NotificationService();
      await notificationService.init();
      print('✅ Notification service initialized');

      // Get FCM token
      try {
        String? token = await messaging.getToken();
        if (token != null) {
          print('📲 FCM Token: ${token.substring(0, 30)}...');
        } else {
          print('⚠️ FCM Token is null');
        }
      } catch (e) {
        print('⚠️ Failed to get FCM token: $e');
      }

      // Listen for foreground messages
      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        try {
          print('📬 Foreground message: ${message.notification?.title}');
          if (message.notification != null) {
            await notificationService.showNotification(message);
          }
        } catch (e) {
          print('⚠️ Failed to show notification: $e');
        }
      });

      // Listen for message tap (app in background)
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        try {
          print('👆 App opened from notification: ${message.notification?.title}');
        } catch (e) {
          print('⚠️ Error handling notification tap: $e');
        }
      });

      // Check if app was launched from notification
      try {
        RemoteMessage? initialMessage = await messaging.getInitialMessage();
        if (initialMessage != null) {
          print('🚀 App launched from notification');
        }
      } catch (e) {
        print('⚠️ Error checking initial message: $e');
      }
    } catch (e) {
      print('❌ Android push notification setup failed: $e');
      // Don't throw - let app continue
    }
  }

  @override
  Widget build(BuildContext context) {
    // Only show error if it's critical
    if (_error && _errorMessage.contains('critical')) {
      return MaterialApp(
        title: 'AntiqueSoft',
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 64),
                  const SizedBox(height: 16),
                  const Text(
                    'Error',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.red),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _errorMessage,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _error = false;
                        _errorMessage = '';
                      });
                      _initializeNotifications();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    // Normal app
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => AppData()),
      ],
      child: MaterialApp(
        title: 'AntiqueSoft',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF172B4D)),
          useMaterial3: true,
          textTheme: const TextTheme(
            bodyLarge: TextStyle(fontFamily: 'DM Sans'),
            bodyMedium: TextStyle(fontFamily: 'DM Sans'),
            displayLarge: TextStyle(fontFamily: 'DM Sans', fontWeight: FontWeight.bold),
            displayMedium: TextStyle(fontFamily: 'DM Sans', fontStyle: FontStyle.italic),
            displaySmall: TextStyle(fontFamily: 'DM Sans', fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
          ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}