import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'Films.dart';

class MyAppState extends ChangeNotifier {
  var current = Films();

  var favorites = <WordPair>[];
  var films = ["film1", "film2", 'film3'];
  var series = [];
  var filmf = [];
  var seriesf = [];

  void toggleFavoriteF(String film) {
    if (filmf.contains(film)) {
      filmf.remove(film);
    } else {
      filmf.add(film);
    }
    notifyListeners();
  }

  void toggleFavoriteS(String serie) {
    if (seriesf.contains(serie)) {
      seriesf.remove(serie);
    } else {
      seriesf.add(serie);
    }
    notifyListeners();
  }
}
