import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';
import 'package:simpkl_mobile/core/contstants/colors.dart';
import 'package:simpkl_mobile/database/database_helper.dart';
import 'package:simpkl_mobile/models/artikel_model.dart';
import 'package:simpkl_mobile/models/banner_model.dart';
import 'package:simpkl_mobile/models/pengumuman_model.dart';
import 'package:simpkl_mobile/models/profile_model.dart';
import 'package:simpkl_mobile/pages/notifikasi.dart';
import 'package:simpkl_mobile/pages/webview_page.dart';
import 'package:simpkl_mobile/services/artikel_service.dart';
import 'package:simpkl_mobile/services/banner_service.dart';
import 'package:simpkl_mobile/services/pengumuman_service.dart';
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
  bool isLoading = true;

  List<BannerModel> resultsBanner = [];
  List<PengumumanModel> resultsPengumuman = [];
  List<ArtikelModel> resultsArtikel = [];

  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _fetchLocation();
    getProfile();
    getNotificationCount();
    getdataBanner();
    getdataPengumuman();
    getdataArtikel();
  }

  Future<void> getdataBanner() async {
    try {
      final fetchedData = await BannerService().fetchBanner();
      setState(() {
        resultsBanner = fetchedData;
        isLoading = false;
      });
    } catch (e) {
      // print("Error fetching data: $e");
    }
  }

  Future<void> getdataPengumuman() async {
    try {
      final fetchedData = await PengumumanService().fetchPengumuman();
      setState(() {
        resultsPengumuman = fetchedData;
        isLoading = false;
      });
    } catch (e) {
      // print("Error fetching data: $e");
    }
  }

  Future<void> getdataArtikel() async {
    try {
      final fetchedData = await ArtikelService().fetchArtikel();
      setState(() {
        resultsArtikel = fetchedData;
        isLoading = false;
      });
    } catch (e) {
      // print("Error fetching data: $e");
    }
  }

  Future<void> getProfile() async {
    dataDariDb = await DatabaseHelper().getProfile();
    setState(() {
      isLoading = false;
    });
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
      if (mounted) {
        setState(() {
          _currentLocation = "Location services are disabled.";
        });
      }
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (mounted) {
          setState(() {
            _currentLocation = "Location permissions are denied.";
          });
        }
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      if (mounted) {
        setState(() {
          _currentLocation =
              "Location permissions are permanently denied. Please enable them in settings.";
        });
      }
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

    if (mounted) {
      setState(() {
        _currentLocation =
            "${place.locality}, ${place.country}"; // Misalnya: Bandung, Indonesia
      });
    }
  } catch (e) {
    if (mounted) {
      setState(() {
        _currentLocation = "Failed to get location: $e";
      });
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
        ? Center(
            child: CircularProgressIndicator(), // Menampilkan animasi loading
          )
        : SafeArea(
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
                    items: resultsBanner.map((banner) {
                      return InkWell(
                        onTap: () {
                          _launchURL(banner.link);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.network(
                            banner.gambar,
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
                          items: resultsPengumuman.map((item) {
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
                                      item.pengumuman.toString(),
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
                                    item.createdAt != null
                                        ? DateFormat('dd/MM/yyyy').format(DateTime.tryParse(item.createdAt.toString()) ?? DateTime.now())
                                        : 'Tanggal tidak tersedia',
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
                  items: resultsArtikel.map((data) {
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
                          Container(
                            height: 120,
                            child: InkWell(
                            onTap: () {
                              _launchURL(data.link);
                            },
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15.0),    
                                topRight: Radius.circular(15.0),   
                                bottomLeft: Radius.circular(0.0), 
                                bottomRight: Radius.circular(0.0), 
                              ),
                              child: Image.network(
                                data.thumbnail,
                                fit: BoxFit.cover,
                                width: 1000.0,
                              ),
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
                                  data.judul.toString(),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  data.createdAt != null
                                    ? DateFormat('dd/MM/yyyy').format(DateTime.tryParse(data.createdAt.toString()) ?? DateTime.now())
                                    : 'Tanggal tidak tersedia',
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
