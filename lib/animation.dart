import 'package:flutter/material.dart';
import 'package:simpkl_mobile/contstants/colors.dart';
import 'package:simpkl_mobile/pages/wellcomePage1.dart';

class animation extends StatefulWidget {
  const animation({super.key});

  @override
_AnimationScreenState createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<animation> {
  @override
  void initState() {
    super.initState();

    // Menunda navigasi ke halaman berikutnya selama 3 detik
    Future.delayed(const Duration(seconds: 3), () {
      // Pindah ke halaman selanjutnya dengan animasi fade
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const WellcomePage1(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = 0.0;
            const end = 1.0;
            const curve = Curves.easeInOut;

            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return FadeTransition(
              opacity: animation.drive(tween),
              child: child,
            );
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Gambar di tengah
              Image.asset(
                'assets/img/logoPrakeran.png', // Ganti dengan path gambar Anda
                width: 185,
                height: 185,
              ),
              const SizedBox(height: 20), // Jarak antara gambar dan teks

              // Tulisan "PRA" dan "KERAN"
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: "PRA", // Teks "PRA"
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold, // Font tebal
                        color: SimpklColor.darkBlue, // Warna biru
                      ),
                    ),
                    TextSpan(
                      text: "KERAN", // Teks "KERAN"
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold, // Font tebal
                        color: Colors.deepOrange, // Warna orange
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 2), // Jarak antara dua baris teks

              // Tulisan "Praktik Kerja Lapangan" dengan warna biru
              const Text(
                "Praktik Kerja Lapangan",
                style: TextStyle(
                  fontSize: 20,
                  color: SimpklColor.darkBlue, 
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}