import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class AddExerciseModal extends StatefulWidget {
  const AddExerciseModal({super.key});

  @override
  State<AddExerciseModal> createState() => _AddExerciseModalState();
}

const List<String> menuOptions = <String>[
  'Peito',
  'Costas',
  'Biceps',
  'Triceps',
  'Abdomen',
  'Gluteo',
  'Pernas',
  'Panturrilha'
];

class _AddExerciseModalState extends State<AddExerciseModal> {
  String valueSelected = '';
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90.0.w,
      height: 80.0.h,
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: const Color(0xFF212429),
      ),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Escolha um de nossos exercícios disponíveis ou crie um personalizado.",
                style: GoogleFonts.plusJakartaSans(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Exercícios disponíveis:",
                style: GoogleFonts.plusJakartaSans(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: DropdownMenu(
                initialSelection: menuOptions.first,
                textStyle: const TextStyle(color: Colors.white),
                onSelected: (String? value) {
                  setState(() {
                    valueSelected = value!;
                  });
                },
                dropdownMenuEntries:
                    menuOptions.map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry(value: value, label: value);
                }).toList(),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red),
              ),
              child: SizedBox(
                height: 200.0,
                width: 50.0.w, // Or any appropriate height based on your UI
                child: ListView(
                  children: const [
                    Text(
                      'Supino reto',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text('Supino reto'),
                    Text('Supino reto'),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
