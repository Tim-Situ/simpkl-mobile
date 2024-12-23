import 'package:flutter/material.dart';

class DataPembimbingPage extends StatelessWidget {
  const DataPembimbingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Data Pembimbing',
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
            const SizedBox(height: 8),
            // Profile Picture
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/img/pembimbing.JPG'),
              ),
            ),

            const SizedBox(height: 20),
            // Data Items
            _buildDataItem(Icons.person, 'Ghaziveda'),
            _buildDataItem(Icons.person_outline, 'Ahmad'),
            _buildDataItem(Icons.credit_card, '1302220011'),
            _buildDataItem(Icons.email, 'mgbelvanaufal@gmail.com'),
            _buildDataItem(Icons.phone, '082295903760'),
            _buildDataItem(Icons.location_on, 'Pesona Bali, Bojongsoang'),
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
