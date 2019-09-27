import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movies_flutter_app/src/models/movie_model.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;

  CardSwiper({@required this.movies});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      width: double.infinity,
      child: Swiper(
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.5,
        itemBuilder: (BuildContext context, int i) {
          movies[i].uniqueId = '${movies[i].id}-card';
          final _poster = ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, 'details', arguments: movies[i]),
              child: FadeInImage(
                image: NetworkImage(movies[i].getPosterImage()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          );
          return Hero(
            tag: movies[i].uniqueId,
            child: _poster,
          );
        },
        itemCount: movies.length,
        layout: SwiperLayout.STACK,
      ),
    );
  }
}
