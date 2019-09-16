import 'package:flutter/material.dart';
import 'package:movies_flutter_app/src/widgets/card_swiper_widget.dart';

class HomePage extends StatelessWidget {
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
    return CardSwiper(
      movies: [1, 2, 3, 4, 5]
    );
  }
}
