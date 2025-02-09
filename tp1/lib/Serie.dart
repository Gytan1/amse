import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class Serie {
  final String titre;
  final int annee;
  final int saisons;
  final String realisateur;
  final List<String> genre;
  final double noteIMDb;
  final String image;

  Serie({
    required this.titre,
    required this.annee,
    required this.saisons,
    required this.realisateur,
    required this.genre,
    required this.noteIMDb,
    required this.image,
  });

  factory Serie.fromJson(Map<String, dynamic> json) {
    return Serie(
      titre: json["titre"],
      annee: json["annee"],
      saisons: json["saisons"],
      realisateur: json["realisateur"],
      genre: List<String>.from(json["genre"]),
      noteIMDb: (json["note_IMDb"] as num).toDouble(),
      image: json["imageUrl"],
    );
  }
}
