import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mf_movie_ticket_book/bloc/movies/movies_event.dart';
import 'package:mf_movie_ticket_book/bloc/movies/movies_state.dart';
import 'package:mf_movie_ticket_book/data/domain/movies_domain.dart';
import 'package:mf_movie_ticket_book/models/Movies.dart';

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

class MoviesListBloc extends Bloc<MoviesListEvent, MoviesListState> {
    final MoviesListDomain moviesListDomain;
    final Future futureMethod; 

    MoviesListBloc({
        this.moviesListDomain,
        this.futureMethod
    });

    @override
    MoviesListState get initialState => MoviesFetchLoadingList();

    @override
    Stream<MoviesListState> mapEventToState(MoviesListEvent event) async* {
        if (event is MoviesListFetching) {
            yield MoviesFetchLoadingList();

            try {
                List<Movies> listMovies = await this.futureMethod;
                yield MoviesFetchSuccessList(lisMovies: listMovies);
            } catch (e) {
                yield MoviesFetchErrorList(error: e.toString());
            }
        }
    }
}