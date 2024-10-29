import 'package:flutter/material.dart';
import 'package:simpkl_mobile/contstants/colors.dart';
import 'package:simpkl_mobile/pages/logIn.dart';
import 'package:simpkl_mobile/pages/wellcomePage1.dart';

class wellcomePage2 extends StatelessWidget {
  const wellcomePage2({super.key});

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
                  textAlign: TextAlign.center, // Menjaga agar teks rata tengah
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
                          color: SimpklColor.darkRed,
                        ),
                      ),
                    ],
                  ),
                ),

                // Gambar di bawah teks
                Image.asset(
                  'assets/img/bukaTab.png', // Ganti dengan path gambar Anda
                  width: 300, // Sesuaikan ukuran gambar
                  height: 300,
                ), // Jarak antara gambar dan teks di bawahnya

                const SizedBox(height: 20), // Jarak antara gambar dan teks

                // Text di bawah gambar dengan padding dan lebar yang diatur
                Container(
                  width: 400,
                  padding: const EdgeInsets.all(0),
                  child: RichText(
                    textAlign: TextAlign.start, // Teks rata kiri
                    softWrap: true,
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: "Pantau Data", // Teks awal
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: " Kehadiran ",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold, // Membuat teks bold
                            color: SimpklColor.darkBlue,
                          ),
                        ),
                        TextSpan(
                          text: " dan",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500, // Membuat teks bold
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: " Nilai",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500, // Membuat teks bold
                            color: SimpklColor.darkBlue,
                          ),
                        ),
                        TextSpan(
                          text: " Jurnal",
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
                  "Pantau dan Pastikan kehadiranmu selalu tercatat dengan baik. Lihat nilai berdasarkan setiap aspek penilaian",
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
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const WellcomePage1(),
                        ));
                      },
                      child: const Text(
                        "Back",
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
                        color: Colors
                            .deepOrange, // Warna hijau untuk latar belakang
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const logIn(),
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
