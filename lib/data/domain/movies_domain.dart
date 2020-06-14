import 'package:mf_movie_ticket_book/data/repository/movies_repository.dart';
import 'package:mf_movie_ticket_book/models/Movies.dart';

class MoviesDomain {
    final MoviesRepository moviesRepository;

    MoviesDomain(this.moviesRepository);

    Future<Movies> getMoviesPopular() {
        return moviesRepository.getPopularMovies();
    }
}