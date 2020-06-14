import 'package:mf_movie_ticket_book/models/BookingHour.dart';

class CinemaLocation {
    String name;
    double distance;
    String typeDistance;
    List<BookingHour> listBookingHours;

    CinemaLocation({
        this.name,
        this.distance,
        this.typeDistance,
        this.listBookingHours,
    });
}