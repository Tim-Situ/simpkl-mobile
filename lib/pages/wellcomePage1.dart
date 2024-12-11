import 'package:flutter/material.dart';
import 'package:simpkl_mobile/core/contstants/colors.dart';
import 'package:simpkl_mobile/pages/wellcomePage2.dart';

class WellcomePage1 extends StatelessWidget {
  const WellcomePage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 30), // Padding untuk seluruh konten
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Teks yang ditengah
                RichText(
                  textAlign:
                      TextAlign.center, // Menjaga agar teks rata tengah
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: "PRA", // Teks awal
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: SimpklColor.darkBlue,
                        ),
                      ),
                      TextSpan(
                        text: "KERAN",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold, // Membuat teks bold
                          color: Colors.deepOrange,
                        ),
                      ),
                    ],
                  ),
                ), // Jarak antara teks dan gambar
      
                // Gambar di bawah teks
                Image.asset(
                  'assets/img/IlustrasiBelajar.png', // Ganti dengan path gambar Anda
                  width: 300, // Sesuaikan ukuran gambar
                  height: 300,
                ), // Jarak antara gambar dan teks di bawahnya
      
                const SizedBox(height: 20), // Jarak antara gambar dan teks
      
                // Text di bawah gambar dengan padding dan lebar yang diatur
                Container(
                  width: 400, // Sesuaikan lebar kontainer
                  padding: const EdgeInsets.all(0), // Padding di sekitar teks
                  child: RichText(
                    textAlign: TextAlign.start, // Teks rata kiri
                    softWrap: true,
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: "Unggah", // Teks awal
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: " Jurnal ",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold, // Membuat teks bold
                            color: SimpklColor.darkYellow,
                          ),
                        ),
                        TextSpan(
                          text: "Harian Praktik Kerjamu",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500, // Membuat teks bold
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10), // Jarak
      
                // Deskripsi tambahan
                const Text(
                  "Unggah jurnal harianmu dengan mudah untuk mendokumentasikan setiap aktivitas yang kamu lakukan selama PKL.",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 16),
                ),
      
                const SizedBox(height: 40), // Jarak sebelum tombol
      
                // Row untuk tombol Back dan panah
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Tombol "Back" di sebelah kiri
                    TextButton(
                      onPressed: () {
                        // Logika ketika tombol Back ditekan
                      },
                      child: const Text(
                        "Skip",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
      
                    // Spacer untuk memberi jarak
                    const Spacer(),
      
                    // Tombol panah di sebelah kanan dengan lingkaran hijau
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: SimpklColor
                            .darkBlue, // Warna hijau untuk latar belakang
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const wellcomePage2(),
                          ));
                        },
                        icon: const Icon(
                          Icons.chevron_right,
                          color: Colors.white, // Warna ikon
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
