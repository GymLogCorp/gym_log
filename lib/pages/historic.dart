import 'package:flutter/material.dart';
import 'package:gym_log/mocks/mock_session.dart';
import 'package:gym_log/models/historic_log.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:gym_log/resources/app_colors.dart';

class HistoricPage extends StatefulWidget {
  const HistoricPage({super.key});

  @override
  State<HistoricPage> createState() => _HistoricPageState();
}

class _HistoricPageState extends State<HistoricPage> {
  List<List<ChartDataModel>> chartData =
      []; // Lista de gráficos para múltiplos exercícios
  int selectedExerciseIndex = 0; // Índice do exercício selecionado

  void getExerciseHistoric() {
    setState(() {
      chartData = exerciseHistoryMock
          .map((historic) =>
              historic.chartData) // Mapeia para cada histórico de exercício
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    getExerciseHistoric();
  }

  List<Color> gradientColors = [
    AppColors.contentColorCyan,
    AppColors.contentColorBlue,
  ];

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          children: [
            // Exibe um gráfico para o exercício selecionado
            AspectRatio(
              aspectRatio: 1.70,
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 30,
                  left: 20,
                  top: 36,
                  bottom: 10,
                ),
                child: LineChart(
                  showAvg ? avgData() : mainData(),
                ),
              ),
            ),
            // Exibe botões para alternar entre os exercícios
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: exerciseHistoryMock.length,
                itemBuilder: (context, index) {
                  return TextButton(
                    onPressed: () {
                      setState(() {
                        selectedExerciseIndex = index;
                      });
                    },
                    child: Text(
                      ' ${exerciseHistoryMock[index].name}',
                      style: TextStyle(
                        fontSize: 12,
                        color: selectedExerciseIndex == index
                            ? Colors.blue
                            : Colors.white,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        SizedBox(
          width: 60,
          height: 34,
          child: TextButton(
            onPressed: () {
              setState(() {
                showAvg = !showAvg;
              });
            },
            child: Text(
              'Kg',
              style: TextStyle(
                fontSize: 12,
                color: showAvg ? Colors.white.withOpacity(0.5) : Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontSize: 16,
    );

    Widget text;
    int index = value.toInt();

    if (index >= 0 && index < chartData[selectedExerciseIndex].length) {
      String formattedDate = chartData[selectedExerciseIndex][index].date;
      text = Text(formattedDate, style: style);
    } else {
      text = const Text('', style: style);
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );

    String text = value.toStringAsFixed(0); // Exibe o valor do eixo Y

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    List<FlSpot> spots = chartData[selectedExerciseIndex]
        .asMap()
        .map((index, data) => MapEntry(
            index,
            FlSpot(index.toDouble(),
                double.tryParse(data.weight.replaceAll('kg', '')) ?? 0.0)))
        .values
        .toList();

    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: AppColors.mainGridLineColor,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: AppColors.mainGridLineColor,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: chartData[selectedExerciseIndex].length.toDouble() - 1,
      minY: 0,
      maxY: 500, // Ajuste conforme a faixa de peso
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  double calcularMediaPeso() {
    double pesoTotal = 0.0;
    int contagem = 0;
    for (var dado in chartData[selectedExerciseIndex]) {
      double peso = double.tryParse(dado.weight.replaceAll('kg', '')) ?? 0.0;
      pesoTotal += peso;
      contagem++;
    }
    return contagem > 0 ? pesoTotal / contagem : 0.0;
  }

  LineChartData avgData() {
    double pesoMedio = calcularMediaPeso();
    List<FlSpot> spots = chartData[selectedExerciseIndex]
        .asMap()
        .map((index, dado) => MapEntry(
            index, FlSpot(index.toDouble(), pesoMedio))) // Média dinâmica
        .values
        .toList();
    return LineChartData(
      lineTouchData: const LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        verticalInterval: 1,
        horizontalInterval: 1,
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: bottomTitleWidgets,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
            interval: 1,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: chartData[selectedExerciseIndex].length.toDouble() - 1,
      minY: 0,
      maxY: 80, // Ajuste conforme a faixa de peso
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          gradient: LinearGradient(
            colors: [
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
            ],
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!,
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
