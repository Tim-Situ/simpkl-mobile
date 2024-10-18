import 'package:flutter/material.dart';
import 'package:simpkl_mobile/animation.dart';
import 'package:simpkl_mobile/components/BottomNavBar.dart';
import 'package:simpkl_mobile/pages/jurnal_page.dart';
import 'package:intl/date_symbol_data_local.dart';
<<<<<<< HEAD
import 'package:simpkl_mobile/pages/presence_page.dart';
=======
import 'package:simpkl_mobile/pages/logIn.dart';
import 'package:simpkl_mobile/pages/nilaiAkhir.dart';
import 'package:simpkl_mobile/pages/wellcomePage1.dart';
>>>>>>> ae4d3b474b977178bc99c48cb3768497b63fbb98

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
<<<<<<< HEAD
      home: const MyHomePage(),
=======
      home:logIn(),
>>>>>>> ae4d3b474b977178bc99c48cb3768497b63fbb98
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

  final List<Widget> _pages = <Widget>[
<<<<<<< HEAD
    const Center(child: Text('Home Page')),
    const JurnalPage(),
    const PresencePage(),
    const Center(child: Text('Nilai Page')),
    const Center(child: Text('Profile Page')),
=======
    Center(child: Text('Home Page')),
    JurnalPage(),
    Center(child: Text('Kehadiran Page')),
    Center(child: Text('Nilai Page')), NilaiAkhir(),
    Center(child: Text('Profile Page')),
>>>>>>> ae4d3b474b977178bc99c48cb3768497b63fbb98
  ];

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
