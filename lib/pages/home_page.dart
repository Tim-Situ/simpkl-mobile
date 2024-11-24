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

  final List<Map<String, String>> pemberitahuan = [
    {
      'text':
          'Peserta magang harap segera melakukan konfirmasi kepada guru pembimbing terkait perusahaannya.',
      'date': '24 November 2024',
    },
    {
      'text': 'Peserta magang harap segera mengumpulkan laporan mingguan.',
      'date': '23 November 2024',
    },
    {
      'text': 'Jadwal sidang akhir magang akan diumumkan minggu depan.',
      'date': '22 November 2024',
    },
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
    try {
      final Uri uri = Uri.parse(url);
      if (!await launchUrl(uri)) {
        throw Exception('Could not launch $uri');
      }
    } catch (e) {
      print("Error membuka tautan: $e");
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
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          child: Text(
                            "Tokyo, Inazuma No. 21",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
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
            SizedBox(height: 20),
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
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: 15.0, vertical: 10.0), // Margin luar card
              decoration: BoxDecoration(
                color: Colors.white, // Background putih
                borderRadius: BorderRadius.circular(8.0), // Sudut melengkung
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3), // Bayangan card
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 5.0,
                              height: 20.0,
                              color: Colors.blue,
                              margin: EdgeInsets.only(right: 8.0),
                            ),
                            Text(
                              "Pemberitahuan",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.notifications,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.grey.shade300,
                    thickness: 1.0,
                    height: 1.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: 80.0,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        autoPlayInterval: Duration(seconds: 3),
                      ),
                      items: pemberitahuan.map((item) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                item['text'] ??
                                    '', // Menampilkan teks pemberitahuan
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(
                                  height: 4.0), // Spasi antara teks dan tanggal
                              Text(
                                item['date'] ?? '', // Menampilkan tanggal
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Fitur Aplikasi",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            GridView.count(
              crossAxisCount: 4, // 4 kolom
              shrinkWrap: true, // Tidak scroll
              physics: NeverScrollableScrollPhysics(), // Tidak bisa di-scroll
              padding: EdgeInsets.all(16),
              children: [
                {"icon": Icons.book, "label": "Panduan PKL"},
                {"icon": Icons.report, "label": "Keluhan"},
                {"icon": Icons.calendar_today, "label": "Kalender Akademik"},
                {"icon": Icons.poll, "label": "Survey"},
              ].map((feature) {
                return GestureDetector(
                  onTap: () {
                    print("Menu ${feature['label']} ditekan");
                  },
                  child: Container(
                    // margin: EdgeInsets.all(8),
                    // padding: EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(8),
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.grey.shade300,
                              width: 1.0,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                blurRadius: 6,
                                offset: Offset(2, 4),
                              ),
                            ],
                          ),
                          child: Icon(
                            feature['icon'] as IconData,
                            size: 40,
                            color: Colors.blue,
                          ),
                        ),
                        Text(
                          feature['label'] as String,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
