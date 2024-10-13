import 'package:flutter/material.dart';

class ResponsiveBoxes extends StatelessWidget {
  const ResponsiveBoxes({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double boxWidth = (constraints.maxWidth - 25) / 4;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildBox('12', 'Hadir', const Color(0xFFD4F9BA), boxWidth),
            buildBox('2', 'Izin', const Color(0xFFF1F87C), boxWidth),
            buildBox('1', 'Sakit', const Color(0xFFCECFF9), boxWidth),
            buildBox('4', 'Alfa', const Color(0xFFFFAB99), boxWidth),
          ],
        );
      },
    );
  }

  Widget buildBox(String number, String label, Color color, double width) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            number,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(178, 0, 0, 0),
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Color.fromARGB(178, 0, 0, 0),
            ),
          ),
        ],
      ),
    );
  }
}
