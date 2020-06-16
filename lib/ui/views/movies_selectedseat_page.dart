import 'package:flutter/material.dart';
import 'package:mf_movie_ticket_book/models/UserBookingMovies.dart';

class MoviesSelectedseatPage extends StatefulWidget {
    final UserBookingMovies userBookingMovies;

    MoviesSelectedseatPage({
        this.userBookingMovies
    });

    @override
    _MoviesSelectedseatPageState createState() => _MoviesSelectedseatPageState();
}

class _MoviesSelectedseatPageState extends State<MoviesSelectedseatPage> {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text(this.widget.userBookingMovies.movies.title),
            ),
            body: Center(
                child: Text('Jumlah kursi yang dipilih : ' + this.widget.userBookingMovies.seats.toString()),
            ),
        );
    }
}