import 'package:flutter/material.dart';
import 'package:mf_movie_ticket_book/models/BookingHour.dart';
import 'package:mf_movie_ticket_book/models/CinemaLocation.dart';

class ButtonSelectedTime extends StatefulWidget {
    final List<CinemaLocation> listCinemaLocation;
    
    ButtonSelectedTime({
        @required this.listCinemaLocation
    });

    @override
    _ButtonSelectedTimeState createState() => _ButtonSelectedTimeState();
}

class _ButtonSelectedTimeState extends State<ButtonSelectedTime> {
    @override
    Widget build(BuildContext context) {
        return NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
                overscroll.disallowGlow();
            },
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: this.widget.listCinemaLocation.length,
                itemBuilder: (BuildContext context, int index) {
                    CinemaLocation _cinemaLocation = this.widget.listCinemaLocation[index];

                    return listCinemaLocation(_cinemaLocation);
                }
            ),
        );
    }

    Widget listCinemaLocation(CinemaLocation cinemaLocation) {
        return Container(
            height: 100,
            margin: EdgeInsets.only(bottom: 10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Container(
                        margin: EdgeInsets.only(bottom: 15),
                        padding: EdgeInsets.only(right: 10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                                Text(
                                    '${cinemaLocation.name}',
                                    style: TextStyle(
                                        letterSpacing: 1.2,
                                        fontSize: 16,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w600
                                    ),
                                ),
                                Text(
                                    '${cinemaLocation.distance} ${cinemaLocation.typeDistance}',
                                    style: TextStyle(
                                        letterSpacing: 1.2,
                                        fontSize: 12,
                                        color: Colors.black38,
                                    ),
                                )
                            ],
                        )
                    ),
                    Container(
                        height: 40,
                        margin: EdgeInsets.only(bottom: 15),
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: cinemaLocation.listBookingHours.length,
                            itemBuilder: (BuildContext context, int index) {
                                BookingHour _bookingHour = cinemaLocation.listBookingHours[index];

                                return listBookingHour(_bookingHour);
                            }
                        ),
                    ),
                    Divider(
                        color: Colors.purple,
                        height: 2,
                    )
                ],
            ),
        );
    }

    Widget listBookingHour(BookingHour bookingHour) {
        return Container(
            margin: EdgeInsets.only(right: 10),
            child: FlatButton(
                color: bookingHour.buttonSelectedColor(),
                textColor: bookingHour.textButtonSelectedColor(),
                splashColor: Colors.purple,
                onPressed: () {
                    if (bookingHour.selected) {
                        setState(() {
                            bookingHour.selected = false;
                        });
                    } else {
                        setSelected();
                        setState(() {
                            bookingHour.selected = true;
                        });
                    }
                },
                child: Text(
                    bookingHour.hour
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                        Radius.circular(10)
                    ),
                    side: BorderSide(
                        color: Theme.of(context).primaryColor
                    )
                ),
            ),
        );
    }

    void setSelected() {
        this.widget.listCinemaLocation.forEach((cinemaLocation) {
            cinemaLocation.listBookingHours.forEach((bookingHours) {
                bookingHours.selected = false;
            });
        });
    }
}