import 'package:flutter/material.dart';
import 'package:movies_flutter_app/src/models/movie_model.dart';
import 'package:movies_flutter_app/src/providers/movies_provider.dart';
import 'package:movies_flutter_app/src/widgets/card_swiper_widget.dart';
import 'package:movies_flutter_app/src/widgets/horizontal_movie.dart';

class HomePage extends StatelessWidget {
  final moviesProvider = new MoviesProvider();

  @override
  Widget build(BuildContext context) {
    moviesProvider.getPopular();
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[_cardsSwiper(), _infiniteFooter(context)],
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

  Widget _infiniteFooter(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(left: 20.0),
              child: Text('Popular movies',
                  style: Theme.of(context).textTheme.subhead)),
          SizedBox(height: 10.0),
          StreamBuilder(
            stream: moviesProvider.popularStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.hasData) {
                return HorizontalMovie(
                    movies: snapshot.data, nextPage: moviesProvider.getPopular);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          )
        ],
      ),
    );
  }
}
