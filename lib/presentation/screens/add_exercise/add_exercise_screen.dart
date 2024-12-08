import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_log/data/models/exercise.dart';
import 'package:gym_log/data/repositories/exercise_repository.dart';
import 'package:gym_log/core/widgets/button.dart';
import 'package:gym_log/core/widgets/input.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class AddExerciseModal extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  const AddExerciseModal({super.key, required this.onSubmit});
  @override
  State<AddExerciseModal> createState() => _AddExerciseModalState();
}

const List<String> menuOptions = <String>[
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

class _AddExerciseModalState extends State<AddExerciseModal> {
  final _formKey = GlobalKey<FormState>();
  final _formCustomExerciseKey = GlobalKey<FormState>();

  String muscleSelected = 'Peito';
  bool isCustomExercise = false;
  Map<String, dynamic> exerciseSelected = {'name': '', 'value': null};
  String exerciseName = '';
  int seriesCount = 0;
  int repetitionsCount = 0;

  final TextEditingController _seriesCountController = TextEditingController();
  final TextEditingController _repetitionsCountController =
      TextEditingController();
  final TextEditingController _exerciseNameController = TextEditingController();
  String? _validateInputs(String? value) {
    if (value == null || value.isEmpty) {
      return '';
    }
    return null;
  }

  String? _validateInputName(String? value) {
    if (value == null || value.isEmpty) {
      return '';
    }
    return null;
  }

  late ExerciseRepository exerciseRepository;

  @override
  void initState() {
    super.initState();

    exerciseRepository =
        Provider.of<ExerciseRepository>(context, listen: false);

    exerciseRepository.getExerciseList(muscleSelected);

    _seriesCountController.addListener(() {
      setState(() {
        seriesCount = int.tryParse(_seriesCountController.value.text) ?? 0;
      });
    });
    _repetitionsCountController.addListener(() {
      setState(() {
        repetitionsCount = int.parse(_repetitionsCountController.value.text);
      });
    });
  }

  void addCustomExercise() async {
    var exerciseName = _exerciseNameController.text.trim();
    if (exerciseName.isNotEmpty) {
      await exerciseRepository.createCustomExercise(
          exerciseName, muscleSelected);

      if (mounted) {
        await exerciseRepository.getExerciseList(muscleSelected);
        _exerciseNameController.clear();
      }
    }
  }

  void removeCustomExercise(int id) async {
    await exerciseRepository.deleteCustomExercise(id.toString());
    await exerciseRepository.getExerciseList(muscleSelected);
    setState(() {
      exerciseSelected = {'name': '', 'value': null};
    });
  }

  void handleSubmit(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      widget.onSubmit(
        {
          'id': exerciseSelected['value'],
          'name': exerciseSelected['name'],
          'series': seriesCount,
          'repetitions': repetitionsCount,
          'muscleGroup': muscleSelected,
          'isCustom': isCustomExercise
        },
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0.w,
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: const Color(0xFF212429),
      ),
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
                            onSelected: (String? value) async {
                              setState(() {
                                muscleSelected = value!;
                              });

                              await Provider.of<ExerciseRepository>(context,
                                      listen: false)
                                  .getExerciseList(muscleSelected);
                            },
                            dropdownMenuEntries: menuOptions
                                .map<DropdownMenuEntry<String>>((String value) {
                              return DropdownMenuEntry(
                                  value: value, label: value);
                            }).toList(),
                          ),
                        ],
                      )),
                  if (isCustomExercise) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Form(
                          key: _formCustomExerciseKey,
                          child: CustomTextFormField(
                            placeholder: 'insira um nome para o exercício',
                            title: 'Nome',
                            obscureText: false,
                            controller: _exerciseNameController,
                            validator: _validateInputName,
                            width: 45.0.w,
                          ),
                        ),
                        Button(
                          onPressed: () => {addCustomExercise()},
                          bgColor: 0xFF617AFA,
                          textColor: 0xFFFFFFFF,
                          borderColor: 0xFF617AFA,
                          height: 55,
                          width: 20.0.w,
                          label: '',
                          icon: Icons.plus_one,
                        )
                      ],
                    )
                  ],
                  const SizedBox(
                    height: 8.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      isCustomExercise
                          ? "Exercícios personalizados:"
                          : "Exercícios disponíveis:",
                      style: GoogleFonts.plusJakartaSans(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    child: SizedBox(
                      height: 25.0.h,
                      width: 60.0.w,
                      child: Consumer<ExerciseRepository>(
                        builder: (context, exerciseRepository, child) {
                          List<ExerciseModel> exercises =
                              exerciseRepository.exerciseList;
                          exercises = exercises
                              .where(
                                  (item) => item.isCustom == isCustomExercise)
                              .toList()
                              .reversed
                              .toList();
                          if (exercises.isEmpty) {
                            return Center(
                                child: Text(
                              isCustomExercise
                                  ? 'Nenhum exercício personalizado encontrado.'
                                  : 'Nenhum exercício padrão encontrado.',
                              style: GoogleFonts.plusJakartaSans(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ));
                          }

                          return ListView.builder(
                            padding:
                                const EdgeInsets.only(top: 10.0, bottom: 10.0),
                            itemCount: exercises.length,
                            itemBuilder: (context, index) {
                              ExerciseModel item = exercises[index];
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: InkWell(
                                            child: Text(
                                              item.name,
                                              style:
                                                  GoogleFonts.plusJakartaSans(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            onTap: () {
                                              setState(() {
                                                exerciseSelected = {
                                                  'name': item.name,
                                                  'value': item.id
                                                };
                                              });
                                            },
                                          ),
                                        ),
                                        if (isCustomExercise)
                                          InkWell(
                                            child: const Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                            onTap: () {
                                              removeCustomExercise(item.id);
                                            },
                                          )
                                      ],
                                    ),
                                  ),
                                  const Divider(
                                    color: Colors.grey,
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomTextFormField(
                          type: TextInputType.number,
                          placeholder: '0',
                          title: 'Séries',
                          obscureText: false,
                          controller: _seriesCountController,
                          validator: _validateInputs,
                          width: 100.0,
                          onChange: (value) {
                            setState(() {
                              seriesCount = int.tryParse(value) ?? 0;
                            });
                          },
                        ),
                        CustomTextFormField(
                          type: TextInputType.number,
                          placeholder: '0',
                          title: 'Repetições',
                          obscureText: false,
                          controller: _repetitionsCountController,
                          validator: _validateInputs,
                          width: 140.0,
                          onChange: (value) {
                            setState(() {
                              repetitionsCount = int.tryParse(value) ?? 0;
                            });
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Text(
                'Adicionar exercício: ${exerciseSelected['name']} ${seriesCount}x$repetitionsCount ?',
                style: GoogleFonts.plusJakartaSans(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Button(
              onPressed: () => {handleSubmit(context)},
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
    );
  }
}
