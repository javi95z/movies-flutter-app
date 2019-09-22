import 'package:flutter/material.dart';
import 'package:movies_flutter_app/src/models/movie_model.dart';

class HorizontalMovie extends StatelessWidget {
  final List<Movie> movies;
  final _pageController =
      new PageController(initialPage: 1, viewportFraction: 0.25);
  final Function nextPage;

  HorizontalMovie({@required this.movies, @required this.nextPage});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        nextPage();
      }
    });

    return Container(
      height: _screenSize.height * 0.2,
      child: PageView(
        pageSnapping: false,
        controller: _pageController,
        children: _cards(context),
      ),
    );
  }

  List<Widget> _cards(BuildContext context) {
    return movies.map((f) {
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: FadeInImage(
                    image: NetworkImage(f.getPosterImage()),
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    fit: BoxFit.cover,
                    height: 120.0)),
            SizedBox(height: 5.0),
            Text(f.title,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.caption)
          ],
        ),
      );
    }).toList();
  }
}
