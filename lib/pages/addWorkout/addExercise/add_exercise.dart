import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_log/components/button.dart';
import 'package:gym_log/components/input.dart';
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
  bool isCustomExercise = false;
  String exerciseName = '';
  int seriesCount = 0;
  int repetitionsCount = 0;

  final TextEditingController _seriesCountController = TextEditingController();
  final TextEditingController _repetitionsCountController =
      TextEditingController();
  final TextEditingController _exerciseNameController = TextEditingController();
  String? _validateExerciseName(String? value) {
    if (value == null || value.isEmpty) {
      return 'A nome é obrigatório';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90.0.w,
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: const Color(0xFF212429),
      ),
      child: Form(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.red,
                      size: 30.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
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
              Expanded(
                  child: ListView(
                children: [
                  const SizedBox(
                    height: 5.0,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 8.0),
                      child: Column(
                        children: [
                          Text(
                            "Grupo muscular:",
                            style: GoogleFonts.plusJakartaSans(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          DropdownMenu(
                            initialSelection: menuOptions.first,
                            textStyle: const TextStyle(color: Colors.white),
                            onSelected: (String? value) {
                              setState(() {
                                valueSelected = value!;
                              });
                            },
                            dropdownMenuEntries: menuOptions
                                .map<DropdownMenuEntry<String>>((String value) {
                              return DropdownMenuEntry(
                                  value: value, label: value);
                            }).toList(),
                          ),
                        ],
                      )),
                  if (!isCustomExercise) ...[
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
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                      ),
                      child: SizedBox(
                        height: 15.0.h,
                        width: 60.0.w,
                        child: ListView(
                          padding:
                              const EdgeInsets.only(top: 10.0, bottom: 10.0),
                          children: [
                            Text(
                              'Supino reto',
                              style: GoogleFonts.plusJakartaSans(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const Divider(
                              color: Colors.grey,
                            ),
                            Text(
                              'Supino Inclinado',
                              style: GoogleFonts.plusJakartaSans(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const Divider(
                              color: Colors.grey,
                            ),
                            Text(
                              'Voador Peitoral',
                              style: GoogleFonts.plusJakartaSans(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const Divider(
                              color: Colors.grey,
                            ),
                            Text(
                              'Supino reto',
                              style: GoogleFonts.plusJakartaSans(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const Divider(
                              color: Colors.grey,
                            ),
                            Text(
                              'Supino Inclinado',
                              style: GoogleFonts.plusJakartaSans(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const Divider(
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                  ] else ...[
                    CustomTextFormField(
                      placeholder: 'insira um nome para o exercício',
                      title: 'Nome',
                      obscureText: false,
                      controller: _exerciseNameController,
                      validator: _validateExerciseName,
                      width: 280.0,
                    ),
                  ],
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checkbox(
                          value: isCustomExercise,
                          onChanged: (bool? value) {
                            setState(() {
                              isCustomExercise = value!;
                            });
                          }),
                      Text(
                        "Exercício personalizado",
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomTextFormField(
                        type: TextInputType.number,
                        placeholder: '0',
                        title: 'Séries',
                        obscureText: false,
                        controller: _seriesCountController,
                        validator: _validateExerciseName,
                        width: 100.0,
                      ),
                      CustomTextFormField(
                        type: TextInputType.number,
                        placeholder: '0',
                        title: 'Repetições',
                        obscureText: false,
                        controller: _repetitionsCountController,
                        validator: _validateExerciseName,
                        width: 120.0,
                      ),
                    ],
                  ),
                ],
              )),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Text(
                  'Adicionar exercício: Supino Reto 3x15 ?',
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Button(
                onPressed: () => {Navigator.pop(context)},
                bgColor: 0xFF617AFA,
                textColor: 0xFFFFFFFF,
                borderColor: 0xFF617AFA,
                height: 50,
                width: 240,
                label: 'Adicionar',
              )
            ],
          ),
        ),
      ),
    );
  }
}
