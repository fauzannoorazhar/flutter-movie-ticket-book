import 'package:equatable/equatable.dart';

abstract class MoviesEvent extends Equatable {
    const MoviesEvent();

    @override
    List<Object> get props => [];
}

class MoviesFetching extends MoviesEvent {}

abstract class MoviesListEvent extends Equatable {
    const MoviesListEvent();

    @override
    List<Object> get props => [];
}

class MoviesListFetching extends MoviesListEvent {}