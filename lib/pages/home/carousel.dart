// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:gym_log/pages/home/home.dart';

// class MyWidget extends StatefulWidget {
//   const MyWidget({super.key});

//   @override
//   State<MyWidget> createState() => _MyWidgetState();
// }

// class _MyWidgetState extends State<MyWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//     children: [
//       Text(
//         workout.name,
//         style: const TextStyle(
//           fontSize: 25.0,
//           fontWeight: FontWeight.bold,
//           color: Colors.white,
//         ),
//         textAlign: TextAlign.center,
//         softWrap: true,
//       ),
//       const SizedBox(height: 5.0),
//       Card(
//         color: const Color(0x617AF),
//         child: Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Text(
//                     'Exercícios:',
//                     style: const TextStyle(
//                       fontSize: 16.0,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                   const Spacer(),
//                   Text(
//                     'Séries',
//                     style: const TextStyle(
//                       fontSize: 16.0,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                   Divider(
//                     color: Colors.white,
//                     thickness: 1.0,
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 10.0),
//               ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: workout.exercises.length,
//                 itemBuilder: (context, index) {
//                   final exercise = workout.exercises[index];
//                   return Column(
//                     children: [
//                       Row(
//                         children: [
//                           Expanded(
//                             child: Text(
//                               exercise.name,
//                               style: GoogleFonts.plusJakartaSans(
//                                 fontSize: 18.0,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                           Text(
//                             '${workout.getSeriesRepsString().split(',')[index]}',
//                             style: GoogleFonts.plusJakartaSans(
//                               fontSize: 18.0,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(
//                           height: 10.0), // Adiciona espaçamento entre os itens
//                     ],
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     ],
//   );
//   }
// }

// Widget  _buildWorkoutCard(WorkoutModel workout) {
  
// }
