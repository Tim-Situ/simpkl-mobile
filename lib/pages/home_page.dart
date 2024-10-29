import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> imgList = [
    'https://fileserver.telkomuniversity.ac.id/mytelu/banners/photo_2022-01-27_10-13-02_1643253212901.jpeg',
    'https://fileserver.telkomuniversity.ac.id/mytelu/banners/banner1_1632211918017_1643253030279.jpeg',
    'https://fileserver.telkomuniversity.ac.id/mytelu/banners/banner2_1643253100022.jpeg',
  ];

  final List<String> linkImg = [
    'https://smb.telkomuniversity.ac.id/cerita-telutizen/pentingnya-pemanfaatan-waktu-luang-mahasiswa-kuliah-produktif-tapi-tetap-asik/',
    'https://smb.telkomuniversity.ac.id/cerita-telutizen/mengapa-memilih-jurusan-perhotelan-5-alasan-dan-peluang-kerja-yang-menjanjikan/',
    'https://smb.telkomuniversity.ac.id/cerita-telutizen/cara-agar-tidak-salah-jurusan-calon-mahasiswa-baru-harus-baca/',
  ];

  DateTime selectedDate = DateTime.now();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _initializeNotification();
  }

  // Fungsi untuk inisialisasi notifikasi
  void _initializeNotification() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings iosInitializationSettings =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        print('Notifikasi diklik: ${response.payload}');
      },
    );
  }

  // Fungsi untuk menampilkan notifikasi
  Future<void> _showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'general_notifications',
      'General Notifications',
      channelDescription: 'Channel untuk notifikasi umum aplikasi',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: DarwinNotificationDetails(),
    );

    await flutterLocalNotificationsPlugin
        .show(
      0,
      'PRAKERAN',
      'Selamat, Jurnal Kamu Diterima Oleh Pembimbing',
      platformChannelSpecifics,
      payload: 'data tambahan',
    )
        .then((_) {
      print("Notifikasi berhasil dikirim");
    }).catchError((error) {
      print("Error saat mengirim notifikasi: $error");
    });
  }

  String getFormattedDate(DateTime date) {
    return DateFormat('dd MMMM yyyy', 'id_ID').format(date);
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          getFormattedDate(selectedDate),
                          style: TextStyle(fontSize: 12),
                        ),
                        const Text(
                          "Haloo, Belvanaufal",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap:
                        _showNotification, // Menampilkan notifikasi saat ikon ditekan
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFD3D1D8).withOpacity(0.3),
                            offset: const Offset(5, 10),
                            blurRadius: 20,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.notifications_none_outlined,
                        color: Colors.black,
                        size: 25,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            CarouselSlider(
              options: CarouselOptions(
                height: 120.0,
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                enableInfiniteScroll: true,
              ),
              items: imgList.asMap().entries.map((entry) {
                int index = entry.key;
                String item = entry.value;
                return InkWell(
                  onTap: () {
                    _launchURL(linkImg[index]);
                  },
                  child: Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.network(
                        item,
                        fit: BoxFit
                            .cover, // Memastikan gambar menutupi seluruh container
                        width: 1000.0,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  border: Border.all(
                    width: 1,
                    color: Colors.red,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFD8D1D1).withOpacity(0.3),
                      offset: const Offset(5, 10),
                      blurRadius: 20,
                    ),
                  ],
                  color: Colors.red.withOpacity(0.4),
                ),
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 53,
                    ),
                    child: Text(
                      "Kamu belum mengumpulkan Jurnal\nuntuk kehadiran Hari ini",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.red,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
