import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_log/models/exercise.dart';
import 'summarymodal.dart';
import 'package:gym_log/repositories/session_repository.dart';
import 'package:gym_log/widgets/button.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class SessionPageModal extends StatefulWidget {
  final List<ExerciseModel> exerciseToFinish;

  const SessionPageModal({Key? key, required this.exerciseToFinish})
      : super(key: key);

  @override
  State<SessionPageModal> createState() => _SessionPageModalState();
}

class _SessionPageModalState extends State<SessionPageModal> {
  /// Submete os dados de `exerciseToFinish` ao banco de dados
  void _handleSubmit() async {
    await Provider.of<SessionRepository>(context, listen: false)
        .finishSession(widget.exerciseToFinish);
  }

  void _navigateToSummary() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SummaryPage(
          exercises: widget.exerciseToFinish,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80.0.w,
      height: 40.0.h,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        color: const Color(0xFF212429),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.close_rounded,
                      color: Colors.red,
                      size: 30.0,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Continue Assim!',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Image.asset('assets/images/halter30.png'),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.sp),
                child: Align(
                  alignment: Alignment.center,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      children: const [
                        TextSpan(
                          text:
                              'Tenha Certeza de Concluir TODAS as SÉRIES do seu Treino. Marque o Botão ',
                        ),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Icon(
                            Icons.check_circle_outline_outlined,
                            color: Color(0xFF617AFA),
                            size: 28.0,
                          ),
                        ),
                        TextSpan(
                          text: ' ao lado de cada uma delas.',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30.sp),
                child: Button(
                  label: 'TERMINAR',
                  bgColor: 0xFF617AFA,
                  textColor: 0xFFFFFFFF,
                  borderColor: 0xFF617AFA,
                  width: 55.sp,
                  height: 30.sp,
                  onPressed: () {
                    _handleSubmit(); // Salva os dados no banco
                    _navigateToSummary(); // Navega para a tela de resumo
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
