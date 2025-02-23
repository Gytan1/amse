import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'MyAppState.dart';

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(fixedSize: Size(200, 100)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FilmsPage()),
                );
              },
              child: Text("Films"),
            ),
            SizedBox(width: 20),
          ],
        ),
      ),
    );
  }
}

class PageInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Informations")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Date:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('02/04/2025'),
            SizedBox(height: 10),
            Text('Creator:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Tanguy His'),
            SizedBox(height: 10),
            Text('Purpose:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
              'Le but de cette application est de proposer différents films '
              'à l’utilisateur, que celui-ci peut choisir de liker ou non, mettant ces films dans sa liste de favoris. '
              'Il peut ainsi accéder à cette liste à chaque moment.',
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Vos Favoris")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(fixedSize: Size(200, 100)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FFilmsPage()),
                  );
                },
                child: Text("Vos films préférés"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FilmsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      appBar: AppBar(title: Text("Films")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 films par ligne
            childAspectRatio: 0.7, // Ajuste la taille des cartes
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: appState.films.length,
          itemBuilder: (context, index) {
            final film = appState.films[index];
            final isFavorite = appState.filmf.contains(film);

            return GestureDetector(
              onTap: () {
                _showFilmDetails(context, film, appState);
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(12),
                        ),
                        child: Image.asset(
                          film.imageUrl,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.image_not_supported,
                              size: 50,
                              color: Colors.grey,
                            );
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              film.titre,
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              appState.toggleFavoriteF(film);
                            },
                            icon: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isFavorite ? Colors.red : null,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class FFilmsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      appBar: AppBar(title: Text('Films préférés')),
      body:
          appState.filmf.isEmpty
              ? Center(
                child: Text(
                  'Aucun favori pour le moment.',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              )
              : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Vous avez ${appState.filmf.length} favoris :',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        itemCount: appState.filmf.length,
                        itemBuilder: (context, index) {
                          final f = appState.filmf[index];

                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 3,
                            child: ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  f.imageUrl,
                                  width: 50,
                                  height: 75,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(
                                      Icons.image_not_supported,
                                      size: 50,
                                      color: Colors.grey,
                                    );
                                  },
                                ),
                              ),
                              title: Text(
                                f.titre,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              trailing: IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  appState.toggleFavoriteF(f);
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
    );
  }
}

void _showFilmDetails(BuildContext context, film, MyAppState appState) {
  bool isFavorite = appState.filmf.contains(film);

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(film.titre, style: TextStyle(fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(film.imageUrl, height: 200, fit: BoxFit.cover),
            SizedBox(height: 10),
            Text("Réalisateur : ${film.realisateur}"),
            Text("Genre : ${film.genre}"),
            Text("Année : ${film.annee}"),
            Text("Note IMDb : ⭐ ${film.noteIMDb}"),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              appState.toggleFavoriteF(film);
              Navigator.pop(context); // Ferme la boîte de dialogue
            },
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : null,
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Fermer"),
          ),
        ],
      );
    },
  );
}
