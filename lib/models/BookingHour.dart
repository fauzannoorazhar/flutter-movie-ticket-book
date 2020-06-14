import 'package:mf_movie_ticket_book/models/CinemaLocation.dart';

class BookingHour {
    String hour;
    int status;
    DateTime dateTime;
    CinemaLocation cinemaLocation;

    static const int available = 1;
    static const int fillingFast = 1;
    static const int almostFull = 1;


    BookingHour({
        this.hour,
        this.status,
        this.dateTime,
        this.cinemaLocation,
    });
}