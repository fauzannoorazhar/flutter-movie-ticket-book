import 'package:flutter/material.dart';
import 'package:mf_movie_ticket_book/models/ListCategoryMovies.dart';
import 'package:mf_movie_ticket_book/models/Movies.dart';
import 'package:mf_movie_ticket_book/ui/views/movies_bloc_views.dart';
import 'package:mf_movie_ticket_book/ui/views/movies_detail_page.dart';
import 'package:mf_movie_ticket_book/ui/widgets/card_movies.dart';

class TabMovies extends StatefulWidget {
    List<ListCategoryMovies> listCategoryMovies;
    List<Movies> listMovies;
    int indexCategoryActive;

    TabMovies({
        @required this.listCategoryMovies,
        @required this.listMovies,
        this.indexCategoryActive = 0,
    });

    @override
    _TabMoviesState createState() => _TabMoviesState();
}

class _TabMoviesState extends State<TabMovies> {
    int indexListActive = 0;

     @override
    Widget build(BuildContext context) {
        return Container(
            margin: EdgeInsets.only(left: 10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    headerTabLine(),
                    contentMoviesTabLine(),
                ],
            )
        );
    }

    Widget headerTabLine() {
        return Container(
            height: MediaQuery.of(context).size.height * 0.053,
            margin: EdgeInsets.only(bottom: 15),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: this.widget.listCategoryMovies.length,
                itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                        onTap: () {
                            updateListCategoryMoviesActive(index);
                        },
                        child: Container(
                            padding: (index == 0) ? EdgeInsets.only(top: 10, bottom: 10, right: 10) : EdgeInsets.all(10),
                            child: Text(this.widget.listCategoryMovies[index].name),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.purple,
                                        width: (this.widget.listCategoryMovies[index].active) ? 5 : 1,
                                    )
                                )
                            )
                        ),
                    );
                }
            ),
        );
    }

    void updateListCategoryMoviesActive(int newListActiveIndex) {
        setState(() {
            this.widget.listCategoryMovies.forEach((element) {
                element.active = false;
            });
            this.widget.listCategoryMovies[newListActiveIndex].active = true;
            indexListActive = newListActiveIndex;
        });
    }

    Widget contentMoviesTabLine() {
        return Container(
            height: MediaQuery.of(context).size.height * 0.33,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: this.widget.listMovies.length,
                itemBuilder: (BuildContext context, int index) {
                    Movies movies = this.widget.listMovies[index];

                    return InkWell(
                        onTap: () {
                            return Navigator.push(
                                context, MaterialPageRoute(builder: (_) => MoviesDetailPage(movies: movies)));
                        },
                        child: CardMovies(movies: movies),
                    );
                },
            )
        );
    }
}