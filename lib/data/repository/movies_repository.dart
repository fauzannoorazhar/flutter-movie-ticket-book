import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:mf_movie_ticket_book/models/Movies.dart';
import 'package:mf_movie_ticket_book/utilities/constants.dart';

class MoviesRepository {
    String apiUrlMovies;
    
    MoviesRepository({@required this.apiUrlMovies});

    Dio dio = Dio();

    Future<Movies> getPopularMovies() async {
        try {
            final response = await dio.get(this.apiUrlMovies);
            return Movies.fecthData(response.data);
        } catch (e) {
            return e;
        }
    }
}

class MoviesListRepository {
    Dio dio = Dio();

    Future<List<Movies>> getListMoviesTabHomePage() async {
        try {
            final response = await Future.wait([
                dio.get(apiUrl + '?i=tt4154796&apikey=' + apiKey),
                dio.get(apiUrl + '?i=tt4154664&apikey=' + apiKey),
                dio.get(apiUrl + '?i=tt5095030&apikey=' + apiKey),
                dio.get(apiUrl + '?i=tt4154756&apikey=' + apiKey),
                dio.get(apiUrl + '?i=tt1825683&apikey=' + apiKey),
                dio.get(apiUrl + '?i=tt3501632&apikey=' + apiKey),
                dio.get(apiUrl + '?i=tt2250912&apikey=' + apiKey),
                dio.get(apiUrl + '?i=tt2015381&apikey=' + apiKey),
                dio.get(apiUrl + '?i=tt1211837&apikey=' + apiKey),
                dio.get(apiUrl + '?i=tt3498820&apikey=' + apiKey),
            ]);

            List<Movies> list = new List<Movies>();
            response.toList().forEach((element) {
                list.add(Movies.fecthData(element.data));
                print('element : ' + element.data['Ratings'].toString());
            });

            return list;
        } catch (e) {
            return e;
        }
    }
}