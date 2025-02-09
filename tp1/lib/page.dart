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
            ElevatedButton(
              style: ElevatedButton.styleFrom(fixedSize: Size(200, 100)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SeriesPAge()),
                );
              },
              child: Text("Series"),
            ),
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
              'Le but de cette application est de proposer différents types de médias '
              'à l’utilisateur, que celui-ci peut choisir de liker ou non. '
              'Il peut ainsi accéder à ses favoris.',
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
              SizedBox(width: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(fixedSize: Size(200, 100)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FSeriesPAge()),
                  );
                },
                child: Text("Vos séries préférées"),
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
        child: ListView.builder(
          itemCount: appState.films.length,
          itemBuilder: (context, index) {
            final film = appState.films[index];
            final isFavorite = appState.filmf.contains(
              film,
            ); // Vérifie si c'est un favori

            return ListTile(
              leading: Image.asset(
                film.imageUrl,
                width: 50,
                height: 75,
                fit: BoxFit.cover,
              ),
              title: Text(film.titre),
              trailing: IconButton(
                onPressed: () {
                  appState.toggleFavoriteF(film);
                },
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : null,
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
    if (appState.filmf.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text('Films préférés')),
        body: Center(child: Text('No favorites yet.')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('Films préférés')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              'You have '
              '${appState.filmf.length} favorites:',
            ),
          ),
          for (var f in appState.filmf)
            Row(children: [Icon(Icons.favorite), Text(f.titre)]),
        ],
      ),
    );
  }
}

class SeriesPAge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return Scaffold(
      appBar: AppBar(title: Text("Series")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: appState.series.length,
          itemBuilder: (context, index) {
            final serie = appState.series[index];
            final isFavorite = appState.seriesf.contains(
              serie,
            ); // Vérifie si c'est un favori

            return ListTile(
              leading: Image.asset(
                serie.image, // Afficher l'image
                width: 50,
                height: 75,
                fit: BoxFit.cover,
              ),
              title: Text(serie.titre),
              trailing: IconButton(
                onPressed: () {
                  appState.toggleFavoriteS(serie);
                },
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : null,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class FSeriesPAge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    if (appState.seriesf.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text('Series préférées')),
        body: Center(child: Text('No favorites yet.')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('Series préférés')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              'You have '
              '${appState.seriesf.length} favorites:',
            ),
          ),
          for (var f in appState.seriesf)
            Row(children: [Icon(Icons.favorite), Text(f.titre)]),
        ],
      ),
    );
  }
}
