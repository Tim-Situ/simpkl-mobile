import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:simpkl_mobile/models/notification_model.dart';
import 'package:simpkl_mobile/database/database_helper.dart';
import 'package:simpkl_mobile/components/bottom_navbar.dart';
import 'package:simpkl_mobile/pages/home_page.dart';
import 'package:simpkl_mobile/pages/jurnal_page.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:simpkl_mobile/pages/login.dart';
import 'package:simpkl_mobile/pages/presence_page.dart';
import 'package:simpkl_mobile/pages/nilai_akhir.dart';
import 'package:simpkl_mobile/pages/profile.dart';
import 'package:simpkl_mobile/services/auth_service.dart';

// Global notification plugin instance
late FlutterLocalNotificationsPlugin localNotifications;

// Dedicated function to save notification to database
Future<void> saveNotificationToDatabase(String? title, String? body) async {
  if (title != null && body != null) {
    final notification = Notifikasi(
      title: title,
      body: body,
      createdAt: DateTime.now(),
    );
    try {
      await DatabaseHelper().insertNotification(notification);
      print("Notification saved to database: $title");
    } catch (e) {
      print("Error saving notification to database: $e");
    }
  }
}

// Background message handler
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Initialize Firebase first
  await Firebase.initializeApp();
  
  if (message.notification != null) {
    // Save notification to database
    await saveNotificationToDatabase(
      message.notification!.title,
      message.notification!.body
    );
    
    // Initialize local notifications plugin
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = 
      FlutterLocalNotificationsPlugin();
    
    // Initialize settings for Android
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidSettings);
    await flutterLocalNotificationsPlugin.initialize(initSettings);
    
    // Show notification
    const androidDetails = AndroidNotificationDetails(
      'default_channel',
      'Default Notifications',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: true,
    );
    const notificationDetails = NotificationDetails(android: androidDetails);
    
    try {
      await flutterLocalNotificationsPlugin.show(
        DateTime.now().millisecondsSinceEpoch ~/ 1000,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
        payload: message.data['route'] ?? '/home',
      );
      print("Background notification displayed successfully");
    } catch (e) {
      print("Error showing background notification: $e");
    }
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await Firebase.initializeApp();
    await FirebaseMessaging.instance.subscribeToTopic('all-devices');
    // Set background handler before requesting permissions
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    
    // Request permissions early
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    
    await initializeDateFormatting('id_ID', null);
  } catch (e) {
    print("Error initializing app: $e");
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: '/home',
      routes: {
        '/login': (context) => const Login(),
        '/home': (context) => const MyHomePage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final _authService = AuthService();
  String? messageToken = "";

  final List<Widget> _pages = <Widget>[
    const HomePage(),
    const JurnalPage(),
    const PresencePage(),
    const NilaiAkhir(),
    const ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
    _setupNotifications();
  }

  Future<void> _setupNotifications() async {
    try {
      // Setup Local Notifications
      localNotifications = FlutterLocalNotificationsPlugin();
      const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
      const settings = InitializationSettings(android: androidSettings);
      
      // Initialize with notification tap callback
      await localNotifications.initialize(
        settings,
        onDidReceiveNotificationResponse: (NotificationResponse response) {
          print("Notification tapped: ${response.payload}");
        },
      );

      // Setup Firebase Messaging
      final messaging = FirebaseMessaging.instance;
      
      // Get FCM token
      final token = await messaging.getToken();
      if (token != null) {
        setState(() => messageToken = token);
        print("FCM Token: $token");
        
        // Update token in backend if logged in
        if (await _authService.isLoggedIn()) {
          await _authService.setMessageToken(token);
        }
      }

      // Handle foreground messages
      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        if (message.notification != null) {
          // Save to database
          await saveNotificationToDatabase(
            message.notification!.title,
            message.notification!.body
          );
          
          // Show local notification
          const androidDetails = AndroidNotificationDetails(
            'default_channel',
            'Default Notifications',
            importance: Importance.high,
            priority: Priority.high,
            playSound: true,
            enableVibration: true,
            showWhen: true,
          );
          const notificationDetails = NotificationDetails(android: androidDetails);
          
          await localNotifications.show(
            DateTime.now().millisecondsSinceEpoch ~/ 1000,
            message.notification!.title,
            message.notification!.body,
            notificationDetails,
            payload: message.data['route'] ?? '/home',
          );
        }
      });

      // Handle when app is opened from terminated state
      final initialMessage = await messaging.getInitialMessage();
      if (initialMessage != null) {
        _handleNotificationOpen(initialMessage);
      }

      // Handle when app is in background
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        _handleNotificationOpen(message);
      });
    } catch (e) {
      print("Error setting up notifications: $e");
    }
  }

  void _handleNotificationOpen(RemoteMessage message) {
    final String route = message.data['route'] ?? '/home';
  }

  void _checkLoginStatus() async {
    final isLoggedIn = await _authService.isLoggedIn();
    if (!isLoggedIn && mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
      );
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}