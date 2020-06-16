import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mf_movie_ticket_book/models/BookingHour.dart';
import 'package:mf_movie_ticket_book/models/CinemaLocation.dart';
import 'package:mf_movie_ticket_book/models/DateTimeBooking.dart';
import 'package:mf_movie_ticket_book/models/Movies.dart';
import 'package:mf_movie_ticket_book/models/UserBookingMovies.dart';
import 'package:mf_movie_ticket_book/ui/views/movies_selectedseat_page.dart';
import 'package:mf_movie_ticket_book/ui/widgets/button_selected_date.dart';
import 'package:mf_movie_ticket_book/ui/widgets/button_selected_time.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:toast/toast.dart';

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

    String dateBooking;
    UserBookingMovies userBookingMovies = new UserBookingMovies();
    bool panelState = false;
    PanelController panelController = new PanelController();

    @override
    void initState() {
    // TODO: implement initState
        super.initState();
        initListDateTimeBooking();
        setListCinemaLocation();

        // initialize object
        this.userBookingMovies.movies = this.widget.movies;
        this.userBookingMovies.user = 'Muhammad Fauzan';
        this.userBookingMovies.seats = 0;
    }

    void setUserBookingMovies(BookingHour bookingHour, DateTimeBooking dateTimeBooking) {
        setState(() {
            if (bookingHour != null) {
                this.userBookingMovies.bookingHour = bookingHour;
            }
            if (dateTimeBooking != null) {
                this.userBookingMovies.dateTimeBooking = dateTimeBooking;
            }
        });
    }

    void setTicketState(String string) {
        setState(() {
            this.userBookingMovies.ticketState = string;
        });
    }

    void plusSeat() {
        setState(() {
            this.userBookingMovies.seats += 1;
        });
    }

    void minusSeat() {
        if (this.userBookingMovies.seats > 0) {
            setState(() {
                this.userBookingMovies.seats -= 1;
            });
        }
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
            body: getBody(),
            floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                    if (this.userBookingMovies.dateTimeBooking != null && this.userBookingMovies.bookingHour != null) {
                        if (panelController.isPanelOpen) {
                            // show dialog
                            if (this.userBookingMovies.validate()) {
                                Navigator.push(context, MaterialPageRoute(builder: (_) => MoviesSelectedseatPage(userBookingMovies: this.userBookingMovies)));
                            } else {
                                return Toast.show("Ada yang belum terisi", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                            }
                            panelController.close();
                        } else if (panelController.isPanelClosed) {
                            panelController.open();
                        }
                    } else {
                        return Toast.show("Please selected date booking", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                    }
                },
                icon: FaIcon(FontAwesomeIcons.ticketAlt),
                label: Text('Buy Ticket'),
            )
        );
    }

    Widget getBody() {
        return Stack(
            children: [
                Column(
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
                                            child: ButtonSelectedDate(
                                                listDateTimeBooking: this.listDateTimeBooking,
                                                setUserBookingMovies: this.setUserBookingMovies,
                                            )
                                        ),
                                        SizedBox(height: 35),
                                        Expanded(
                                            child: ButtonSelectedTime(
                                                listCinemaLocation: this.listCinemaLocation,
                                                setUserBookingMovies: this.setUserBookingMovies
                                            )
                                        )
                                    ],
                                ),
                            ),
                        )
                    ],
                ),
                slidingUpPanel()
            ],
        );
    }

    SlidingUpPanel slidingUpPanel() {
        return SlidingUpPanel(
            minHeight: 0,
            maxHeight: 300,
            renderPanelSheet: false,
            onPanelOpened: () {},
            controller: this.panelController,
            panel: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25)
                    ),
                    boxShadow: [
                        BoxShadow(
                            blurRadius: 20.0,
                            color: Colors.black54
                        ),
                    ]
                ),
                alignment: Alignment.center,
                padding: EdgeInsets.all(20),
                child: Column(
                    children: [
                        Text(
                            'How many seats?',
                            style: TextStyle(
                                fontSize: 18,
                            ),
                        ),
                        SizedBox(height: 20),
                        Container(
                            width: 200,
                            alignment: Alignment.center,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                    Expanded(
                                        flex: 1,
                                        child: FlatButton(
                                            onPressed: () {
                                                minusSeat();
                                            },
                                            child: FaIcon(
                                                FontAwesomeIcons.minus,
                                                size: 15,
                                                color: Colors.black,
                                            ),
                                            splashColor: Colors.purple,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(100),
                                                side: BorderSide(
                                                    color: Colors.purple,
                                                ),
                                            ),
                                        )
                                    ),
                                    Expanded(
                                        flex: 2,
                                        child: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                                this.userBookingMovies.seats.toString(),
                                                style: TextStyle(
                                                    fontSize: 35,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.purple
                                                ),
                                            ),
                                        )
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: FlatButton(
                                            onPressed: () {
                                                plusSeat();
                                            },
                                            child: FaIcon(
                                                FontAwesomeIcons.plus,
                                                size: 15,
                                                color: Colors.black,
                                            ),
                                            splashColor: Colors.purple,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(100),
                                                side: BorderSide(
                                                    color: Colors.purple,
                                                ),
                                            ),
                                        )
                                    ),
                                ],
                            )
                        ),
                        Divider(height: 50, thickness: 1.2),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: this.userBookingMovies.getButtonTicketState(setTicketState)
                        )
                    ],
                ),
            ),
        );
    }
}