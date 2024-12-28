import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';
import 'package:simpkl_mobile/core/contstants/colors.dart';
import 'package:simpkl_mobile/database/database_helper.dart';
import 'package:simpkl_mobile/models/profile_model.dart';
import 'package:simpkl_mobile/pages/notifikasi.dart';
import 'package:simpkl_mobile/pages/webview_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:badges/badges.dart' as badges;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _currentLocation = "Loading location...";
  ProfileModel? dataDariDb;
  int notificationCount = 0;

  Future<void> getProfile() async {
    dataDariDb = await DatabaseHelper().getProfile();
    setState(() {});
  }

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

  final List<Map<String, String>> cardData = [
    {
      'imageUrl':
          'https://smktelkom-bdg.sch.id/wp-content/uploads/2024/12/Kunjin-2024.jpg',
      'title': 'Kunjungan Industri Tingkatkan Wawasan Siswa SMK Telkom Bandung',
      'date': '20 November 2024',
    },
    {
      'imageUrl':
          'https://smktelkom-bdg.sch.id/wp-content/uploads/2024/12/Kunjin-2024.jpg',
      'title': 'Kunjungan Industri Tingkatkan Wawasan Siswa SMK Telkom Bandung',
      'date': '20 November 2024',
    },
    {
      'imageUrl':
          'https://smktelkom-bdg.sch.id/wp-content/uploads/2024/12/Kunjin-2024.jpg',
      'title': 'Kunjungan Industri Tingkatkan Wawasan Siswa SMK Telkom Bandung',
      'date': '20 November 2024',
    }
  ];

  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _fetchLocation();
    getProfile();
    getNotificationCount();
  }

  Future<void> getNotificationCount() async {
    int count = await DatabaseHelper().getNotificationCount(); // Ganti dengan method sesuai database Anda
    setState(() {
      notificationCount = count;
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
      // print("Error membuka tautan: $e");
    }
  }

  Future<void> _refreshPage() async {
    // Logika refresh di sini, misalnya memanggil ulang data atau API
    await getProfile();
    await getNotificationCount();
    await _fetchLocation();
  }

  Future<void> _fetchLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _currentLocation = "Location services are disabled.";
        });
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _currentLocation = "Location permissions are denied.";
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _currentLocation =
              "Location permissions are permanently denied. Please enable them in settings.";
        });
        return;
      }

      // Dapatkan lokasi terkini
      LocationSettings locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10, // Optional: Set a distance filter if needed
      );

      Position position = await Geolocator.getCurrentPosition(
        locationSettings: locationSettings,
      );

      // Convert coordinate to address
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];

      setState(() {
        _currentLocation =
            "${place.locality}, ${place.country}"; // Misalnya: Bandung, Indonesia
      });
    } catch (e) {
      setState(() {
        _currentLocation = "Failed to get location: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refreshPage,
          child: SingleChildScrollView(
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
                              style: const TextStyle(fontSize: 15),
                            ),
                            Text(
                              dataDariDb?.nama ?? "Not Found",
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: SimpklColor.darkBlue,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 5),
                              child: Text(
                                _currentLocation,
                                style: const TextStyle(
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
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const NotificationScreen()),
                          );
                        },
                        child: badges.Badge(
                          position: badges.BadgePosition.topEnd(top: -8, end: -8),
                          showBadge: notificationCount > 0,
                          badgeContent: Text(
                            notificationCount.toString(),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 12),
                          ),
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(12)),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color(0xFFD3D1D8).withOpacity(0.3),
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
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                CarouselSlider(
                  options: CarouselOptions(
                    height: 120.0,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: 16 / 9,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration: const Duration(milliseconds: 800),
                    enableInfiniteScroll: true,
                  ),
                  items: imgList.asMap().entries.map((entry) {
                    int index = entry.key;
                    String item = entry.value;
                    return InkWell(
                      onTap: () {
                        _launchURL(linkImg[index]);
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image.network(
                          item,
                          fit: BoxFit.cover,
                          width: 1000.0,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 10.0), // Margin luar card
                  decoration: BoxDecoration(
                      color: Colors.white, // Background putih
                      borderRadius:
                          BorderRadius.circular(8.0), // Sudut melengkung
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3), // Bayangan card
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                      border: const Border(
                          left:
                              BorderSide(width: 6, color: SimpklColor.darkBlue))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Pengumuman",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
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
                            autoPlay: false,
                            enlargeCenterPage: true,
                          ),
                          items: pemberitahuan.map((item) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Text(
                                      item['text'] ?? '',
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                      height:
                                          4.0), // Spasi antara teks dan tanggal
                                  Text(
                                    item['date'] ?? '', // Menampilkan tanggal
                                    style: const TextStyle(
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
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
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
                  physics:
                      const NeverScrollableScrollPhysics(), // Tidak bisa di-scroll
                  childAspectRatio: 0.8,
                  children: [
                    {
                      "icon": Icons.book,
                      "label": "Panduan PKL",
                      "url":
                          "https://drive.google.com/file/d/1Yb_QBedWEVOj7C63uWGkop-P-H0owobY/view?usp=share_link"
                    },
                    {
                      "icon": Icons.report,
                      "label": "Keluhan",
                      "url": "https://forms.gle/XftuJ3St5nJYuHhk8"
                    },
                    {
                      "icon": Icons.calendar_today,
                      "label": "Kalender Akademik",
                      "url":
                          "https://drive.google.com/file/d/1G1qycYmXNn3JxSbaSngRR4W6Wov2bMnm/view?usp=share_link"
                    },
                    {
                      "icon": Icons.poll,
                      "label": "Survey",
                      "url": "https://forms.gle/zeX9F2giRQpyD1dV7"
                    },
                  ].map((feature) {
                    return SizedBox(
                      height: 100,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WebViewPage(
                                    title: feature['label'].toString(),
                                    url: feature['url'].toString())),
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.all(8),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              child: Icon(
                                feature['icon'] as IconData,
                                size: 30,
                                color: SimpklColor.darkYellow,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                feature['label'] as String,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Artikel Terbaru",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15,),
                CarouselSlider(
                  options: CarouselOptions(
                    height: 230,
                    enableInfiniteScroll: false, // Looping
                    viewportFraction: 0.45, // Sesuaikan nilai ini untuk lebar Card
                    padEnds: false,
                  ),
                  items: cardData.map((data) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8), // Jarak antar card
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(1, 0),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Gambar di atas
                          Container(
                            height: 120,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                              image: DecorationImage(
                                image: NetworkImage(data['imageUrl'].toString()),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          // Konten teks di bawah
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data['title'].toString(),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  data['date'].toString(),
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
