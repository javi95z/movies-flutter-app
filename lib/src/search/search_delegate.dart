import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate {
  String selection = '';
  final movies = [
    'Spiderman',
    'Aquaman',
    'Batman',
    'Superman',
    'Ironman',
    'Ironman 2',
    'Ironman 3',
    'Shazam!',
    'Captain America',
  ];
  final recentMovies = ['Spiderman', 'Captain America'];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = '',
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.blueAccent,
        child: Text(selection),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestedList = (query.isEmpty)
        ? recentMovies
        : movies
            .where((p) => p.toLowerCase().startsWith(query.toLowerCase()))
            .toList();
    return ListView.builder(
      itemCount: suggestedList.length,
      itemBuilder: (context, i) {
        return ListTile(
          leading: Icon(Icons.movie),
          title: Text(suggestedList[i]),
          onTap: () {
            selection = suggestedList[i].toString();
            showResults(context);
          },
        );
      },
    );
  }
}
