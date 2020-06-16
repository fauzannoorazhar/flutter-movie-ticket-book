import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeBooking {
    DateTime dateTime;
    bool selected;

    DateTimeBooking({
        this.dateTime,
        this.selected = false
    });

    String getDayName() {
        return DateFormat('EE').format(this.dateTime);
    }

    Color textButtonSelectedColor() {
        if (this.selected) {
            return Colors.white;
        } else {
            return Colors.black;
        }
    }

    Color buttonSelectedColor() {
        if (this.selected) {
            return Colors.purple;
        } else {
            return Colors.white;
        }
    }
}