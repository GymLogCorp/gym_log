import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:gym_log/models/exercise.dart';
import 'package:gym_log/repositories/historic_repository.dart';
import 'package:gym_log/resources/app_colors.dart';
import 'package:provider/provider.dart';

class HistoricPage extends StatefulWidget {
  const HistoricPage({super.key});

  @override
  State<HistoricPage> createState() => _HistoricPageState();
}

class _HistoricPageState extends State<HistoricPage> {
  int selectedExerciseIndex = 0;
  List<int> showingTooltipOnSpots = [];

  @override
  void initState() {
    super.initState();
    getHistoric();
  }

  void getHistoric() async {
    await Provider.of<HistoricRepository>(context, listen: false)
        .getHistoricByExercise('1', 'Paralelas');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HistoricRepository>(
        builder: (context, historicRepository, child) {
      List<ChartDataModel> chartData = historicRepository
          .historicExercisesList[selectedExerciseIndex].chartData;

      return Container(
        height: MediaQuery.of(context).size.height * 0.3,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      showingIndicators: showingTooltipOnSpots,
                      spots: chartData
                          .asMap()
                          .entries
                          .map((entry) => FlSpot(
                                entry.key.toDouble(),
                                double.parse(entry.value.weight),
                              ))
                          .toList(),
                      isCurved: true,
                      barWidth: 4,
                      shadow: const Shadow(blurRadius: 8),
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          colors: [
                            AppColors.contentColorBlue.withOpacity(0.4),
                            AppColors.contentColorPink.withOpacity(0.4),
                            AppColors.contentColorRed.withOpacity(0.4),
                          ],
                        ),
                      ),
                      dotData: const FlDotData(show: false),
                      gradient: const LinearGradient(
                        colors: [
                          AppColors.contentColorBlue,
                          AppColors.contentColorPink,
                          AppColors.contentColorRed,
                        ],
                        stops: [0.1, 0.4, 0.9],
                      ),
                    ),
                  ],
                  minY: 0,
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      axisNameWidget: Text(
                        'Peso (kg)',
                        style: TextStyle(color: Colors.white),
                      ),
                      axisNameSize: 24,
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toStringAsFixed(1),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          );
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      axisNameWidget: Text(
                        'Data',
                        style: TextStyle(color: Colors.white),
                      ),
                      axisNameSize: 24,
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        getTitlesWidget: (value, meta) {
                          int index = value.toInt();
                          if (index >= 0 && index < chartData.length) {
                            final createdDate = chartData[index].date;
                            return Text(
                              createdDate,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            );
                          }
                          return Container();
                        },
                      ),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      axisNameWidget: Text(
                        'Histórico',
                        style: TextStyle(color: Colors.white),
                      ),
                      axisNameSize: 24,
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  gridData: const FlGridData(show: false),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(color: AppColors.borderColor),
                  ),
                  lineTouchData: LineTouchData(
                    enabled: true,
                    handleBuiltInTouches: false,
                    touchCallback:
                        (FlTouchEvent event, LineTouchResponse? response) {
                      if (response == null || response.lineBarSpots == null) {
                        return;
                      }
                      if (event is FlTapUpEvent) {
                        final spotIndex =
                            response.lineBarSpots!.first.spotIndex;
                        setState(() {
                          if (showingTooltipOnSpots.contains(spotIndex)) {
                            showingTooltipOnSpots.remove(spotIndex);
                          } else {
                            showingTooltipOnSpots.add(spotIndex);
                          }
                        });
                      }
                    },
                    getTouchedSpotIndicator:
                        (LineChartBarData barData, List<int> spotIndexes) {
                      return spotIndexes.map((index) {
                        return TouchedSpotIndicatorData(
                          const FlLine(color: Colors.pink),
                          FlDotData(
                            show: true,
                            getDotPainter: (spot, percent, barData, index) =>
                                FlDotCirclePainter(
                              radius: 8,
                              color: AppColors.contentColorPink,
                              strokeWidth: 2,
                              strokeColor: Colors.white,
                            ),
                          ),
                        );
                      }).toList();
                    },
                  ),
                ),
              );
            },
          ),
        ),
      );
    });
  }
}
