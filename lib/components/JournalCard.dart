import 'package:flutter/material.dart';
import 'package:simpkl_mobile/contstants/colors.dart';

class JournalCard extends StatelessWidget {
  final String title;
  final String status;
  final String timeRange;
  final String date;
  final String typeOfWork;
  final String typeOfActivity;


  const JournalCard({
    super.key, 
    required this.title,
    required this.status,
    required this.timeRange,
    required this.date,
    required this.typeOfWork,
    required this.typeOfActivity
  });

  Color getStatusColor(String status) {
    if (status == "Diterima") {
      return SimpklColor.darkGreen;
    } else if (status == "Ditolak") {
      return SimpklColor.darkRed;
    } else if (status == "Menunggu") {
      return SimpklColor.darkYellow;
    } else {
      return Colors.grey; // Default color
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFD3D1D8).withOpacity(0.3),
            blurRadius: 20,
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(8)
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                    color: getStatusColor(status),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    status,
                    style: const TextStyle(
                      color: Colors.white, 
                      fontSize: 11
                    ),
                  ),
                ),
              ],
            ),
            Text(
              date,
              style: const TextStyle(
                fontSize: 11
              ),
            ),
            Divider(color: getStatusColor(status)),
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),  // Sesuaikan dengan radius yang diinginkan
                  child: Image.network(
                    'https://awsimages.detik.net.id/community/media/visual/2023/05/26/yuk-serbu-ada-pendidikan-dan-pelatihan-kerja-gratis_169.jpeg?w=600&q=90',
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,  // Menjaga agar gambar sesuai dengan kotak
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$typeOfWork | $typeOfActivity',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14
                      )
                    ),
                    Text(
                      timeRange,
                      style: const TextStyle(
                        fontSize: 12 
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}