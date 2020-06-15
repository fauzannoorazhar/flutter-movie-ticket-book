import 'package:mf_movie_ticket_book/data/repository/movies_repository.dart';
import 'package:mf_movie_ticket_book/models/Movies.dart';

class MoviesDomain {
    final MoviesRepository moviesRepository;

    MoviesDomain(this.moviesRepository);

    Future<Movies> getMoviesPopular() {
        return moviesRepository.getPopularMovies();
    }
}

class MoviesListDomain {
    final MoviesListRepository moviesListRepository;

    MoviesListDomain(this.moviesListRepository);

    Future<List<Movies>> getListMoviesTabHomePage() {
        return moviesListRepository.getListMoviesTabHomePage();
    }

    Future<List<Movies>> getListMoviesHomeSlider() {
        return moviesListRepository.getListMoviesHomeSlider();
    }
}