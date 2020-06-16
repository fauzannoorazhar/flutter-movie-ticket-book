import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mf_movie_ticket_book/models/BookingHour.dart';
import 'package:mf_movie_ticket_book/models/DateTimeBooking.dart';
import 'package:mf_movie_ticket_book/models/Movies.dart';

class UserBookingMovies {
    static const String platinum = 'platinum';
    static const String gold = 'gold';
    static const String silver = 'silver';

    Movies movies;
    String user;
    DateTimeBooking dateTimeBooking;
    BookingHour bookingHour;
    DateTime submitTime;
    int seats;
    double ticketPrice;
    String ticketState;

    UserBookingMovies({
        this.movies,
        this.user,
        this.dateTimeBooking,
        this.bookingHour,
        this.submitTime,
        this.seats,
        this.ticketPrice,
        this.ticketState
    });

    static String getUcWords(String string) {
        return '${string[0].toUpperCase()}${string.substring(1).toLowerCase()}';
    }

    List<Widget> getButtonTicketState(Function function) {
        List list = new List<Widget>();
        list.add(
            FlatButton(
                onPressed: () {
                    function(UserBookingMovies.platinum);
                },
                color: (this.ticketState == UserBookingMovies.platinum) ? Colors.purple : Colors.cyan,
                child: Text(
                    UserBookingMovies.getUcWords(UserBookingMovies.platinum) + ' Rp.80.000',
                    style: TextStyle(
                        color: (this.ticketState == UserBookingMovies.platinum) ? Colors.white : Colors.black,
                        fontSize: 10
                    ),
                ),
                splashColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                ),
            )
        );
        list.add(
            FlatButton(
                onPressed: () {
                    function(UserBookingMovies.gold);
                },
                color: (this.ticketState == UserBookingMovies.gold) ? Colors.purple : Colors.yellow,
                child: Text(
                    UserBookingMovies.getUcWords(UserBookingMovies.gold) + ' Rp.65.000',
                    style: TextStyle(
                        color: (this.ticketState == UserBookingMovies.gold) ? Colors.white : Colors.black,
                        fontSize: 10
                    ),
                ),
                splashColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                ),
            )
        );
        list.add(
            FlatButton(
                onPressed: () {
                    function(UserBookingMovies.silver);
                },
                color: (this.ticketState == UserBookingMovies.silver) ? Colors.purple : Colors.black12,
                child: Text(
                    UserBookingMovies.getUcWords(UserBookingMovies.silver) + ' Rp.45.000',
                    style: TextStyle(
                        color: (this.ticketState == UserBookingMovies.silver) ? Colors.white : Colors.black,
                        fontSize: 10
                    ),
                ),
                splashColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                ),
            )
        );

        return list;
    }

    bool validate() {
        if (
            this.movies != null && 
            this.user != null && 
            this.dateTimeBooking != null && 
            this.bookingHour != null && 
            this.seats != null && 
            this.ticketState != null) {
            return true;
        }

        return false;
    }
}