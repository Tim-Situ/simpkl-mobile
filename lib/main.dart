import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:simpkl_mobile/components/BottomNavBar.dart';
import 'package:simpkl_mobile/database/database_helper.dart';
import 'package:simpkl_mobile/models/profile_model.dart';
import 'package:simpkl_mobile/pages/home_page.dart';
import 'package:simpkl_mobile/pages/jurnal_page.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:simpkl_mobile/pages/logIn.dart';
import 'package:simpkl_mobile/pages/presence_page.dart';
import 'package:simpkl_mobile/pages/nilaiAkhir.dart';
import 'package:simpkl_mobile/pages/wellcomePage1.dart';
import 'package:simpkl_mobile/pages/Profile.dart';
import 'package:simpkl_mobile/services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);

  runApp(const MyApp());
}

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
        '/login': (context) => const logIn(),
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

  final List<Widget> _pages = <Widget>[
    HomePage(),
    const JurnalPage(),
    const PresencePage(),
    const NilaiAkhir(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _checkLoginStatus() async {
    final isLoggedIn = await _authService.isLoggedIn();
    if (!isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => logIn()),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
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
