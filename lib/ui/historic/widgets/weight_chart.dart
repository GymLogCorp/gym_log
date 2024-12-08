import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:gym_log/data/models/exercise.dart';

import 'package:gym_log/utils/resources/app_colors.dart';

class HistoricChart extends StatefulWidget {
  late List<ChartDataModel> chartData;
  HistoricChart({super.key, required this.chartData});

  @override
  State<HistoricChart> createState() => _HistoricChartState();
}

class _HistoricChartState extends State<HistoricChart> {
  List<int> showingTooltipOnSpots = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return LineChart(
              LineChartData(
                showingTooltipIndicators: showingTooltipOnSpots.map((index) {
                  return ShowingTooltipIndicators([
                    LineBarSpot(
                      LineChartBarData(
                        showingIndicators: showingTooltipOnSpots,
                        spots: widget.chartData
                            .asMap()
                            .entries
                            .map((entry) => FlSpot(
                                  entry.key.toDouble(),
                                  double.parse(entry.value.weight.toString()),
                                ))
                            .toList(),
                      ),
                      0,
                      FlSpot(
                          index.toDouble(),
                          double.parse(
                              widget.chartData[index].weight.toString())),
                    ),
                  ]);
                }).toList(),
                lineTouchData: LineTouchData(
                  enabled: true,
                  handleBuiltInTouches: false,
                  touchCallback:
                      (FlTouchEvent event, LineTouchResponse? response) {
                    if (response == null || response.lineBarSpots == null) {
                      return;
                    }
                    if (event is FlTapUpEvent) {
                      final spotIndex = response.lineBarSpots!.first.spotIndex;
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
                        const FlLine(color: Colors.white),
                        FlDotData(
                          show: true,
                          getDotPainter: (spot, percent, barData, index) =>
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
                    spots: widget.chartData
                        .asMap()
                        .entries
                        .map((entry) => FlSpot(
                              entry.key.toDouble(),
                              double.parse(entry.value.weight.toString()),
                            ))
                        .toList(),
                    isCurved: true,
                    barWidth: 4,
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          AppColors.contentColorBlue.withOpacity(0.4),
                          AppColors.contentColorBlue.withOpacity(0.4),
                          AppColors.contentColorBlue.withOpacity(0.4),
                        ],
                      ),
                    ),
                    dotData: const FlDotData(show: false),
                    gradient: const LinearGradient(
                      colors: [
                        AppColors.contentColorBlue,
                        AppColors.contentColorBlue,
                        AppColors.contentColorBlue,
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
                            value.toInt() >= widget.chartData.length) {
                          return const SizedBox.shrink();
                        }
                        return Text(
                          widget.chartData[value.toInt()].date,
                          style: const TextStyle(
                            color: Colors.white,
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
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      getTitlesWidget: (value, meta) {
                        // Obtém os pesos únicos do chartData
                        final weights = widget.chartData
                            .map((e) => e.weight.toInt())
                            .toSet();

                        // Verifica se o valor está nos pesos
                        if (!weights.contains(value.toInt())) {
                          return const SizedBox
                              .shrink(); // Não exibe títulos para valores inexistentes
                        }

                        return Text(
                          value.toInt().toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        );
                      },
                      interval: _calculateInterval(),
                    ),
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
    );
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

  double _calculateInterval() {
    final weights = widget.chartData.map((e) => e.weight).toList()..sort();
    if (weights.length < 2) {
      return 1.0; // Define 1.0 como intervalo padrão se houver poucos valores
    }

    // Calcula a menor diferença entre os valores
    double minDifference = double.infinity;
    for (int i = 1; i < weights.length; i++) {
      minDifference = (weights[i] - weights[i - 1])
          .abs()
          .clamp(1, minDifference)
          .toDouble(); // Converte explicitamente para double
    }
    return minDifference;
  }
}
