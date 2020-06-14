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