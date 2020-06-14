import 'package:intl/intl.dart';

class ListDateTime {
    DateTime dateTime;

    ListDateTime({
        this.dateTime,
    });

    String getDayName() {
        return DateFormat('EE').format(this.dateTime);
    }
}