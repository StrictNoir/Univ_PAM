import 'package:flutter/foundation.dart';

/// Controleaza logica de calcul pentru viteza medie.
class SpeedController extends ChangeNotifier {
  double? _average; // km/h
  String? _error;

  double? get average => _average;
  String? get error => _error;

  // Regex precompilat: accepta doar forme de tip "123" sau "123.45" / "123,45"
  static final RegExp _numberRegex = RegExp(r'^\d+(?:[.,]\d+)?$');


  double? _parseNumber(String raw) {
    final s = raw.replaceAll(',', '.').trim();
    if (!_numberRegex.hasMatch(s)) return null;
    return double.tryParse(s);
  }

  void calculate({required String distanceText, required String timeText}) {
    // Resetam rezultatul pentru o rulare curata
    _error = null;
    _average = null;

    final distance = _parseNumber(distanceText);
    final time = _parseNumber(timeText);

    if (distance == null) {
      _error = 'Distanta trebuie sa fie un numar valid (ex: 12 sau 12.5).';
      notifyListeners();
      return;
    }
    if (distance < 0) {
      _error = 'Distanta nu poate fi negativa.';
      notifyListeners();
      return;
    }

    // Validari pe timp
    if (time == null) {
      _error = 'Timpul trebuie sa fie un numar valid (ex: 1 sau 1.5).';
      notifyListeners();
      return;
    }
    if (time <= 0) {
      _error = 'Timpul trebuie sa fie mai mare ca 0.';
      notifyListeners();
      return;
    }

    // Calcul viteza medie
    _average = distance / time;

    // Un singur notify pentru succes
    notifyListeners();
  }

  /// Curata mesajele si rezultatele din UI.
  void reset() {
    _average = null;
    _error = null;
    notifyListeners();
  }
}
