import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'Film.dart';
import 'Serie.dart';

class MyAppState extends ChangeNotifier {
  List<Film> films = [];
  List<Film> filmf = []; // Liste des films favoris
  List<Serie> series = [];
  List<Serie> seriesf = [];

  MyAppState() {
    _loadFilms();
    _loadSerie(); // Charge les films et les series au démarrage
  }

  Future<void> _loadFilms() async {
    final String response = await rootBundle.loadString('assets/films.json');
    final data = json.decode(response);
    films = (data['films'] as List).map((json) => Film.fromJson(json)).toList();
    notifyListeners();
  }

  Future<void> _loadSerie() async {
    final String response = await rootBundle.loadString('assets/series.json');
    final data = json.decode(response);
    films =
        (data['series'] as List).map((json) => Film.fromJson(json)).toList();
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

  bool isFavoriteS(Serie serie) {
    return seriesf.contains(serie);
  }

  void toggleFavoriteS(Serie serie) {
    if (seriesf.contains(serie)) {
      seriesf.remove(serie);
    } else {
      seriesf.add(serie);
    }
    notifyListeners();
  }
}
