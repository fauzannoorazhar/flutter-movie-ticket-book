import 'package:flutter/material.dart';
import 'package:mf_movie_ticket_book/models/BookingHour.dart';
import 'package:mf_movie_ticket_book/models/CinemaLocation.dart';
import 'package:mf_movie_ticket_book/models/DateTimeBooking.dart';
import 'package:mf_movie_ticket_book/models/Movies.dart';
import 'package:mf_movie_ticket_book/ui/widgets/button_selected_date.dart';
import 'package:mf_movie_ticket_book/ui/widgets/button_selected_time.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MoviesBookingPage extends StatefulWidget {
    final Movies movies;
    
    MoviesBookingPage({
        this.movies
    });

    @override
    _MoviesBookingPageState createState() => _MoviesBookingPageState();
}

class _MoviesBookingPageState extends State<MoviesBookingPage> {
    List<DateTimeBooking> listDateTimeBooking = new List<DateTimeBooking>();
    List<CinemaLocation> listCinemaLocation = new List<CinemaLocation>();
    List<BookingHour> listBookingHour = new List<BookingHour>();

    @override
    void initState() {
    // TODO: implement initState
        super.initState();
        initListDateTimeBooking();
        setListCinemaLocation();
    }

    void setListCinemaLocation() {
        listCinemaLocation.add(new CinemaLocation(
            name: 'Cihampelas (Ciwalk)',
            distance: 3.2,
            typeDistance: 'Km',
            listBookingHours: getListBookingHour()
        ));

        // set ulang listBookingHour
        listBookingHour = new List<BookingHour>();
        listCinemaLocation.add(new CinemaLocation(
            name: 'Bandung Indah Plaza (BIP)',
            distance: 5.2,
            typeDistance: 'Km',
            listBookingHours: getListBookingHour()
        ));

        // set ulang listBookingHour
        listBookingHour = new List<BookingHour>();
        listCinemaLocation.add(new CinemaLocation(
            name: 'Paris Van Java (PVJ)',
            distance: 5.2,
            typeDistance: 'Km',
            listBookingHours: getListBookingHour()
        ));

        // set ulang listBookingHour
        listBookingHour = new List<BookingHour>();
        listCinemaLocation.add(new CinemaLocation(
            name: 'Bandung Trade Mall (BTC)',
            distance: 5.2,
            typeDistance: 'Km',
            listBookingHours: getListBookingHour()
        ));
    }

    List<BookingHour> getListBookingHour() {
        listBookingHour.add(new BookingHour(
            hour: '08:00 AM',
            status: BookingHour.almostFull,
            dateTime: DateTime.now(),
        ));
        listBookingHour.add(new BookingHour(
            hour: '11:00 AM',
            status: BookingHour.fillingFast,
            dateTime: DateTime.now(),
        ));
        listBookingHour.add(new BookingHour(
            hour: '02:30 AM',
            status: BookingHour.available,
            dateTime: DateTime.now(),
        ));
        listBookingHour.add(new BookingHour(
            hour: '07:00 AM',
            status: BookingHour.available,
            dateTime: DateTime.now(),
        ));
        listBookingHour.add(new BookingHour(
            hour: '09:00 AM',
            status: BookingHour.available,
            dateTime: DateTime.now(),
        ));

        return listBookingHour;
    }

    void initListDateTimeBooking() {
        final items = List<DateTime>.generate(10, (i) =>
        DateTime.utc(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
        ).add(Duration(days: i)));

        items.forEach((dateTime) {
            listDateTimeBooking.add(
                new DateTimeBooking(dateTime: dateTime, selected: false)
            );
        });
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text(
                    widget.movies.title,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor
                    ),
                ),
                elevation: 0,
                backgroundColor: Colors.white,
                iconTheme: IconThemeData(color: Theme.of(context).primaryColor)
            ),
            backgroundColor: Colors.white,
            body: Column(
                children: [
                    Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                            color: Colors.purple,
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                    Colors.purple,
                                    Colors.deepPurpleAccent,
                                ]
                            ),
                        ),
                    ),
                    Expanded(
                        child: Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Column(
                                children: [
                                    Container(
                                        height: MediaQuery.of(context).size.height * 0.11,
                                        child: ButtonSelectedDate(listDateTimeBooking: listDateTimeBooking)
                                    ),
                                    SizedBox(height: 35),
                                    Expanded(
                                        child: ButtonSelectedTime(listCinemaLocation: this.listCinemaLocation)
                                    )
                                ],
                            ),
                        ),
                    )
                ],
            )
        );
    }
}