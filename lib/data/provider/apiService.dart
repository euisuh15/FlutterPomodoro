import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:pomodoro/data/models/quote_model.dart';

class ApiService {
  static Future<List<QuoteModel>> getWorkHardQuote() async {
    List<QuoteModel> quoteInstances = [];

    final String response =
        await rootBundle.loadString('assets/workHardQuote.json');
    final List<dynamic> quotes = jsonDecode(response);

    for (var quote in quotes) {
      quoteInstances.add(QuoteModel.fromJson(quote));
    }
    quoteInstances.shuffle();

    return quoteInstances;
  }
}
