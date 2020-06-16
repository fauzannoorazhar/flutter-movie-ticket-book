import 'package:flutter/material.dart';
import 'package:mf_movie_ticket_book/models/DateTimeBooking.dart';

class ButtonSelectedDate extends StatefulWidget {
    final List<DateTimeBooking> listDateTimeBooking;
    final Function setUserBookingMovies;

    ButtonSelectedDate({
        @required this.listDateTimeBooking,
        @required this.setUserBookingMovies
    });

    @override
    _ButtonSelectedDateState createState() => _ButtonSelectedDateState();
}

class _ButtonSelectedDateState extends State<ButtonSelectedDate> {
    Color textButtonColor = Colors.black;
    Color colorButton = Colors.white;

    @override
    Widget build(BuildContext context) {
        return NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
                overscroll.disallowGlow();
            },
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: this.widget.listDateTimeBooking.length,
                itemBuilder: (BuildContext context, int index) {
                    DateTimeBooking dateTimeBooking = this.widget.listDateTimeBooking[index];

                    return buttonSeleted(dateTimeBooking, index);
                }
            )
        );
    }

    Widget buttonSeleted(DateTimeBooking dateTimeBooking, int index) {
        return Container(
            height: 85,
            width: 85,
            margin: EdgeInsets.only(right: 10),
            child: FlatButton(
                textColor: dateTimeBooking.textButtonSelectedColor(),
                color: dateTimeBooking.buttonSelectedColor(),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Text(
                            dateTimeBooking.getDayName(),
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                            ),
                        ),
                        SizedBox(height: 5),
                        Text(
                            dateTimeBooking.dateTime.day.toString(),
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                            ),
                        )
                    ],
                ),
                onPressed: () {
                    this.widget.setUserBookingMovies(null, dateTimeBooking);
                    if (dateTimeBooking.selected) {
                        setState(() {
                            dateTimeBooking.selected = false;
                        });
                    } else {
                        setSelectedButton();
                        setState(() {
                            dateTimeBooking.selected = true;
                        });
                    }
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        25
                    ),
                    side: BorderSide(
                        color: Colors.purple,
                    ),
                ),
                highlightColor: Colors.purple,
            )
        );
    }

    void setSelectedButton() {
        this.widget.listDateTimeBooking.forEach((element) {
            element.selected = false;
        });
    }
}