import 'package:dio/dio.dart';
import 'package:mf_movie_ticket_book/models/Movies.dart';

class MoviesRepository {
    Dio dio = Dio();

    Future<Movies> getPopularMovies() async {
        try {
            final response = await dio.get('http://www.omdbapi.com/?i=tt4154796&apikey=84f704f1');
            return Movies.fecthData(response.data);
        } catch (e) {
            return e;
        }
    }
}