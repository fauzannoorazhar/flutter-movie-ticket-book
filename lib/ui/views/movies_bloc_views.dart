import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mf_movie_ticket_book/bloc/movies/movies_bloc.dart';
import 'package:mf_movie_ticket_book/bloc/movies/movies_event.dart';
import 'package:mf_movie_ticket_book/bloc/movies/movies_state.dart';
import 'package:mf_movie_ticket_book/data/domain/movies_domain.dart';
import 'package:mf_movie_ticket_book/data/repository/movies_repository.dart';
import 'package:mf_movie_ticket_book/models/Movies.dart';

class MoviesBlocViews extends StatefulWidget {
    Movies movies;

    MoviesBlocViews({
        this.movies,
        Key key
    }) : super(key: key);

    @override
    _MoviesBlocViewsState createState() => _MoviesBlocViewsState();
}

class _MoviesBlocViewsState extends State<MoviesBlocViews> {
    MoviesBloc moviesBloc;
    MoviesDomain moviesDomain;

    @override
    void initState() { 
        super.initState();
        moviesDomain = new MoviesDomain(MoviesRepository(apiUrlMovies: 'http://www.omdbapi.com/?i=tt4154796&apikey=84f704f1'));
        moviesBloc = new MoviesBloc(moviesDomain: moviesDomain);
    }

    @override
    Widget build(BuildContext context) {
        moviesBloc.add(MoviesFetching());
        
        return Scaffold(
            appBar: AppBar(
                title: Text('Example Bloc'),
            ),
            body: BlocProvider(
                create: (BuildContext context) {
                    return moviesBloc;
                },
                child: BlocListener<MoviesBloc, MoviesState> (
                    bloc: moviesBloc,
                    listener: (BuildContext context, MoviesState state) {
                        if (state is MoviesFetchError) {
                            print(state.error.toString());
                            Scaffold.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('${state.error}'),
                                    backgroundColor: Colors.red,
                                ),
                            );
                        }
                    },
                    child: new BlocBuilder<MoviesBloc, MoviesState>(
                        bloc: moviesBloc,
                        builder: (BuildContext context, MoviesState state) {
                            if (state is MoviesFetchSuccess) {
                                return moviesLoadSuccess(state.movies);
                            } else {
                                return Center(
                                    child: CircularProgressIndicator(),
                                );
                            }
                        },
                    ),
                ),
            )
        );
    }

    Widget moviesLoadSuccess(Movies movies) {
        return Center(
            child: Text(
                (this.widget.movies != null) ? this.widget.movies.title : movies.title
            ),
        );
    }
}