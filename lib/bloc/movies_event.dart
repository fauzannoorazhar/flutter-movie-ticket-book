import 'package:equatable/equatable.dart';

abstract class MoviesEvent extends Equatable {
    const MoviesEvent();

    @override
    List<Object> get props => [];
}

class MoviesFetching extends MoviesEvent {}

abstract class MoviesEventList extends Equatable {
    const MoviesEventList();

    @override
    List<Object> get props => [];
}

class MoviesFetchingList extends MoviesEventList {}