import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mf_movie_ticket_book/models/Movies.dart';

class SliderMovies extends StatefulWidget {
    final List<Movies> listMovies;
    SliderMovies({
        @required this.listMovies,
    });

    @override
    _SliderMoviesState createState() => _SliderMoviesState();
}

class _SliderMoviesState extends State<SliderMovies> {
    int _currentSlideIndex = 0;

    @override
    Widget build(BuildContext context) {
        return Container(
            height: MediaQuery.of(context).size.height * 0.273,
            child: Column(
                children: [
                    CarouselSlider(
                        items: this.widget.listMovies.map((movies)  {
                            return showCardSlider(movies);
                        }).toList(),
                        options: CarouselOptions(
                            height: MediaQuery.of(context).size.height * 0.23,
                            enableInfiniteScroll: true,
                            aspectRatio: 16/9,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 3),
                            autoPlayAnimationDuration: Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            scrollDirection: Axis.horizontal,
                            onPageChanged: (index, reason) {
                                setState(() {
                                    _currentSlideIndex = index;
                                });
                            }
                        ),
                    ),
                    SizedBox(height: 5),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: this.widget.listMovies.map((url) {
                            int index = widget.listMovies.indexOf(url);
                            return Container(
                                width: 8.0,
                                height: 8.0,
                                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                                decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _currentSlideIndex == index
                                    ? Color.fromRGBO(0, 0, 0, 0.9)
                                    : Color.fromRGBO(0, 0, 0, 0.4),
                                ),
                            );
                        }).toList(),
                    ),
                ],
            ),
        );
    }

    Widget showCardSlider(Movies movies) {
        return Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(left: 6, right: 6, top: 10),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(movies.poster),
                    fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.all(
                    Radius.circular(10)
                ),
            ),
        );
    }
}

class SliderMoviesLoad extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return Container(
            height: MediaQuery.of(context).size.height * 0.273,
            child: Column(
                children: [
                    CarouselSlider(
                        items: [
                            loadCardSlider(context),
                            loadCardSlider(context),
                        ],
                        options: CarouselOptions(
                            height: MediaQuery.of(context).size.height * 0.23,
                            enableInfiniteScroll: true,
                            aspectRatio: 16/9,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 3),
                            autoPlayAnimationDuration: Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            scrollDirection: Axis.horizontal,
                        ),
                    ),
                ],
            ),
        );
    }

    Widget loadCardSlider(BuildContext context) {
        return Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(left: 6, right: 6, top: 10),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                        Colors.purple,
                        Colors.deepPurpleAccent,
                    ]
                ),
                borderRadius: BorderRadius.all(
                    Radius.circular(10)
                ),
            ),
            alignment: Alignment.center,
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white60),
            )
        );
    }
}