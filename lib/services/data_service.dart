import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/category_model.dart';

class DataService {
  Future<List<Category>> loadCategories() async {
    final String response = await rootBundle.loadString('assets/data.json');
    final data = await json.decode(response) as List;
    return data.map((json) => Category.fromJson(json)).toList();
  }
}
