import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'Film.dart';

class MyAppState extends ChangeNotifier {
  List<Film> films = [];
  List<Film> filmf = []; // Liste des films favoris

  MyAppState() {
    _loadFilms();
    notifyListeners(); // Une seule notification après le chargement // Charge les films et les series au démarrage
  }

  Future<void> _loadFilms() async {
    final String response = await rootBundle.loadString('assets/films.json');
    final data = json.decode(response);
    films = (data['films'] as List).map((json) => Film.fromJson(json)).toList();
    notifyListeners();
  }

  void toggleFavoriteF(Film film) {
    if (filmf.contains(film)) {
      filmf.remove(film);
    } else {
      filmf.add(film);
    }
    notifyListeners();
  }

  bool isFavoriteF(Film film) {
    return filmf.contains(film);
  }
}
