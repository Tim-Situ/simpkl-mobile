import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simpkl_mobile/models/profile_model.dart';
import 'package:simpkl_mobile/database/database_helper.dart';

class DataSiswaPage extends StatefulWidget {
  const DataSiswaPage({super.key});

  @override
  DataSiswaPageState createState() => DataSiswaPageState();
}

class DataSiswaPageState extends State<DataSiswaPage> {
  ProfileModel? dataDariDb;

  void getProfile() async {
    dataDariDb = await DatabaseHelper().getProfile();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getProfile();
  }

  String getFormattedDate(DateTime date) {
    return DateFormat('dd MMMM yyyy', 'id_ID').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final bool isDataEmpty = dataDariDb == null ||
        (dataDariDb?.nisn == null &&
            dataDariDb?.nama == null &&
            dataDariDb?.alamat == null &&
            dataDariDb?.noHp == null &&
            dataDariDb?.jurusan == null);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Data Siswa',
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
      ),
      body: isDataEmpty
        ? Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width * 0.2,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                border: Border.all(
                  width: 1,
                  color: Colors.red,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFD8D1D1).withOpacity(0.3),
                    offset: const Offset(5, 10),
                    blurRadius: 20,
                  ),
                ],
                color: Colors.red.withOpacity(0.4),
              ),
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 53,
                  ),
                  child: Text(
                    "Data Pribadi Anda Kosong",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.red,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          )
          : SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage('assets/img/profile.jpg'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildDataItem(Icons.credit_card, dataDariDb?.nisn ?? "Not Found"),
                  _buildDataItem(Icons.person, dataDariDb?.nama ?? "Not Found"),
                  _buildDataItem(Icons.location_on, dataDariDb?.alamat ?? "Not Found"),
                  _buildDataItem(Icons.call, dataDariDb?.noHp ?? "Not Found"),
                  _buildDataItem(
                      Icons.date_range,
                      dataDariDb?.tanggalLahir != null
                          ? (dataDariDb?.tempatLahir ?? "Not Found") + ", " + getFormattedDate(dataDariDb!.tanggalLahir)
                          : "Not Found"),
                  _buildDataItem(Icons.school, dataDariDb?.jurusan ?? "Not Found"),
                  _buildDataItem(Icons.power_settings_new_sharp,
                      dataDariDb?.statusAktif == true ? "Aktif" : "Tidak Aktif"),
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

