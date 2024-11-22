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
      if (historicRepository.historicExercisesList.isEmpty) {
        return Center(
          child: Text(
            'Nenhum dado encontrado.',
            style: TextStyle(
              color: AppColors.contentColorBlue,
              fontSize: 16,
            ),
          ),
        );
      } else {
        List<ChartDataModel> chartData = historicRepository
            .historicExercisesList[selectedExerciseIndex].chartData;

        if (chartData.isEmpty) {
          return Center(
            child: Text(
              'Nenhum dado encontrado.',
              style: TextStyle(
                color: AppColors.contentColorBlue,
                fontSize: 16,
              ),
            ),
          );
        }

        return Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return LineChart(
                    LineChartData(
                      showingTooltipIndicators:
                          showingTooltipOnSpots.map((index) {
                        return ShowingTooltipIndicators([
                          LineBarSpot(
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
                            ),
                            0,
                            FlSpot(index.toDouble(),
                                double.parse(chartData[index].weight)),
                          ),
                        ]);
                      }).toList(),
                      lineTouchData: LineTouchData(
                        enabled: true,
                        handleBuiltInTouches: false,
                        touchCallback:
                            (FlTouchEvent event, LineTouchResponse? response) {
                          if (response == null ||
                              response.lineBarSpots == null) {
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
                                getDotPainter:
                                    (spot, percent, barData, index) =>
                                        FlDotCirclePainter(
                                  radius: 8,
                                  color: lerpGradient(
                                    barData.gradient!.colors,
                                    barData.gradient!.stops!,
                                    percent / 100,
                                  ),
                                  strokeWidth: 2,
                                  strokeColor: Colors.white,
                                ),
                              ),
                            );
                          }).toList();
                        },
                      ),
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
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 30,
                            getTitlesWidget: (value, meta) {
                              if (value.toInt() < 0 ||
                                  value.toInt() >= chartData.length) {
                                return const SizedBox.shrink();
                              }
                              return Text(
                                chartData[value.toInt()].date,
                                style: const TextStyle(
                                  color: AppColors.contentColorBlue,
                                  fontSize: 12,
                                ),
                              );
                            },
                            interval: 1,
                          ),
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      gridData: const FlGridData(show: true),
                      borderData: FlBorderData(
                        show: false,
                        border: Border.all(color: AppColors.borderColor),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      }
    });
  }

  Color lerpGradient(List<Color> colors, List<double> stops, double t) {
    if (colors.isEmpty) return Colors.transparent;
    if (stops.length != colors.length) {
      stops = List.generate(colors.length, (i) => i / (colors.length - 1));
    }
    for (int i = 0; i < stops.length - 1; i++) {
      if (t <= stops[i + 1]) {
        final sectionT = (t - stops[i]) / (stops[i + 1] - stops[i]);
        return Color.lerp(colors[i], colors[i + 1], sectionT)!;
      }
    }
    return colors.last;
  }
}
