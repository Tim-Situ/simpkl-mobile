import 'package:flutter/material.dart';
import 'package:simpkl_mobile/models/profile_model.dart';
import 'package:simpkl_mobile/database/database_helper.dart';

class DataSiswaPage extends StatefulWidget {
  const DataSiswaPage({super.key});

  @override
  _DataSiswaPageState createState() => _DataSiswaPageState();
}

class _DataSiswaPageState extends State<DataSiswaPage> {
  ProfileModel? dataDariDb;

  @override
  void initState() {
    super.initState();
    getProfile();
  }

  void getProfile() async {
    dataDariDb = await DatabaseHelper().getProfile();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Data Siswa',
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
                backgroundImage: AssetImage('assets/img/profile.jpg'),
              ),
            ),

            const SizedBox(height: 20),
            // Data Items
            _buildDataItem(Icons.credit_card, dataDariDb!.nisn),
            _buildDataItem(Icons.person, dataDariDb!.nama),
            _buildDataItem(Icons.mail, dataDariDb!.alamat),
            _buildDataItem(Icons.call, dataDariDb!.no_hp),
            _buildDataItem(Icons.place, dataDariDb!.tempat_lahir),
            _buildDataItem(Icons.date_range, dataDariDb!.tanggal_lahir.toString()),
            _buildDataItem(Icons.school, dataDariDb!.jurusan),
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
