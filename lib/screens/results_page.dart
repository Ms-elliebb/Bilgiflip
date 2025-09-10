import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pie_chart/pie_chart.dart';
import '../models/topic_model.dart';
import '../providers/data_providers.dart';
import '../providers/flashcard_provider.dart';
import '../utils/app_colors.dart';
import '../widgets/app_background.dart';

class ResultsPage extends ConsumerWidget {
  final int knownCount;
  final int unknownCount;
  final int totalCount;
  final Topic topic;

  const ResultsPage({
    super.key,
    required this.knownCount,
    required this.unknownCount,
    required this.totalCount,
    required this.topic,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final successRate = totalCount > 0 ? (knownCount / totalCount * 100) : 0;
    final dataMap = <String, double>{
      "Biliyorum": knownCount.toDouble(),
      "Tekrar Et": unknownCount.toDouble(),
    };
    final colorList = <Color>[
      AppColors.kSuccessColor,
      AppColors.kErrorColor,
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Konu Tamamlandı!'),
        automaticallyImplyLeading: false,
      ),
      body: AppBackground(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              SizedBox(
                height: 200,
                child: PieChart(
                  dataMap: dataMap,
                  animationDuration: const Duration(milliseconds: 800),
                  chartLegendSpacing: 32,
                  chartRadius: MediaQuery.of(context).size.width / 3.2,
                  colorList: colorList,
                  initialAngleInDegree: 0,
                  chartType: ChartType.ring,
                  ringStrokeWidth: 32,
                  legendOptions: const LegendOptions(
                    showLegendsInRow: false,
                    legendPosition: LegendPosition.right,
                    showLegends: true,
                    legendTextStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  chartValuesOptions: const ChartValuesOptions(
                    showChartValueBackground: true,
                    showChartValues: true,
                    showChartValuesInPercentage: false,
                    showChartValuesOutside: false,
                    decimalPlaces: 0,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Text(
                'Başarı Oranı: %${successRate.toStringAsFixed(0)}',
                style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                'Doğru: $knownCount, Yanlış: $unknownCount, Toplam: $totalCount',
                style: theme.textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              if (unknownCount > 0)
              ElevatedButton(
                onPressed: () {
                  final progressService = ref.read(progressServiceProvider);
                  ref
                      .read(flashcardProvider((topic: topic, progressService: progressService)).notifier)
                      .startReviewSession();
                  Navigator.pop(context);
                },
                child: const Text('Sadece Yanlışları Tekrar Et'),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () {
                  final progressService = ref.read(progressServiceProvider);
                  ref
                      .read(flashcardProvider((topic: topic, progressService: progressService)).notifier)
                      .reset();
                  Navigator.pop(context);
                },
                child: const Text('Konuyu Baştan Başla'),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                child: const Text('Ana Menüye Dön'),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
