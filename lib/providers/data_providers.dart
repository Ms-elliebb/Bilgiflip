import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/category_model.dart';
import '../services/data_service.dart';
import '../services/progress_service.dart';

final dataServiceProvider = Provider<DataService>((ref) {
  return DataService();
});

final categoriesProvider = FutureProvider<List<Category>>((ref) {
  final dataService = ref.watch(dataServiceProvider);
  return dataService.loadCategories();
});

final progressServiceProvider = Provider<ProgressService>((ref) {
  return ProgressService();
});

final knownCardsProvider = FutureProvider<List<String>>((ref) async {
  final progressService = ref.watch(progressServiceProvider);
  return progressService.getKnownCards();
});
