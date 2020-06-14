import 'package:dio/dio.dart';
import 'package:mf_movie_ticket_book/models/Movies.dart';
import 'package:mf_movie_ticket_book/utilities/constants.dart';

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

    Future<List<Movies>> getListMoviesTabHomePage() async {
        try {
            // final response = await Future.wait([
            //     dio.get(apiUrl + '?t=tt3480822&apiKey=' + apiKey),
            //     dio.get(apiUrl + '?t=tt9032400&apiKey=' + apiKey)
            // ]);

            final response = await dio.get(apiUrl + '?i=tt3480822&apiKey=' + apiKey);

            List<Movies> list = new List<Movies>();
            list.add(Movies.fecthData(response.data));

            return list;
        } catch (e) {
            return e;
        }
    }
}