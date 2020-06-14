import 'package:flutter/material.dart';
import 'package:mf_movie_ticket_book/models/Movies.dart';
import 'package:mf_movie_ticket_book/ui/views/movies_detail_page.dart';

class CardMovies extends StatelessWidget {
    Movies movies;

    CardMovies({
        @required this.movies
    });

    @override
    Widget build(BuildContext context) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
                Expanded(
                    child: InkWell(
                        onTap: () {
                            //return Navigator.push(context, MaterialPageRoute(builder: (_) => MoviesDetailPage(movies: movies)));
                        },
                        child: Container(
                            width: MediaQuery.of(context).size.width * 0.35,
                            margin: EdgeInsets.only(right: 20),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(this.movies.poster),
                                    fit: BoxFit.cover,
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
                        )
                    ),
                ),
                Container(
                    width: MediaQuery.of(context).size.width * 0.35,
                    height: MediaQuery.of(context).size.height * 0.055,
                    padding: EdgeInsets.all(5),
                    child: Text(
                        this.movies.title + '\n' + this.movies.year, textAlign: TextAlign.center,
                        style: TextStyle( 
                            fontWeight: FontWeight.w700,
                            color: Colors.purple[600]
                        ),
                    )
                )
            ]
        );
    }
}