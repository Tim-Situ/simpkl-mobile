import 'package:flutter/material.dart';
import 'package:simpkl_mobile/models/perusahaan_model.dart';
import 'package:simpkl_mobile/database/database_helper.dart';

class DataPerusahaanPage extends StatefulWidget {
  const DataPerusahaanPage({super.key});

  @override
  DataPerusahaanPageState createState() => DataPerusahaanPageState();
}

class DataPerusahaanPageState extends State<DataPerusahaanPage> {
  PerusahaanModel? dataPerusahaan;

  void getPerusahaan() async {
    dataPerusahaan = await DatabaseHelper().getPerusahaan();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getPerusahaan();
  }

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
            _buildDataItem(Icons.home, dataPerusahaan?.nama_perusahaan ?? "Not"),
            _buildDataItem(Icons.person, dataPerusahaan?.pimpinan ?? "Not"),
            _buildDataItem(Icons.location_on, dataPerusahaan?.alamat ?? "Not Found"),
            _buildDataItem(Icons.call, dataPerusahaan?.no_hp ?? "Not Found"),
            _buildDataItem(Icons.mail, dataPerusahaan?.email ?? "Not Found"),
            _buildDataItem(Icons.web, dataPerusahaan?.website ?? "Not Found"),
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
