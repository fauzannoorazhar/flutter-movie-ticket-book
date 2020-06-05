import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mf_movie_ticket_book/models/ListCategoryMovies.dart';
import 'package:mf_movie_ticket_book/models/ListMoviesApi.dart';
import 'package:mf_movie_ticket_book/models/Movies.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as dev;

class CustomTabLine extends StatefulWidget {
    List<ListCategoryMovies> list;

    CustomTabLine({
        this.list,
        Key key
    }) : super(key: key);

    @override
    _CustomTabLineState createState() => _CustomTabLineState();
}

class _CustomTabLineState extends State<CustomTabLine> {
    int indexListActive = 0;
    List<ListMoviesApi> listMoviesApi = new List<ListMoviesApi>();

    void reCreateList(int index) {
        setState(() {
            widget.list.forEach((element) {
               element.active = false; 
            });
            widget.list[index].active = true;
            // set index list active
            indexListActive = index;
        });
    }

    List<ListMoviesApi> reCreateListMoviesApi() {
        if (listMoviesApi.isNotEmpty) {
            setState(() {
                // set listMoviesApi to null
                listMoviesApi = new List<ListMoviesApi>();
            });
        }
 
        if (indexListActive == ListCategoryMovies.marvel) {
            listMoviesApi.add(ListMoviesApi(id: 'tt4154796', apiUrl: 'http://www.omdbapi.com/?i=tt4154796&apikey=84f704f1'));
            listMoviesApi.add(ListMoviesApi(id: 'tt4154664', apiUrl: 'http://www.omdbapi.com/?i=tt4154664&apikey=84f704f1'));
            listMoviesApi.add(ListMoviesApi(id: 'tt5095030', apiUrl: 'http://www.omdbapi.com/?i=tt5095030&apikey=84f704f1'));
            listMoviesApi.add(ListMoviesApi(id: 'tt4154756', apiUrl: 'http://www.omdbapi.com/?i=tt4154756&apikey=84f704f1'));
            listMoviesApi.add(ListMoviesApi(id: 'tt1825683', apiUrl: 'http://www.omdbapi.com/?i=tt1825683&apikey=84f704f1'));
            listMoviesApi.add(ListMoviesApi(id: 'tt3501632', apiUrl: 'http://www.omdbapi.com/?i=tt3501632&apikey=84f704f1'));
            listMoviesApi.add(ListMoviesApi(id: 'tt2250912', apiUrl: 'http://www.omdbapi.com/?i=tt2250912&apikey=84f704f1'));
            listMoviesApi.add(ListMoviesApi(id: 'tt2015381', apiUrl: 'http://www.omdbapi.com/?i=tt2015381&apikey=84f704f1'));
            listMoviesApi.add(ListMoviesApi(id: 'tt1211837', apiUrl: 'http://www.omdbapi.com/?i=tt1211837&apikey=84f704f1'));
            listMoviesApi.add(ListMoviesApi(id: 'tt3498820', apiUrl: 'http://www.omdbapi.com/?i=tt3498820&apikey=84f704f1'));
        }

        if (indexListActive == ListCategoryMovies.dc) {

        }

        return listMoviesApi;
    }

    @override
    Widget build(BuildContext context) {
        return Container(
            margin: EdgeInsets.only(left: 10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    tabLine(),
                    listItemMovies(),
                ],
            )
        );
    }

    Widget tabLine() {
        return Container(
            height: MediaQuery.of(context).size.height * 0.053,
            margin: EdgeInsets.only(bottom: 15),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.list.length,
                itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                        onTap: () {
                            reCreateList(index);
                        },
                        child: Container(
                            padding: (index == 0) ? EdgeInsets.only(top: 10, bottom: 10, right: 10) : EdgeInsets.all(10),
                            child: Text(widget.list[index].nama),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.purple,
                                        width: (widget.list[index].active) ? 5 : 1,
                                    )
                                )
                            )
                        ),
                    );
                },
            )
        );
    }

    Widget listItemMovies() {
        return Container(
            height: MediaQuery.of(context).size.height * 0.33,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: reCreateListMoviesApi().length,
                itemBuilder: (BuildContext context, int index) {
                    return cardItemMoviesBuilder(listMoviesApi[index].apiUrl);
                },
                
            )
        );
    }

    Widget cardItemMovies(Movies movies) {
        String titleMovies = (movies != null) ? movies.title + '\n' + movies.year : 'Loading . . .';
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
                Expanded(
                    child: (movies != null) ? showCardMovies(movies) : showLoadCard(),
                ),
                Container(
                    width: MediaQuery.of(context).size.width * 0.35,
                    height: MediaQuery.of(context).size.height * 0.055,
                    padding: EdgeInsets.all(5),
                    child: Text(
                        titleMovies, textAlign: TextAlign.center,
                        style: TextStyle( 
                            fontWeight: FontWeight.w700,
                            color: Colors.purple[600]
                        ),
                    )
                )
            ]
        );
    }

    Widget showCardMovies(Movies movies) {
        return Container(
            width: MediaQuery.of(context).size.width * 0.35,
            margin: EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(movies.poster),
                    fit: BoxFit.cover,
                ),
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
                boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade400,
                        blurRadius: 2,
                        spreadRadius: 0.0,
                        offset: Offset(2.0, 2.0), // shadow direction: bottom right
                    )
                ],
            ),               
        );
    }

    Widget showLoadCard() {
        return Container(
            width: MediaQuery.of(context).size.width * 0.35,
            margin: EdgeInsets.only(right: 20),
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
                boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade400,
                        blurRadius: 2,
                        spreadRadius: 0.0,
                        offset: Offset(2.0, 2.0), // shadow direction: bottom right
                    )
                ],
            ),
            alignment: Alignment.center,
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white60),
            )                
        );
    }

    FutureBuilder cardItemMoviesBuilder(String apiUrl) {
        return FutureBuilder(
            future: getMoviesApi(apiUrl),
            builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
                Movies movies = asyncSnapshot.data;

                return cardItemMovies(movies);
            },
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
                    runtime : responseBody['Runtime'],
                    genre : responseBody['Genre'],
                    director : responseBody['Director'],
                    writer : responseBody['Writer'],
                    actors : responseBody['Actors'],
                    plot : responseBody['Plot'],
                    language : responseBody['Language'],
                    country : responseBody['Country'],
                    awards : responseBody['Awards'],
                    poster : responseBody['Poster'],
                    metascore : responseBody['Metascore'],
                    imdbRating : responseBody['imdbRating'],
                    imdbVotes : responseBody['imdbVotes'],
                    imdbID : responseBody['imdbID'],
                    type : responseBody['Type'],
                );

                return movies;
            }

        } catch (e) {
            print(e.toString());
        } 
    }
}