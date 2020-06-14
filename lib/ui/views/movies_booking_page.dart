import 'package:flutter/material.dart';
import 'package:mf_movie_ticket_book/models/BookingHour.dart';
import 'package:mf_movie_ticket_book/models/CinemaLocation.dart';
import 'package:mf_movie_ticket_book/models/ListDateTime.dart';
import 'package:mf_movie_ticket_book/models/Movies.dart';

class MoviesBookingPage extends StatefulWidget {
    Movies movies;
    
    MoviesBookingPage({
        this.movies
    });

    @override
    _MoviesBookingPageState createState() => _MoviesBookingPageState();
}

class _MoviesBookingPageState extends State<MoviesBookingPage> {
    var textButtonColor = Colors.black;
    var buttonSelect = false;
    var colorButton = Colors.white;
    DateTime selectDateBooking;

    List<ListDateTime> listDateTime = new List<ListDateTime>();
    List<CinemaLocation> listCinemaLocation = new List<CinemaLocation>();
    List<BookingHour> listBookingHour = new List<BookingHour>();

    @override
    void initState() {
    // TODO: implement initState
        super.initState();
        setListDateTime();
        setListCinemaLocation();
    }

    void setListCinemaLocation() {
        listCinemaLocation.add(new CinemaLocation(
            name: 'Cihampelas (Ciwalk)',
            distance: 3.2,
            typeDistance: 'Km',
            listBookingHours: getListBookingHourCiwalk()
        ));

        // set ulang listBookingHour
        listBookingHour = new List<BookingHour>();
        listCinemaLocation.add(new CinemaLocation(
            name: 'Bandung Indah Plaza (BIP)',
            distance: 5.2,
            typeDistance: 'Km',
            listBookingHours: getListBookingHourBIP()
        ));

        // set ulang listBookingHour
        listBookingHour = new List<BookingHour>();
    }

    List<BookingHour> getListBookingHourCiwalk() {
        listBookingHour.add(new BookingHour(
            hour: '09:30 AM',
            status: BookingHour.almostFull,
            dateTime: DateTime.now(),
        ));
        listBookingHour.add(new BookingHour(
            hour: '12:30 AM',
            status: BookingHour.available,
            dateTime: DateTime.now(),
        ));
        listBookingHour.add(new BookingHour(
            hour: '03:00 AM',
            status: BookingHour.available,
            dateTime: DateTime.now(),
        ));
        listBookingHour.add(new BookingHour(
            hour: '08:40 AM',
            status: BookingHour.available,
            dateTime: DateTime.now(),
        ));

        return listBookingHour;
    }

    List<BookingHour> getListBookingHourBIP() {
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

    void setListDateTime() {
        final items = List<DateTime>.generate(10, (i) =>
        DateTime.utc(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
        ).add(Duration(days: i)));

        items.forEach((element) {
            listDateTime.add(new ListDateTime(dateTime: element));
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
            floatingActionButton: FloatingActionButton(
                onPressed: () {
                    print(listDateTime.length);
                    print(listCinemaLocation.length);
                    listCinemaLocation.forEach((element) {
                        print(element.listBookingHours.length); 
                    });
                },
                child: Text('click'),
            ),
            body: SingleChildScrollView(
                child: Column(
                    children: [
                        Container(
                            height: 100,
                            padding: EdgeInsets.all(10),
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: listDateTime.length,
                                itemBuilder: (BuildContext context, int index) {
                                    ListDateTime dateTimeList = listDateTime[index];

                                    return ButtonSelectedBooking(
                                        listDateTime: dateTimeList,
                                        buttonSelect: buttonSelect,
                                        textButtonColor: textButtonColor,
                                        colorButton: colorButton,
                                    );
                                }
                            ),
                        )
                    ],
                ),
            )
        );
    }
}

class ButtonSelectedBooking extends StatefulWidget {
    var textButtonColor;
    var buttonSelect;
    var colorButton;
    ListDateTime listDateTime;
    
    ButtonSelectedBooking({
        @required this.textButtonColor,
        @required this.buttonSelect,
        @required this.colorButton,
        @required this.listDateTime
    });

    @override
    _ButtonSelectedBookingState createState() => _ButtonSelectedBookingState();
}

class _ButtonSelectedBookingState extends State<ButtonSelectedBooking> {
    @override
    Widget build(BuildContext context) {
        return Container(
            height: 85,
            width: 85,
            margin: EdgeInsets.only(right: 15),
            child: FlatButton(
                textColor: this.widget.textButtonColor,
                color: this.widget.colorButton,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Text(
                            this.widget.listDateTime.getDayName(),
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                            ),
                        ),
                        SizedBox(height: 5),
                        Text(
                            this.widget.listDateTime.dateTime.day.toString(),
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                            ),
                        )
                    ],
                ),
                onPressed: () {
                    if (this.widget.buttonSelect) {
                        setState(() {
                            this.widget.buttonSelect = false;
                            this.widget.textButtonColor = Colors.black;
                            this.widget.colorButton = Colors.white;
                        });
                    } else {
                        setState(() {
                            this.widget.buttonSelect = true;
                            this.widget.textButtonColor = Colors.white;
                            this.widget.colorButton = Colors.purple;
                        });
                    }
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10 
                    ),
                    side: BorderSide(
                        color: Colors.purple,
                    ),
                ),
                highlightColor: Colors.purple,
            )
        );
    }
}