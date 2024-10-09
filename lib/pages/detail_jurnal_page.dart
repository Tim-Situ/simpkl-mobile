import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simpkl_mobile/contstants/colors.dart';

class DetailJurnalPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DetailJurnalPageState();
}

class _DetailJurnalPageState extends State<DetailJurnalPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detail Jurnal"
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
