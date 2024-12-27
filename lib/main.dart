import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:simpkl_mobile/components/bottom_navbar.dart';
import 'package:simpkl_mobile/pages/home_page.dart';
import 'package:simpkl_mobile/pages/jurnal_page.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:simpkl_mobile/pages/login.dart';
import 'package:simpkl_mobile/pages/presence_page.dart';
import 'package:simpkl_mobile/pages/nilai_akhir.dart';
import 'package:simpkl_mobile/pages/profile.dart';
import 'package:simpkl_mobile/services/auth_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';  // Import Firebase core

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await Firebase.initializeApp();  // Add this line to initialize Firebase
  await initializeDateFormatting('id_ID', null);

  runApp(const MyApp());
}

late FlutterLocalNotificationsPlugin localNotifications;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white, // Set background
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
    _initializeFirebaseMessaging();
    _setupLocalNotifications();
  }

  Future<void> _initializeFirebaseMessaging() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // Dapatkan token perangkat untuk debugging
    String? token = await messaging.getToken();
    if (token != null) {
      setState(() {
        messageToken = token;
      });
      print("FCM Token: $token");

      await messaging.subscribeToTopic('all-devices');
      print("Device subscribed to topic 'all-devices'");
    } else {
      print("FCM Token gagal diperoleh");
    }

    // Tangani pesan masuk saat aplikasi aktif
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        _showNotification(message.notification!.title, message.notification!.body);
      }
    });

    // Tangani pesan masuk saat aplikasi di latar belakang
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.notification != null) {
        _showNotification(message.notification!.title, message.notification!.body);
      }
    });
  }

  void _setupLocalNotifications() {
    localNotifications = FlutterLocalNotificationsPlugin();

    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: androidSettings);

    localNotifications.initialize(settings);
  }

  void _showNotification(String? title, String? body) {
    const androidDetails = AndroidNotificationDetails(
      'default_channel',
      'Default Notifications',
      importance: Importance.high,
    );
    const notificationDetails = NotificationDetails(android: androidDetails);

    localNotifications.show(0, title, body, notificationDetails);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _checkLoginStatus() async {
    final isLoggedIn = await _authService.isLoggedIn();
    if (isLoggedIn) {
      // Inisialisasi Firebase Messaging setelah login
      await _initializeFirebaseMessaging();
      if (messageToken != null) {
        await _authService.setMessageToken(messageToken!);
        print("Token berhasil disimpan ke API");
      }
    } else if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
      );
    }
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
