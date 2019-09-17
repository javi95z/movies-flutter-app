import 'package:flutter/material.dart';
import 'package:movies_flutter_app/src/providers/movies_provider.dart';
import 'package:movies_flutter_app/src/widgets/card_swiper_widget.dart';

class HomePage extends StatelessWidget {
  final moviesProvider = new MoviesProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Movies'),
          backgroundColor: Colors.deepOrange,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () => {},
            )
          ],
        ),
        body: Container(
          child: Column(
            children: <Widget>[_cardsSwiper()],
          ),
        ));
  }

  Widget _cardsSwiper() {
    return FutureBuilder(
      future: moviesProvider.getNowPlaying(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(movies: snapshot.data);
        } else {
          return Container(
            height: 400.0,
            child: Center(child: CircularProgressIndicator(strokeWidth: 2.0)),
          );
        }
      },
    );
  }
}
