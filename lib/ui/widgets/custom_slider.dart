import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mf_movie_ticket_book/models/ListMoviesApi.dart';
import 'package:mf_movie_ticket_book/models/Movies.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CustomeSlider extends StatefulWidget {
    List<ListMoviesApi> listMoviesApi;

    CustomeSlider({
        this.listMoviesApi,
        Key key
    }) : super(key: key);

    @override
    _CustomeSliderState createState() => _CustomeSliderState();
}

class _CustomeSliderState extends State<CustomeSlider> {
    int _currentSlideIndex = 0;

    @override
    Widget build(BuildContext context) {
        return carouselSlider();
    }

    FutureBuilder carouselSlideBuilder(String apiUrl) {
        return FutureBuilder(
            future: getMoviesApi(apiUrl),
            builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
                if (asyncSnapshot.hasData) {
                    Movies movies = asyncSnapshot.data;

                    return showCardSlider(movies);
                }

                return loadCardSlider();
            },
        );
    }

    Widget carouselSlider() {
        return Container(
            height: MediaQuery.of(context).size.height * 0.273,
            child: Column(
                children: [
                    CarouselSlider(
                        items: widget.listMoviesApi.map((listMoviesApi) {
                            return Builder(
                                builder: (BuildContext context) {
                                    return carouselSlideBuilder(listMoviesApi.apiUrl);
                                },
                            );
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
                        children: widget.listMoviesApi.map((url) {
                            int index = widget.listMoviesApi.indexOf(url);
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

    Widget loadCardSlider() {
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

    getMoviesApi(String apiUrl) async {
        try {
            StringBuffer stringBuffer = new StringBuffer();
            stringBuffer.write(apiUrl);
            String url = stringBuffer.toString();

            var response = await http.get(url);

            if (response.statusCode == 200) {
                var responseBody = jsonDecode(response.body);

                Movies movies = Movies(
                    title: responseBody['Title'],
                    year: responseBody['Year'],
                    released : responseBody['Released'],
                    poster : responseBody['Poster'],
                );

                return movies;
            }

        } catch (e) {
            print(e.toString());
        } 
    }
}