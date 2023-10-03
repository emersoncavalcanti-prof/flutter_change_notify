import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  final List<String> _carros = [];

  List<String> get carros => _carros;

  void addCarro(String carro) {
    _carros.add(carro);
    notifyListeners();
  }
}
