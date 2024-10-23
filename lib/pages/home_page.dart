import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:simpkl_mobile/contstants/colors.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  final List<String> imgList = [
    'https://fileserver.telkomuniversity.ac.id/mytelu/banners/photo_2022-01-27_10-13-02_1643253212901.jpeg',
    'https://fileserver.telkomuniversity.ac.id/mytelu/banners/banner1_1632211918017_1643253030279.jpeg',
    'https://fileserver.telkomuniversity.ac.id/mytelu/banners/banner2_1643253100022.jpeg',
  ];

  DateTime selectedDate = DateTime.now();

  String getFormattedDate(DateTime date) {
    return DateFormat('dd MMMM yyyy', 'id_ID').format(date);
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
                  Container(
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
              items: imgList.map((item) => Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0), 
                  child: Image.network(
                    item,
                    fit: BoxFit.cover, // Memastikan gambar menutupi seluruh container
                    width: 1000.0,
                  ),
                ),
              )).toList(),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  border: Border.all(
                    width: 1,
                    color: SimpklColor.darkRed
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFD8D1D1).withOpacity(0.3),
                      offset: const Offset(5, 10),
                      blurRadius: 20,
                    ),
                  ],
                  color: SimpklColor.darkRed.withOpacity(0.4),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 53
                    ),
                    child: Text(
                      "Kamu belum mengumpulkan Jurnal\nuntuk kehadiran Hari ini",
                      style: TextStyle(
                        fontSize: 12,
                        color: SimpklColor.darkRed,
                        fontWeight: FontWeight.w500
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