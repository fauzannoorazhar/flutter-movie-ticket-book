import 'package:equatable/equatable.dart';
import 'package:mf_movie_ticket_book/models/Movies.dart';

abstract class MoviesState extends Equatable {
    const MoviesState();
}

class MoviesFetchLoading extends MoviesState {
    @override
    List<Object> get props => [];
}

class MoviesFetchSuccess extends MoviesState {
    final Movies movies;

    const MoviesFetchSuccess({this.movies});

    @override
    List<Object> get props => [];
}

class MoviesFetchError extends MoviesState {
    final String error;

    const MoviesFetchError({this.error});

    @override
    List<Object> get props => [];

    @override
    @override
    String toString() {
        return 'Failure {error : $error }';
    }
}

abstract class MoviesListState extends Equatable {
    const MoviesListState();
}

class MoviesFetchSuccessList extends MoviesListState {
    final List<Movies> lisMovies;

    const MoviesFetchSuccessList({this.lisMovies});

    @override
    List<Object> get props => [];
}

class MoviesFetchLoadingList extends MoviesListState {
    @override
    List<Object> get props => [];
}

class MoviesFetchErrorList extends MoviesListState {
    final String error;

    const MoviesFetchErrorList({this.error});

    @override
    List<Object> get props => [];

    @override
    @override
    String toString() {
        return 'Failure {error : $error }';
    }
}