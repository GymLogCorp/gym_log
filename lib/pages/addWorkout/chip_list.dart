import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChipList extends StatefulWidget {
  const ChipList({super.key});

  @override
  State<ChipList> createState() => _ChipListState();
}

class _ChipListState extends State<ChipList> {
  List<String> groupMuscleList = [
    "Peito",
    "Costas",
    "Abdómen",
    "Pernas",
    "Panturrilha",
    "Braço",
    "Ombro"
  ];

  List<String> filter = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Text(
                'Grupos',
                style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 10.0,
        ),
        Wrap(
            spacing: 5.0,
            children: groupMuscleList.map((group) {
              return FilterChip(
                  label: Text(group),
                  selected: filter.contains(group),
                  onSelected: (bool selected) {
                    setState(() {
                      if (selected) {
                        filter.add(group);
                      } else {
                        filter.remove(group);
                      }
                    });
                  });
            }).toList())
      ],
    );
  }
}
