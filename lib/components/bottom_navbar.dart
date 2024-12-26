import 'package:flutter/material.dart';
import 'package:simpkl_mobile/core/contstants/colors.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const BottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    List<IconData> data = [
      Icons.home,
      Icons.insert_drive_file_sharp,
      Icons.groups,
      Icons.assignment_outlined,
      Icons.person,
    ];

    List<String> labels = ["Beranda", "Jurnal", "Presensi", "Nilai", "Profil"];

    return Padding(
      padding: const EdgeInsets.only(bottom: 16, left: 22, right: 22),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.only(bottom: 4, right: 13, left: 13),
        decoration: BoxDecoration(
            color: SimpklColor.darkBlue,
            borderRadius: BorderRadius.circular(45.8),
            boxShadow: const [
              BoxShadow(blurRadius: 2, color: SimpklColor.darkBlue)
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
              data.length,
              (i) => GestureDetector(
                    onTap: () => onItemTapped(i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 10),
                      decoration: BoxDecoration(
                        border: i == selectedIndex
                            ? const Border(
                                top: BorderSide(
                                width: 3.0,
                                color: Colors.white,
                              ))
                            : null,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              data[i],
                              size: 25,
                              color: i == selectedIndex
                                  ? Colors.white
                                  : SimpklColor.softBlue,
                            ),
                            Text(
                              labels[i],
                              style: TextStyle(
                                color: i == selectedIndex
                                    ? Colors.white
                                    : SimpklColor.softBlue,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
        ),
      ),
    );
  }
}
