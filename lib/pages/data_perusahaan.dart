import 'package:flutter/material.dart';

class DataPerusahaanPage extends StatelessWidget {
  const DataPerusahaanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Data Perusahaan',
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFD3D1D8).withOpacity(0.3),
                    offset: const Offset(5, 10),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.black,
                size: 16,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Profile Picture
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: 370,
                height: 224,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('assets/img/perusahaan.jpeg'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 20),
            // Data Items
            _buildDataItem(Icons.person, 'IKEA'),
            _buildDataItem(Icons.person_outline, 'Ingvar Kamprad'),
            _buildDataItem(Icons.credit_card, 'ikea.co.id'),
            _buildDataItem(Icons.email, 'IngvarKampradIk@gmail.com'),
            _buildDataItem(Icons.phone, '01288992212'),
            _buildDataItem(Icons.location_on, 'Sukabirus, Bojongsoang'),
          ],
        ),
      ),
    );
  }

  Widget _buildDataItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF0F5FF),
          borderRadius: BorderRadius.circular(50),
        ),
        child: ListTile(
          leading: Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: Color(0xFFCDD9FF),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                icon,
                color: const Color(0xFF2C55D3),
                size: 20,
              ),
            ),
          ),
          title: Text(
            text,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
