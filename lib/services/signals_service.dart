import 'package:flutter/services.dart';

import '../models/signal_model.dart';

import 'dart:convert';

class SignalsService {
  Future<List<Signal>> getSignals() async {
    try {
      String signalsData = await rootBundle.loadString('assets/signals/signals.json');
      List<dynamic> jsonList = json.decode(signalsData);

      List<Signal> signals = jsonList
          .map((json) => Signal(
                name: json['name'],
                image: json['image'],
                meaning: json['meaning'],
              ))
          .toList();

      return signals;
    } catch (e) {
      print('Error cargando señales: $e');
      return [];
    }
  }
}

