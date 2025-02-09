import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'MyAppState.dart';

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    return Center(
      child: Row(
        children: [
          SizedBox(height: 200, width: 200),
          SizedBox(
            height: 200,
            width: 400,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FilmsPage()),
                );
              },
              child: Text("Films"),
            ),
          ),
          SizedBox(
            height: 200,
            width: 400,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SeriesPAge()),
                );
              },
              child: Text("Series"),
            ),
          ),
        ],
      ),
    );
  }
}

class Pageinfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      body: Column(
        children: [
          Text('date:'),
          Text('02/04/2025'),
          Text('Creator:'),
          Text('Tanguy His'),
          Text('Purpose:'),
          Text(
            'le but de cette application est d proposer différents types de médias à l utilisateur que celui-ci peut choisir de liker ou nnon, il peut ainsi acceder a ses favoris',
          ),
        ],
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({super.key, required this.pair});

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // ← Add this.

    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Text(
        pair.asLowerCase,
        style: style,
        semanticsLabel: "${pair.first} ${pair.second}",
      ),
    );
  }
}

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return LayoutBuilder(
      builder: (context, constraints) {
        return Center(
          child: Row(
            children: [
              SizedBox(height: 200, width: 200),
              SizedBox(
                height: 200,
                width: 400,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FFilmsPage()),
                    );
                  },
                  child: Text("Vos films préférés"),
                ),
              ),
              SizedBox(
                height: 200,
                width: 400,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FSeriesPAge()),
                    );
                  },
                  child: Text("Vos series préférées"),
                ),
              ),
            ],
          ),
        );
      },
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
              title: Text(film),
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
      return Center(child: Text('No favorites yet.'));
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
          for (var f in appState.filmf) Text(f),
        ],
      ),
    );
  }
}

class SeriesPAge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Series")),
      body: Center(child: Text("Bienvenue sur la page de vos series!")),
    );
  }
}

class FSeriesPAge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Series")),
      body: Center(
        child: Text("Bienvenue sur la page de vos series favorites!"),
      ),
    );
  }
}
