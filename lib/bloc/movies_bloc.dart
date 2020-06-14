import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mf_movie_ticket_book/bloc/movies_event.dart';
import 'package:mf_movie_ticket_book/bloc/movies_state.dart';
import 'package:mf_movie_ticket_book/data/domain/movies_domain.dart';
import 'package:mf_movie_ticket_book/models/Movies.dart';
import 'package:mf_movie_ticket_book/ui/views/movies_booking_page.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
    final MoviesDomain moviesDomain;

    MoviesBloc({this.moviesDomain});

    @override
    MoviesState get initialState => MoviesFetchLoading();

    @override
    Stream<MoviesState> mapEventToState(MoviesEvent event) async* {
        if (event is MoviesFetching) {
            yield MoviesFetchLoading();

            try {
                Movies movies = await moviesDomain.getMoviesPopular();
                yield MoviesFetchSuccess(movies: movies);
            } catch (e) {
                yield MoviesFetchError(error: e.toString());
            }
        }
    }
}

class MoviesListBloc extends Bloc<MoviesEventList, MoviesState> {
    final MoviesDomainList moviesDomainList;

    MoviesListBloc({this.moviesDomainList});

    @override
    MoviesState get initialState => MoviesFetchLoading();

    @override
    Stream<MoviesState> mapEventToState(MoviesEventList event) async* {
        if (event is MoviesFetching) {
            yield MoviesFetchLoading();

            try {
                List<Movies> listMovies = await moviesDomainList.getListMovies();
                yield MoviesFetchSuccessList(lisMovies: listMovies);
            } catch (e) {
                yield MoviesFetchError(error: e.toString());
            }
        }
    }
}