import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

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
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      width: double.infinity,
      height: 300.0,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return new Image.network('http://via.placeholder.com/350x150',
              fit: BoxFit.fill);
        },
        itemCount: 3,
        pagination: new SwiperPagination(),
        control: new SwiperControl(),
        itemWidth: 200.0,
        itemHeight: 400.0,
        layout: SwiperLayout.STACK,
      ),
    );
  }
}
