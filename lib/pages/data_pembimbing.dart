import 'package:flutter/material.dart';
import 'package:simpkl_mobile/models/pembimbing_model.dart';
import 'package:simpkl_mobile/database/database_helper.dart';

class DataPembimbingPage extends StatefulWidget {
  const DataPembimbingPage({super.key});

  @override
  DataPembimbingPageState createState() => DataPembimbingPageState();
}

class DataPembimbingPageState extends State<DataPembimbingPage> {
  PembimbingModel? dataPembimbing;

  void getPembimbing() async {
    dataPembimbing = await DatabaseHelper().getPembimbing();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getPembimbing();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDataEmpty = dataPembimbing == null ||
        (dataPembimbing?.nip == null &&
            dataPembimbing?.nama == null &&
            dataPembimbing?.alamat == null &&
            dataPembimbing?.noHp == null);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Data Pembimbing',
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
                    "Data Pembimbing Anda Kosong",
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
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(dataPembimbing?.foto ?? "https://gambarpkl.blob.core.windows.net/gambar-simpkl/1735314679-user-profile.png"),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildDataItem(Icons.credit_card, dataPembimbing?.nip ?? "Not"),
                  _buildDataItem(Icons.person, dataPembimbing?.nama ?? "Not Found"),
                  _buildDataItem(Icons.mail, dataPembimbing?.alamat ?? "Not Found"),
                  _buildDataItem(Icons.call, dataPembimbing?.noHp ?? "Not Found"),
                  _buildDataItem(Icons.power_settings_new_sharp, dataPembimbing?.statusAktif == true ? "Aktif" : "Tidak Aktif"),
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
