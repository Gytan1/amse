import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class Film {
  final String titre;
  final int annee;
  final String realisateur;
  final List<String> genre;
  final double noteIMDb;
  final String imageUrl;

  Film({
    required this.titre,
    required this.annee,
    required this.realisateur,
    required this.genre,
    required this.noteIMDb,
    required this.imageUrl,
  });

  factory Film.fromJson(Map<String, dynamic> json) {
    return Film(
      titre: json["titre"],
      annee: json["annee"],
      realisateur: json["realisateur"],
      genre: List<String>.from(json["genre"]),
      noteIMDb: (json["note_IMDb"] as num).toDouble(),
      imageUrl: json["imageUrl"],
    );
  }
}
