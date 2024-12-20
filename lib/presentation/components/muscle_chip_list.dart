import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class ChipList extends StatefulWidget {
  final List<String> filter;
  const ChipList({super.key, required this.filter});

  @override
  State<ChipList> createState() => _ChipListState();
}

class _ChipListState extends State<ChipList> {
  List<String> groupMuscleList = [
    'Peito',
    'Ombro',
    'Costas',
    'Bíceps',
    'Tríceps',
    'Antebraço',
    'Abdomên',
    'Glúteo',
    'Pernas',
    'Panturrilha'
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90.0.w,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
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
              spacing: 10.0,
              alignment: WrapAlignment.start,
              children: groupMuscleList.map((group) {
                return FilterChip(
                    label: Text(group),
                    backgroundColor: const Color(0xFF212429),
                    selectedColor: const Color(0xFF617AFA),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22.0)),
                    checkmarkColor: Colors.white,
                    labelStyle: const TextStyle(color: Colors.white),
                    selected: widget.filter.contains(group),
                    onSelected: (bool selected) {
                      setState(() {
                        if (selected) {
                          widget.filter.add(group);
                        } else {
                          widget.filter.remove(group);
                        }
                      });
                    });
              }).toList())
        ],
      ),
    );
  }
}
