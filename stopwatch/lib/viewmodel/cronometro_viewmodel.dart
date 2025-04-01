import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cronometro_voltas/models/volta_model.dart';

class CronometroViewModel extends ChangeNotifier {
  Duration _tempoTotal = Duration.zero;
  Duration _tempoUltimaVolta = Duration.zero;
  Timer? _timer;
  bool _estaRodando = false;
  final List<Volta> _voltas = [];

  Duration get tempoTotal => _tempoTotal;
  List<Volta> get voltas => _voltas;
  bool get estaRodando => _estaRodando;

  void iniciar() {
    if (!_estaRodando) {
      _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
        _tempoTotal += Duration(milliseconds: 100);
        notifyListeners();
      });
      _estaRodando = true;
      notifyListeners();
    }
  }

  
  void pausar() {
    if (_estaRodando) {
      _timer?.cancel();
      _estaRodando = false;
      notifyListeners();
    }
  }

  
  void registrarVolta() {
    if (_estaRodando) {
      final novaVolta = Volta(
        numero: _voltas.length + 1,
        tempoVolta: _tempoTotal - _tempoUltimaVolta,
        tempoTotal: _tempoTotal,
      );
      _voltas.insert(0, novaVolta); 
      _tempoUltimaVolta = _tempoTotal;
      notifyListeners();
    }
  }

  
  void reiniciar() {
    _timer?.cancel();
    _tempoTotal = Duration.zero;
    _tempoUltimaVolta = Duration.zero;
    _voltas.clear();
    _estaRodando = false;
    notifyListeners();
  }
}