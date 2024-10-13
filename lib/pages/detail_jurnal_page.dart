import 'package:flutter/material.dart';

class DetailJurnalPage extends StatefulWidget {
  const DetailJurnalPage({super.key});

  @override
  State<StatefulWidget> createState() => _DetailJurnalPageState();
}

class _DetailJurnalPageState extends State<DetailJurnalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Jurnal"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  // width: ,
                  )
            ],
          ),
        ),
      ),
    );
  }
}
